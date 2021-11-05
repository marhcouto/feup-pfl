seq22 :: Num a => Int -> [a]
seq22 n = 1 : (take (n - 2) (repeat 2)) ++ [1]

seq42 :: Num a => Int -> [a]
seq42 n = 1 : (take (n - 2) (cycle [4,2])) ++ [1]
