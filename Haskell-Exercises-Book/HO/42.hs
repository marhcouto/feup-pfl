myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc l = foldr (flip f) acc $ reverse l

myFoldl' :: (t2 -> t1 -> t2) -> t2 -> [t1] -> t2
myFoldl' f acc l = foldr (\x accF z -> f (accF z) x) id l acc