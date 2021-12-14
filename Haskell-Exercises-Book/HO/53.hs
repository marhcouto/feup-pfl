kadane :: Integral a => [a] -> a
kadane = maximum . scanl ((+) . max 0 ) 0