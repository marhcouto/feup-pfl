five :: (Eq a, Num a)=> a -> [Char]
five' :: (Eq a, Num a)=> a -> [Char]
five'' :: (Eq a, Num a)=> a -> [Char]
five''' :: (Eq a, Num a)=> a -> [Char]
-- version with if-then-else
five n = if n == 5 then "five" else "not five"
-- version with guards
five' n
    | n == 5 = "five"
    | otherwise = "not five"
-- version with pattern matching
five'' 5 = "five"
five'' _ = "not five"
-- version with case expression
five''' n = case n of 
    5 -> "five"
    _ -> "not five"
