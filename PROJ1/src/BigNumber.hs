module BigNumber
    ( BigNumber (Pos, Neg, Zero), scanner, output, somaBN, subBN, mulBN, divBN, intToBN, bnToInt, safeDivBN, finiteListGenBN, infinitListGenBN, indexListBN
    ) where

import Data.Char

data BigNumber = Pos [Int] | Neg [Int] | Zero deriving (Eq, Show)

data Compar = Bigger | Smaller | Equal deriving Eq

--SCANNER
scanner :: String -> BigNumber
scanner "" = error "Cannot convert empty string to BigNumber"
scanner (y:ys)
    | y == '-' = Neg [ x | c <- ys, let x = digitToInt c, x <= 9 && x >= 0]
    | (y:ys) == "0" = Zero
    | otherwise = Pos [ x | c <- y:ys, let x = digitToInt c, x <= 9 && x >= 0]


-- OUTPUT
output :: BigNumber -> String
output (Pos list) = dropWhile (== '0') [ intToDigit x | x <- list]
output (Neg list) = '-': dropWhile (== '0')[ intToDigit x | x <- list]
output Zero = "0"


-- SUM

-- Signal treatment
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN bn Zero = bn
somaBN Zero bn = bn
somaBN (Pos list1) (Pos list2) = Pos (somaBNaux 0 list1 list2)
somaBN (Neg list1) (Neg list2) = Neg (somaBNaux 0 list1 list2)
somaBN (Pos list1) (Neg list2) = subBN (Pos list1) (Pos list2)
somaBN (Neg list1) (Pos list2) = somaBN (Pos list2) (Neg list1) -- Comutativity

-- Auxiliary function for actual calculations
somaBNaux :: Int -> [Int] -> [Int] -> [Int]
somaBNaux 0 [] b = b
somaBNaux 0 a [] = a
somaBNaux inc [] [] = [inc]
somaBNaux inc [] b = somaBNaux (div soma 10) [] (init b) ++ [mod soma 10]
    where
        soma = last b + inc
somaBNaux inc a [] = somaBNaux (div soma 10) (init a) [] ++ [mod soma 10]
    where
        soma = last a + inc
somaBNaux inc a b = somaBNaux (div soma 10) (init a) (init b) ++ [mod soma 10]
    where
        soma = last a + last b + inc

----------------------------------------------------------------------------------------------------------------------------------

-- SUBTRACTION

-- Main function just to detect list of length 0
subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b = if lengthBN res > 0 then res else Zero
    where 
        res = subBNaux2 a b
        lengthBN (Pos list) = length list
        lengthBN (Neg list) = length list
        lengthBN Zero = 0

-- Signal treatment
subBNaux2 :: BigNumber -> BigNumber -> BigNumber
subBNaux2 bn Zero = bn
subBNaux2 Zero bn = symmetricBN bn
subBNaux2 (Pos list1) (Pos list2)
    | compareBN list1 list2 == Bigger = Pos (subBNaux 0 list1 list2)
    | compareBN list1 list2 == Smaller = Neg (subBNaux 0 list2 list1)
    | compareBN list1 list2 == Equal = Zero
    | otherwise = error "Unexpected value in comparison of big numbers"
subBNaux2 (Neg list1) (Neg list2) = subBN (Pos list2) (Pos list1)
subBNaux2 (Pos list1) (Neg list2) = somaBN (Pos list1) (Pos list2)
subBNaux2 (Neg list1) (Pos list2) = somaBN (Neg list1) (Neg list2)

-- Auxiliary function for actual calculations
subBNaux :: Int -> [Int] -> [Int] -> [Int]
subBNaux 0 [] b = b
subBNaux 0 a [] = a
subBNaux inc [] [] = [inc]
subBNaux inc [] b = subBNaux (abs (div sub 10)) (init b) [] ++ [mod sub 10]
    where sub = - last b - inc
subBNaux inc a [] = subBNaux (abs (div sub 10)) (init a) [] ++ [mod sub 10]
    where sub = last a - inc
subBNaux inc a b = dropWhile (== 0) (subBNaux (abs (div sub 10)) (init a) (init b) ++ [mod sub 10])
    where
        sub = last a - last b - inc

---------------------------------------------------------------------------------------------------------------------------------

-- MULTIPLICATION

-- Signal treatment
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN _ Zero = Zero
mulBN Zero _ = Zero
mulBN (Pos list1) (Pos list2) = Pos (mulBNaux list1 list2)
mulBN (Pos list1) (Neg list2) = Neg (mulBNaux list1 list2)
mulBN (Neg list1) (Pos list2) = Neg (mulBNaux list1 list2)
mulBN (Neg list1) (Neg list2) = Pos (mulBNaux list1 list2)

-- Sums the results of the multiplications made in mulBNaux2
mulBNaux :: [Int] -> [Int] -> [Int]
mulBNaux [] _ = []
mulBNaux _ [] = []
mulBNaux a b = somaBNaux 0 (mulBNaux2 0 a (last b)) (mulBNaux (a ++ [0]) (init b))

-- Multiplies a digit of one number by all the digits in the other number
mulBNaux2 :: Int -> [Int] -> Int -> [Int]
mulBNaux2 0 [] _ = []
mulBNaux2 0 _ 0 = []
mulBNaux2 inc [] _ = [inc]
mulBNaux2 inc _ 0 = [inc]
mulBNaux2 inc a b = mulBNaux2 (div mul 10) (init a) b ++ [mod mul 10]
    where
        mul = b * last a + inc

----------------------------------------------------------------------------------------------------------------------------------

-- DIVISION

-- Signal treatment
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN _ Zero = error "Division by zero"
divBN Zero _ = (Zero, Zero)
divBN (Pos list1) (Pos list2) = let res = divBNaux [0] list1 list2 in (Pos (fst res), Pos (snd res))
divBN (Pos list1) (Neg list2) = let res = divBNaux [0] list1 list2 in (Neg (fst res), Pos (snd res))
divBN (Neg list1) (Pos list2) = let res = divBNaux [0] list1 list2 in (Neg (fst res), Pos (snd res))
divBN (Neg list1) (Neg list2) = let res = divBNaux [0] list1 list2 in (Pos (fst res), Pos (snd res))

-- Performs multiple subtractions until the dividend is smaller than the divisor 
divBNaux :: [Int] -> [Int] -> [Int] -> ([Int], [Int])
divBNaux quoc _ [] = error "Empty list in divBNaux"
divBNaux quoc a b
    | compareBN a b == Smaller = (quoc, a)
    | otherwise = res
    where res = divBNaux (somaBNaux 0 quoc [1]) (subBNaux 0 a b) b


-- SAFE DIVISION
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN _ Zero = Nothing
safeDivBN Zero _ = Just (Zero, Zero)
safeDivBN (Pos list1) (Pos list2) = let res = divBNaux [0] list1 list2 in Just (Pos (fst res), Pos (snd res))
safeDivBN (Pos list1) (Neg list2) = let res = divBNaux [0] list1 list2 in Just (Neg (fst res), Pos (snd res))
safeDivBN (Neg list1) (Pos list2) = let res = divBNaux [0] list1 list2 in Just (Neg (fst res), Pos (snd res))
safeDivBN (Neg list1) (Neg list2) = let res = divBNaux [0] list1 list2 in Just (Pos (fst res), Pos (snd res))

----------------------------------------------------------------------------------------------------------------------------------

-- OTHER

-- NEEDED FOR TESTING
intToBN :: Int -> BigNumber
intToBN n
    | n == 0 = Zero
    | n < 0 = Neg (reverse (intToList (-n)))
    | otherwise = Pos (reverse (intToList n))

intToList :: Int -> [Int]
intToList 0 = []
intToList x = mod x 10 : intToList (div x 10)

bnToInt :: BigNumber -> Int
bnToInt Zero = 0
bnToInt (Pos l) = listToInt (dropWhile (== 0) l)
bnToInt (Neg l) = -(listToInt (dropWhile (== 0) l))

listToInt :: [Int] -> Int
listToInt [] = 0
listToInt l = last l + 10 * listToInt (init l)


-- NEEDED FOR SUBTRACTION

-- Returns the symmetric
symmetricBN :: BigNumber -> BigNumber
symmetricBN (Pos list1) = Neg list1
symmetricBN (Neg list1) = Pos list1
symmetricBN Zero = Zero

-- Compares two lists representing BigNumbers
compareBN :: [Int] -> [Int] -> Compar
compareBN list1 list2
    | length list1 > length list2 = Bigger
    | length list1 < length list2 = Smaller
    | otherwise = compareBNaux list1 list2

compareBNaux :: [Int] -> [Int] -> Compar
compareBNaux [] [] = Equal
compareBNaux [] _ = error "Lists with unequal length in 'greaterThanBNaux'"
compareBNaux _ [] = error "Lists with unequal length in 'greaterThanBNaux'"
compareBNaux (x:xs) (y:ys)
    | x > y = Bigger
    | x < y = Smaller
    | otherwise = compareBNaux xs ys



-- NEEDED FOR FIBONACCI

-- Generates infinit list of BN
infinitListGenBN :: BigNumber -> [BigNumber]
infinitListGenBN bn = bn : infinitListGenBN (somaBN bn (Pos [1]))

-- Generates finite list of BN
finiteListGenBN :: BigNumber -> BigNumber -> [BigNumber]
finiteListGenBN (Pos list1) (Pos list2)
    | compareBN list1 list2 == Smaller = Pos list1 : finiteListGenBN (somaBN (Pos list1) (Pos [1])) (Pos list2)
    | otherwise = [Pos list2]
finiteListGenBN _ _ = error "finiteListGenBN only accepts positive arguments"

-- Indexes elemnts on a list using a BigNumber as index
indexListBN :: BigNumber -> [BigNumber] -> BigNumber
indexListBN Zero list = head list
indexListBN (Pos bn) list = indexListBN (subBN (Pos bn) (Pos [1])) (tail list)
indexListBN _ _ = error "indexListBN only accepts positive indexes"

