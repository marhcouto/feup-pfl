myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = x && (myAnd xs)

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myElem :: Eq a => a -> [a] -> Bool
myElem a [] = False
myElem a (x:xs) = (x == a) || myElem a xs

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs

myReplicate :: Integral a => a -> b -> [b]
myReplicate 0 _ = []
myReplicate a b
    | a > 0 = b:(myReplicate (a-1) b)
    | otherwise = error "indice negativo"

(@@) :: Integral b => [a] -> b -> a
[] @@ _ = error "index too large"
(x:_) @@ 0 = x
(x:xs) @@ i
    | i > 0 = xs @@ (i - 1)
    | otherwise = error "negative index"

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]
