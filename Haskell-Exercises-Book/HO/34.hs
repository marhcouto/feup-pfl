fuseDigits :: Num a => [a] -> a
fuseDigits = foldl (\acc x -> acc * 10 + x) 0