data AVLTree a = Empty | Node (AVLTree a) a (AVLTree a) deriving (Show ,Eq)


contains :: (Eq a, Ord a) => a -> AVLTree a -> Bool
contains a Empty = False
contains a (Node t1 v t2)
    | a == v = True
    | a < v = contains a t1
    | otherwise = contains a t2


smallest :: (Ord a) => AVLTree a -> Maybe a
smallest Empty = Nothing
smallest (Node Empty v t2) = Just v
smallest (Node t1 v t2) = smallest t1


height :: AVLTree a -> Int
height Empty = 0
height (Node l _ r) = 1 + max (height l) (height r)

balance :: AVLTree a -> Int
balance Empty = 0
balance (Node l _ r) = height l - height r

isBalanced :: AVLTree a -> Bool
isBalanced Empty = True
isBalanced t@(Node l _ r) = balanced t && balanced l && balanced r
    where
        balanced tree = b < 2 && b > -2
            where b = balance tree

rotateLeft :: AVLTree a -> AVLTree a
rotateLeft (Node l val (Node rl rval rr)) = Node (Node l val rl) rval rr
rotateLeft tree = tree

rotateRight :: AVLTree a -> AVLTree a
rotateRight (Node (Node ll lval lr) val r ) = Node ll lval (Node lr val r)
rotateRight tree = tree

rebalance :: AVLTree a -> AVLTree a
rebalance Empty = Empty
rebalance t@(Node l val r)
    | b > 1 = if balance l >= 0 then rotateRight t else rotateRight (Node (rotateLeft l) val r)
    | b < (-1) = if balance r <= 0 then rotateLeft t else rotateLeft (Node l val (rotateRight r))
    | otherwise = t
    where b = balance t


insert :: (Ord a, Eq a) => a -> AVLTree a -> AVLTree a
insert val Empty = Node Empty val Empty
insert n t@(Node l val r)
    | val == n = t
    | n < val = rebalance $ Node (insert n l) val r
    | otherwise = rebalance $ Node l val (insert n r)

delete :: (Ord a, Eq a) => a -> AVLTree a -> AVLTree a
delete n Empty = Empty
delete n t@(Node l val r)
    | n == val = 
        case deleted of 
            Nothing -> l
            Just smth -> Node l smth res 
    | n < val = rebalance $ Node (delete n l) val r
    | otherwise = rebalance $ Node l val (delete n r)
    where (deleted, res) = deleteSmallest r 


deleteSmallest :: (Ord a, Eq a) => AVLTree a -> (Maybe a, AVLTree a)
deleteSmallest Empty = (Nothing, Empty)
deleteSmallest (Node Empty val r) = (Just val, r)
deleteSmallest (Node l val r) = (fst res, Node (snd res) val r)
    where res = deleteSmallest l 