factores :: Int -> [Int]
factores n
    | elem (toInteger n) (take n primos) = [n]
    | otherwise = let factor = factoresAux n primos in factor : factores (div n factor)

factoresAux :: Int -> [Integer] -> Int
factoresAux n (x:xs)
    | mod n (fromIntegral x) == 0 = fromIntegral x
    | otherwise = factoresAux n xs


crivo :: [Integer] -> [Integer]
crivo (p:xs) = p : crivo [x | x<-xs, mod x p /=0]

primos :: [Integer]
primos = crivo [2..]
