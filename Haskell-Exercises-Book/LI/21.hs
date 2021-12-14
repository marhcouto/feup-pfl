import Data.List

isort :: Ord a => [a] -> [a]
isort [] = []
isort l = insert (last l) (isort (init l))
