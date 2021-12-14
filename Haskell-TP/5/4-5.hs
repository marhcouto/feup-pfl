
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
union (Node val left right) b = union left (union right res)
    where res = if member val b then b else insert val b


intersect :: Ord a => Set a -> Set a -> Set a
intersect _ Empty = Empty
intersect Empty _ = Empty
intersect a b = intersectAux a b Empty

intersectAux :: Ord a => Set a -> Set a -> Set a -> Set a
intersectAux Empty _ res = error "First set empty"
intersectAux a (Node val l r) res
    | member val a && not (member val res) = intersectAux a l (intersectAux a r (insert val res))
    | otherwise = intersectAux a l (intersectAux a r res)
intersectAux a Empty res = res


difference :: Ord a => Set a -> Set a -> Set a 
difference Empty _ = Empty
difference a Empty = a
difference a b = differenceAux b a Empty

differenceAux :: Ord a => Set a -> Set a -> Set a -> Set a
differenceAux Empty _ res = error "First set empty"
differenceAux a (Node val l r) res
    | not (member val a || member val res) = differenceAux a l (differenceAux a r (insert val res))
    | otherwise = differenceAux a l (differenceAux a r res)
differenceAux a Empty res = res
