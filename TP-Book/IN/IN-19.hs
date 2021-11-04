pascal :: (Ord a, Num a) => a -> a -> a
pascal n k
    | k > 1 && k < n = pascal (n - 1) (k - 1) + pascal (n - 1) k
    | k == n || k == 1 = 1
    | otherwise error "invalid argument"
