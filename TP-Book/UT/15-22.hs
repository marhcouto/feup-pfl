import Data.Maybe

data BST a = Node a (BST a) (BST a) | Empty deriving Show

contains :: Eq a => a -> BST a -> Bool
contains _ Empty = False
contains val (Node n left right)
    | val == n = True
    | otherwise = contains val left || contains val right


smallest :: Ord a => BST a -> Maybe a
smallest Empty = Nothing
smallest (Node val left right)
    | isNothing small = Just val
    | otherwise = small
    where small = smallest left

insert :: Ord a => a -> BST a -> BST a
insert a Empty = Node a Empty Empty
insert a (Node val l r)
    | a < val = insert val l
    | otherwise = insert val r

delete :: Ord a => a -> BST a -> BST a 
delete _ Empty = Empty
delete a (Node val l r)
    | a == val = case fst deleteSmallestRes of
         Just smth -> Node smth l (snd deleteSmallestRes)
         Nothing -> Empty
    | a < val = Node val (delete a l) r
    | otherwise = Node val l $ delete a r
    where deleteSmallestRes = deleteSmallest r


deleteSmallest :: Ord a => BST a -> (Maybe a, BST a)
deleteSmallest Empty = (Nothing, Empty)
deleteSmallest (Node val Empty r) = (Just val, r)
deleteSmallest (Node val l r) = (fst smallRes, Node val (snd smallRes) r)
    where smallRes = deleteSmallest l

bst2List :: Ord a => BST a -> [a]
bst2List Empty = []
bst2List bst = x : bst2List y
    where (Just x, y) = deleteSmallest bst

isOrdered :: Ord a => BST a -> Bool 
isOrdered bst = fst $ foldl1 (\acc x -> if snd acc < snd x && not (fst acc) then x else (False, snd acc)) (zip (repeat True) $ bst2List bst)

list2Bst :: Ord a => [a] -> BST a
list2Bst [] = Empty
list2Bst xs = Node x (list2Bst xs') (list2Bst xs'')
    where 
        n = div (length xs) 2
        xs' = take n xs
        x:xs'' = drop n xs