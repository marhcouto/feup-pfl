module Fib (fibRec, fibLista, fibListaInfinita, fibRecBN, fibListaBN, fibListaInfinitaBN) where


import BigNumber
    ( finiteListGenBN,
      somaBN,
      subBN,
      BigNumber(Pos, Zero),
      indexListBN,
      infinitListGenBN ) 

-- Normal versions

fibRec :: Integral a => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n - 1) + fibRec (n - 2)


fibLista :: Integral a => a -> a
fibLista 0 = 0
fibLista 1 = 1
fibLista n = last listaFib
    where listaFib = 0 : 1 : [ listaFib !! (x - 1) + listaFib !! (x - 2) | x <- [2 .. fromIntegral n] ] 


fibListaInfinita :: Integral a => a -> a
fibListaInfinita 0 = 0
fibListaInfinita 1 = 1
fibListaInfinita n = infiniFib !! fromIntegral n
    where infiniFib = 0 : 1 : zipWith (+) infiniFib (tail infiniFib)


-- BigNumber versions

fibRecBN :: BigNumber -> BigNumber 
fibRecBN Zero = Zero
fibRecBN (Pos [1]) = Pos [1]
fibRecBN bn = somaBN (fibRecBN (subBN bn (Pos [1]))) (fibRecBN (subBN bn (Pos [2])))


fibListaBN :: BigNumber -> BigNumber
fibListaBN Zero = Zero 
fibListaBN (Pos [1]) = Pos [1]
fibListaBN bn = last listFibBN
    where listFibBN = Zero : Pos [1] : [ somaBN (indexListBN (subBN x (Pos [1])) listFibBN) (indexListBN (subBN x (Pos [2])) listFibBN) | x <- finiteListGenBN (Pos [2]) bn]


fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN Zero = Zero 
fibListaInfinitaBN (Pos [1]) = Pos [1]
fibListaInfinitaBN bn = indexListBN bn infiniFibBN
    where infiniFibBN = Zero : Pos [1] : zipWith somaBN infiniFibBN (tail infiniFibBN)

