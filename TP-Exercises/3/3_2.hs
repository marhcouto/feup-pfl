dec2int :: [Int] -> Int
dec2int l = foldl times 0 l

times :: Int -> Int -> Int
times x y = x * 10 + y
