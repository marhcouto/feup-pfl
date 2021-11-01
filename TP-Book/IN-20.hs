isPrime :: Integral t => t -> Bool
isPrime 1 = False
isPrime n = not (any ((\x y -> mod x y == 0) n) [2..n - 1])
