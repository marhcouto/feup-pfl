myLength :: Num p => [a] -> p
myLength [] = 0
myLength (_:xs) = 1 + myLength xs
