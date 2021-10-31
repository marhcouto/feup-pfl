factorial :: [Eq a, Num a] => a -> a
factorial x = product [1..x]

factorial2 :: [Eq a, Num a] => a -> a
factorial2 0 = 1
factorial2 x
    | x > 0 = x * factorial x-1
    | otherwise = 0
