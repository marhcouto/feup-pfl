min3 :: Ord a => a -> a -> a -> a
min3 a b c
    | a < b && a < c = a
    | b < c = b
    | otherwise = c
