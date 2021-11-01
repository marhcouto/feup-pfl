myGcd :: Integral a => a -> a -> a
myGcd a b
    | b == 0 = abs a
    | otherwise = gcd b (mod a b)
