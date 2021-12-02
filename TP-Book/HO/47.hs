f :: [a] -> [a] -> [a]
f = flip $ foldr (:)