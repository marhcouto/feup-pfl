binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

binom2 :: Integer -> Integer -> Integer
binom2 n k
    | k < (n-k) = div (product [(n-k+1)..n]) (product [1..k])
    | otherwise = div (product [(k+1)..n]) (product [1..(n-k)])
