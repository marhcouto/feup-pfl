aprox :: Int -> Double
aprox n = 4 * aproxAux n

aproxAux :: Int -> Double
aproxAux 0 = 1
aproxAux n = fromIntegral (((-1)^2)) / fromIntegral (2*n + 1) + aproxAux (n - 1)
