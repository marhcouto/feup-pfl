algarismos :: Int -> [Int]
algarismos 0 = []
algarismos n = algarismos (div n 10) ++ [mod n 10]
