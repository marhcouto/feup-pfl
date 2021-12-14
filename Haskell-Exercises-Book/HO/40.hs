myScanr :: (a -> b -> b) -> b -> [a] -> [b]
myScanr f acc [] = [acc]
myScanr f acc l = myScanr f res (init l) ++ [acc]
    where res = f (last l) acc

myScanr' :: (a -> b -> b) -> b -> [a] -> [b]
myScanr' f acc = foldr (\x (y:ys) -> f x y : y : ys) [acc]