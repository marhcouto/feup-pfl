
data Set a = Node a (Set a) (Set a) | Empty deriving Show

empty :: Set a
empty = Empty

insert :: Ord a => a -> Set a -> Set a
insert a Empty = Node a Empty Empty
insert a (Node b esq dir) 
    | a < b = Node b (insert a esq) dir
    | a > b = Node b esq (insert a dir)
    | otherwise = Node b esq dir


member :: Ord a => a -> Set a -> Bool
member a Empty = False 
member a (Node b esq dir) 
    | a < b = member a esq
    | a == b = True 
    | otherwise = member a dir

union :: Ord a => Set a -> Set a -> Set a
union a Empty = a
union Empty b = b
union (Node val left right) b = union (union left res) (union right res)
    where res = if member val b then b else insert val b

