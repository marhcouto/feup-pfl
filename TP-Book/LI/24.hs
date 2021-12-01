qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort [a] = [a]
qsort [a,b]
    | a < b = [a,b]
    | otherwise = [b,a]
qsort l = qsort (fst lists) ++ [head l] ++ qsort (snd lists)
    where lists = pdivide (head l) l

pdivide :: Ord a => a -> [a] -> ([a], [a])
pdivide n l = ([ x | x <- l, x < n], [ x | x <- l, x > n])
