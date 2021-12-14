sortByCond :: [a] -> (a -> a -> Bool) -> [a]
sortByCond [] _ = []
sortByCond [a,b] f = if f a b then [a,b] else [b, a]
sortByCond [a] _ = [a]
sortByCond l f = merge (sortByCond (take half l) f) (sortByCond (drop half l) f) f
    where half = div (length l) 2

merge :: [a] -> [a] -> (a -> a -> Bool) -> [a]
merge [] l _ = l
merge l [] _ = l
merge (x:xs) (y:ys) f = if f x y then x : merge xs (y:ys) f else y : merge (x:xs) ys f 