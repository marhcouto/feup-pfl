kadane :: Integral a => [a] -> a
kadane = maximum . scanl (\acc x -> max x $ x + acc) 0