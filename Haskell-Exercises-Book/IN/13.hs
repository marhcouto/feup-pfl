-- a) Function f will output 1 for any positive numbers given as argument, -1 for any negative numbers and 0 if the argument given is 0


f :: (Ord a, Num a, Integral b) => a -> b
f 0 = 0
f x = if x > 0 then 1 else -1
