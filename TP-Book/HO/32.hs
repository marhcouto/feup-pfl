myMap :: (a -> a) -> [a] -> [a]
myMap f = foldr (\x acc -> (:) (f x) acc) []