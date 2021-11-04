fromBits :: [Int] -> Int
fromBits [] = 0
fromBits l = last l + 2 * fromBits (init l)
