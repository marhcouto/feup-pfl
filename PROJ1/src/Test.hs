import BigNumber
    ( bnToInt,
      divBN,
      intToBN,
      mulBN,
      output,
      somaBN,
      subBN,
      safeDivBN,
      BigNumber(Neg, Zero, Pos) )
import Test.QuickCheck
    ( (==>), withMaxSuccess, quickCheck, Property )
import Fib
    ( fibRec,
      fibLista,
      fibListaInfinita,
      fibRecBN,
      fibListaBN,
      fibListaInfinitaBN )
import Data.Maybe (isNothing, isJust)

-- BIGNUMBER TESTS
testOutputBN :: IO()
testOutputBN = if and
    [BigNumber.output Zero == "0",
    BigNumber.output (Pos [1,2,3,4,5]) == "12345",
    BigNumber.output (Pos [0,0,1,2,3,4,5]) == "12345",
    BigNumber.output (Neg [1,2,3,4,5]) == "-12345",
    BigNumber.output (Neg [0,0,1,2,3,4,5]) == "-12345"] then putStrLn "Output test passed" else putStrLn "Output test failed"

testBNToInt :: Int -> Bool
testBNToInt n = show n == BigNumber.output (intToBN n)

testIntToBN :: Int -> Bool
testIntToBN n = n == bnToInt (intToBN n)

testSomaBN :: Int -> Int -> Bool
testSomaBN a b = a + b == bnToInt (somaBN (intToBN a) (intToBN b))

testSubBN :: Int -> Int -> Bool
testSubBN a b = a - b == bnToInt (subBN (intToBN a) (intToBN b))

testMulBN :: Int -> Int -> Bool
testMulBN a b = a * b == bnToInt (mulBN (intToBN a) (intToBN b))

testDivBN :: Int -> Int -> Property
testDivBN a b = (a >= 0) && (b > 0) ==> div a b == bnToInt (fst res) && mod a b == bnToInt (snd res)
    where res = divBN (intToBN a) (intToBN b)

testDivBN2 :: Int -> Int -> Bool
testDivBN2 a b = div a b == bnToInt (fst res) && mod a b == bnToInt (snd res)
    where res = divBN (intToBN a) (intToBN b)


-- FIBONACCI TESTS
testFibRec :: Int -> Property
testFibRec n = (n > 2) && (n < 20) ==> fibRec n == fibRec (n-1) + fibRec (n-2)

testFibLista :: Int -> Property
testFibLista n = (n > 2) && (n < 20) ==> fibLista n == fibLista (n-1) + fibLista (n-2)

testFibListaInfinita :: Int -> Property
testFibListaInfinita n = (n > 2) && (n < 20) ==> fibListaInfinita n == fibListaInfinita (n-1) + fibListaInfinita (n-2)

testFibRecBN :: Int -> Property
testFibRecBN n = (n > 2) && (n < 20) ==> fibRecBN m == somaBN (fibRecBN (subBN m (Pos [1]))) (fibRecBN (subBN m (Pos [2])))
    where m = intToBN n

testFibListaBN :: Int -> Property
testFibListaBN n = (n > 2) && (n < 20) ==> fibListaBN m == somaBN (fibListaBN (subBN m (Pos [1]))) (fibListaBN (subBN m (Pos [2])))
    where m = intToBN n

testFibListaInfinitaBN :: Int -> Property
testFibListaInfinitaBN n = (n > 2) && (n < 20) ==> fibListaInfinitaBN m == somaBN (fibListaInfinitaBN (subBN m (Pos [1]))) (fibListaInfinitaBN (subBN m (Pos [2])))
    where m = intToBN n


main :: IO ()
main = do

    -- BigNumber tests
    testOutputBN

    -- Property testing
    quickCheck (withMaxSuccess 100 testBNToInt)
    quickCheck (withMaxSuccess 100 testIntToBN)
    quickCheck (withMaxSuccess 10000 testSomaBN)
    quickCheck (withMaxSuccess 10000 testSubBN)
    quickCheck (withMaxSuccess 10000 testMulBN)
    quickCheck (withMaxSuccess 10000 testDivBN)

    -- Specific tests
    if not (testSomaBN 100 1) then putStrLn "Specific sum test 1 failed" else putStr ""
    if not (testSomaBN 100 (-1)) then putStrLn "Specific sum test 2 failed" else putStr ""
    if not (testSomaBN 1 100) then putStrLn "Specific sum test 3 failed" else putStr ""
    if not (testSomaBN (-100) 1) then putStrLn "Specific sum test 4 failed" else putStr ""
    if not (testSomaBN 97 25) then putStrLn "Specific sum test 5 failed" else putStr ""
    if not (testSomaBN 103241 (-32)) then putStrLn "Specific sum test 6 failed" else putStr ""
    if not (testSomaBN (-103241) (-32)) then putStrLn "Specific sum test 7 failed" else putStr ""
    if not (testSomaBN 150 0) then putStrLn "Specific sum test 8 failed" else putStr ""
    if not (testSomaBN 0 (-231)) then putStrLn "Specific sum test 9 failed" else putStr ""
    if not (testSomaBN 0 0) then putStrLn "Specific sum test 10 failed" else putStr ""
    if not (testSomaBN 1 (-1)) then putStrLn "Specific sum test 11 failed" else putStr ""
    if not (testSomaBN 10 (-100)) then putStrLn "Specific sum test 12 failed" else putStr ""

    if not (testSubBN 10 (-100)) then putStrLn "Specific subtraction test 1 failed" else putStr ""
    if not (testSubBN 20 20) then putStrLn "Specific subtraction test 2 failed" else putStr ""
    if not (testSubBN 100 20) then putStrLn "Specific subtraction test 3 failed" else putStr ""
    if not (testSubBN (-10) (-100)) then putStrLn "Specific subtraction test 4 failed" else putStr ""
    if not (testSubBN 50 20) then putStrLn "Specific subtraction test 5 failed" else putStr ""
    if not (testSubBN 50 100) then putStrLn "Specific subtraction test 6 failed" else putStr ""
    if not (testSubBN 100 (-100)) then putStrLn "Specific subtraction test 7 failed" else putStr ""
    if not (testSubBN 24 3) then putStrLn "Specific subtraction test 8 failed" else putStr ""
    if not (testSubBN 7890 3450) then putStrLn "Specific subtraction test 9 failed" else putStr ""
    if not (testSubBN 9001 983) then putStrLn "Specific subtraction test 10 failed" else putStr ""

    if not (testMulBN 24 3) then putStrLn "Specific multiplication test 1 failed" else putStr ""
    if not (testMulBN 203 24) then putStrLn "Specific multiplication test 2 failed" else putStr ""
    if not (testMulBN 2487 (-3)) then putStrLn "Specific multiplication test 3 failed" else putStr ""
    if not (testMulBN 2 598) then putStrLn "Specific multiplication test 4 failed" else putStr ""
    if not (testMulBN 19 (-54)) then putStrLn "Specific multiplication test 5 failed" else putStr ""
    if not (testMulBN 0 20) then putStrLn "Specific multiplication test 6 failed" else putStr ""
    if not (testMulBN 57 987) then putStrLn "Specific multiplication test 7 failed" else putStr ""
    if not (testMulBN 124 0) then putStrLn "Specific multiplication test 8 failed" else putStr ""
    if not (testMulBN 0 0) then putStrLn "Specific multiplication test 9 failed" else putStr ""
    if not (testMulBN (-251) (-3)) then putStrLn "Specific multiplication test 10 failed" else putStr ""
    if not (testMulBN (-24) 345) then putStrLn "Specific multiplication test 11 failed" else putStr ""

    if not (testDivBN2 24 345) then putStrLn "Specific division test 1 failed" else putStr ""
    if not (testDivBN2 50 5) then putStrLn "Specific division test 2 failed" else putStr ""
    if not (testDivBN2 0 4) then putStrLn "Specific division test 3 failed" else putStr ""
    if not (testDivBN2 42 3) then putStrLn "Specific division test 4 failed" else putStr ""
    if not (testDivBN2 476 25) then putStrLn "Specific division test 5 failed" else putStr ""
    if not (testDivBN2 2024 345) then putStrLn "Specific division test 6 failed" else putStr ""
    if not (testDivBN2 824 142) then putStrLn "Specific division test 7 failed" else putStr ""
    if not (testDivBN2 94 125) then putStrLn "Specific division test 8 failed" else putStr ""
    if not (testDivBN2 234 29) then putStrLn "Specific division test 9 failed" else putStr ""
    if not (testDivBN2 4 9) then putStrLn "Specific division test 10 failed" else putStr ""

    -- Safe Div
    if Data.Maybe.isJust (safeDivBN (Pos [9]) Zero) then putStrLn "Specific safe division test 1 failed" else putStr ""
    if Data.Maybe.isNothing (safeDivBN (Pos [9]) (Pos [3])) then putStrLn "Specific safe division test 2 failed" else putStr ""



    -- Fib tests
    quickCheck (withMaxSuccess 20 testFibRec)
    quickCheck (withMaxSuccess 20 testFibLista)
    quickCheck (withMaxSuccess 20 testFibListaInfinita)
    quickCheck (withMaxSuccess 20 testFibRecBN)
    quickCheck (withMaxSuccess 20 testFibListaBN)
    quickCheck (withMaxSuccess 20 testFibListaInfinitaBN)

