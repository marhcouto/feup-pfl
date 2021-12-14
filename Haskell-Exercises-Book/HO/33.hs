largePairs :: (Ord a, Num a) => a -> [(a, a)] -> [(a, a)]
largePairs t = foldr (\x acc -> if uncurry (+) x >= t then x : acc else acc ) []
