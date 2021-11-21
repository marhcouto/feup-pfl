intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' _ [a] = [a]
intersperse' v (x:xs) = x : v : (intersperse' v xs)
