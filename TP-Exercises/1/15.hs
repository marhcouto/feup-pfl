mediana :: Ord a => a -> a -> a -> a
mediana a b c
    | a > b && a < c = a
    | c < b = c
    | otherwise = b

mediana' :: (Ord a, Num a) => a -> a -> a -> a
mediana' a b c = a + b + c - max a (max b c) - min a (min b c)
