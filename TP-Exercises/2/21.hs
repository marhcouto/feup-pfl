minimum' :: Ord a => [a] -> a
minimum' [a] = a
minimum' (x:y:xs) = minimum' ((if x < y then x else y):xs)


delete' :: Eq a => a -> [a] -> [a]
delete' e [] = []
delete' e (x:xs) = if x == e then delete' e xs else x : (delete' e xs)

ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort [a] = [a]
ssort (x:xs) = (minimum (x:xs)) : (ssort xs)
