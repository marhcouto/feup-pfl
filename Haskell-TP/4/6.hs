binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

binom2 :: Integer -> Integer -> Integer
binom2 n k
    | k < (n-k) = div (product [(n-k+1)..n]) (product [1..k])
    | otherwise = div (product [(k+1)..n]) (product [1..(n-k)])

binom3 :: Integer -> Integer -> Integer
binom3 n k
    | k == 0 || n == k = 1
    | otherwise = binom3 (n - 1) (k - 1) + binom3 (n - 1) (k)

pascal :: [[Int]]
pascal = [ [fromInteger (binom (fromIntegral n) (fromIntegral k)) | k <- [0 .. n] ] | n <- [0 ..] ]

pascal2 :: [[Int]]
pascal2 = [ [fromInteger (binom3 (fromIntegral n) (fromIntegral k)) | k <- [0 .. n] ] | n <- [0 ..] ]
