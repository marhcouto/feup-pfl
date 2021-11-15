dropN :: Integral a => [a] -> a -> [a]
dropN l n = [x | (x,i) <- zip l [0..], mod i n == 0]
