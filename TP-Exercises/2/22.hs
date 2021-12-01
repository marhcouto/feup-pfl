merge :: Ord a => [a] -> [a] -> [a]
merge l [] = l
merge [] l = l
merge (x:xs) (y:ys) = if x < y then x : merge xs (y:ys) else y : merge xs (y:ys)

metades :: [a] -> ([a],[a])
metades myList = splitAt (div (length myList) 2) myList

msort :: Ord a => [a] -> [a]
msort [] = []
msort [a] = [a]
msort [a, b] = if a < b then [a, b] else [b, a]
msort l = let met = metades l in merge (msort (fst met)) (msort (snd met))
