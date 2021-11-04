myMinimum :: Ord p => [p] -> p
myMinimum [] = error "empty list"
myMinimum [a,b] = if a < b then a else b
myMinimum (x:xs) = if x < m then x else m where m = myMinimum xs
