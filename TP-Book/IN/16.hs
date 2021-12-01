nPower :: (Ord t, Num t, Fractional a) => a -> t -> a
nPower m n
    | n == 1 = m
    | n > 0 = m* nPower (m) (n-1)
    | otherwise = 1/ (m * (nPower (m) (-n-1)))
