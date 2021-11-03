binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

pascal :: Integer -> [[Integer]]
pascal m = [ l | n <- [0 .. m], let l = [ binom n k | k <- [0 .. n] ] ]
