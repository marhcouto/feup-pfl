toBits :: Int -> [Int]
toBits 0 = []
toBits n = toBits (div n 2) ++ [mod n 2]
