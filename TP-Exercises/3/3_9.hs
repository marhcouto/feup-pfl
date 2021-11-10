myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl f acc [] = [(foldl f acc [])]
myScanl f acc l = (myScanl f acc (init l)) ++ [(foldl f acc l)]

myScanl' :: (b -> a -> b) -> b -> [a] -> [b]
myScanl' f acc [] = [acc]
myScanl' f acc (x:xs) = acc : myScanl' f (f acc x) xs
