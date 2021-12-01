mySum :: Num a => [a] -> a
mySum [] = 0
mySum [a] = a
mySum (x:xs) = x + mySum xs

myProduct :: Num a => [a] -> a
myProduct [] = 0
myProduct [a] = a
myProduct (x:xs) = x * myProduct xs
