mapFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapFilter f p l = map f (filter p l) 
