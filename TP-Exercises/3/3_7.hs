(++++) :: [a] -> [a] -> [a]
(++++) l m = foldr (\x acc -> x:acc) m l


myConcat :: [[a]] -> [a]
myConcat l = foldr (++) [] l


myReverse :: [a] -> [a]
myReverse l = foldr (\x acc -> acc ++ [x]) [] l

myReverse' :: [a] -> [a]
myReverse' l = foldl (\acc x -> x:acc) [] l

--Conversão em point-free
myReverse'' :: [a] -> [a]
myReverse'' = foldl (flip (:)) []


myElem :: Eq a => a -> [a] -> Bool
myElem = any . (==) 
