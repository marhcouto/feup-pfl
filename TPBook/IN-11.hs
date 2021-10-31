max3 :: Ord a => a -> a -> a -> a
max3 a b c
    | a > b && a > c = a
    | b > c = b
    | otherwise = c

    
