max3, min3 :: Ord a => a -> a -> a -> a
max3 a b c = max a (max b c)
min3 a b c = min a (min b c)

max3', min3' :: Ord a => a -> a -> a -> a
max3' a b c
    | a > b && a > c = a
    | b > c = b
    | otherwise = c
min3' a b c
    | a < b && a < c = a
    | b < c = b
    | otherwise = c
