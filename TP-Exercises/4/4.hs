intercalar :: a -> [a] -> [[a]]
intercalar x ys = (x:ys) : intercalarAux x 1 ys

intercalarAux :: a -> Int -> [a] -> [[a]]
intercalarAux x i ys
    | length ys < i = []
    | otherwise = ((take i ys) ++ (x:(drop i ys))) : intercalarAux x (i + 1) ys


perms :: [Int] -> [[Int]]
perms [] = []
perms [c] = [[c]]
perms l = unique (concat ([intercalar (l !! i) possibility | i <- [0 .. n - 1], possibility <- perms (auxList !! i)]))
  where
    auxList = zipWith (\n l -> take n l ++ drop (n + 1) l ) [0 .. n] (replicate n l)
    n = length l

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) = if elem x xs then unique xs else x : (unique xs)
