myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl f acc [] = [acc]
myScanl f acc (x:xs) = acc : myScanl f (f acc x) xs 

myScanl' :: (a -> b -> a) -> a -> [b] -> [a]
myScanl' f acc = foldl (\acc x -> acc ++ [f (last acc) x]) [acc]