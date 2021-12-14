myMaximum :: Ord a => [a] -> a
myMaximum l = foldl1 (\x y -> max x y) l

myMinimum :: Ord a => [a] -> a
myMinimum l = foldl1 (\x y -> min x y) l

myFoldr1 :: (b -> b -> b) -> [b] -> b
myFoldl1 :: (a -> a -> a) -> [a] -> a
myFoldl1 f (x:xs) = foldl f x xs
myFoldr1 f l = foldr f (last l) (init l)
