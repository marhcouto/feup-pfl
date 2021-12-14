intercalar :: a -> [a] -> [[a]]
intercalar x ys = (x:ys) : intercalarAux x 1 ys

intercalarAux :: a -> Int -> [a] -> [[a]]
intercalarAux x i ys
    | length ys < i = []
    | otherwise = ((take i ys) ++ (x:(drop i ys))) : intercalarAux x (i + 1) ys
