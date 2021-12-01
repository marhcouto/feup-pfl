import Data.List

data UniqList a = UList [a]

push :: Eq a => UniqList a -> a -> UniqList a
push (UList []) item = UList [item]
push (UList list) item
    | item `elem` list = UList list
    | otherwise = UList (list ++ [item])

delete :: Eq a => UniqList a -> a -> UniqList a 
delete (UList []) _ = UList []
delete (UList list ) item
    | item `elem` list = UList (Data.List.delete item list)
    | otherwise = UList list