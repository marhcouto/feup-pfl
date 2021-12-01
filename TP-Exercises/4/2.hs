calcPi1 :: Int -> Double
calcPi1 n = sum $ take n $ zipWith (/) (cycle [4, -4]) [1,3 ..]

calcPi1' :: Int -> Double
calcPi1' n = sum [4 * fromIntegral((-1)^i)/fromIntegral(2*i + 1) | i <- [0 .. n - 1]]

calcPi2 :: Int -> Double
calcPi2 n = 3 + (sum $ take (n-1) $ zipWith (/) (cycle [4, -4]) (zipWith (*) [2, 4..] $ zipWith (*) [3, 5..] [4, 6..])) 

calcPi2' :: Int -> Double
calcPi2' n = 3 + sum [4 * fromIntegral((-1)^i)/fromIntegral(product [2*(i+1) .. 2*(i+1)+2]) | i <- [0 .. n - 1]]
