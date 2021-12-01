myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile f [] = []
myTakeWhile f (x:xs)
    | f x = x : myTakeWhile f xs
    | otherwise = []


myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile f [] = []
myDropWhile f (x:xs)
    | f x = myTakeWhile f xs
    | otherwise = x:xs