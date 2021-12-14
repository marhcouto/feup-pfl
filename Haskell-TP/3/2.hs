dec2int :: [Int] -> Int
dec2int l = foldl (\acc x -> acc * 10 + x) 0 l
