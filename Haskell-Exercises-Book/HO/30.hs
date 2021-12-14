-- a)
myReverse :: [a] -> [a]
myReverse = foldr (\x y -> y ++ [x]) []

-- b)
myReverse' :: [a] -> [a]
myReverse'= foldl(\x y -> y : x) []