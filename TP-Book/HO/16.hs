myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f [] = []
myFilter f (x:xs)
    | f x = x : myFilter f xs
    | otherwise = myFilter f xs