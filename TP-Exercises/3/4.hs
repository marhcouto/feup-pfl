import Data.List

isort :: Ord a => [a] -> [a]
isort l = foldr insert [] l
