myAll :: (a -> Bool) -> [a] -> Bool
myAll p [] = True
myAll p (x:xs)
    | p x = myAll p xs
    | otherwise = False

myAll' :: (a -> Bool) -> [a] -> Bool
myAll' p l = and (map p l)

myAll'' :: (a -> Bool) -> [a] -> Bool
myAll'' p l = null (filter p l)