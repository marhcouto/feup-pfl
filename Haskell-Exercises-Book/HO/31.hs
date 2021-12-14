myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\e acc -> if f e then e : acc else acc) [] 