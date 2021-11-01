ackermann :: (Num a, Num t, Ord a, Ord t) => a -> t -> t
ackermann m n
    | m == 0 = n + 1
    | m > 0 && n == 0 = ackermann (m-1) 1
    | m > 0 && n > 0 = ackermann (m-1) (ackermann m (n-1))
    | otherwise error "negative argument"
