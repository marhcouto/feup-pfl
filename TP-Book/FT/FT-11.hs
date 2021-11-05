evaluateLength :: [a] -> String
evaluateLength l
    | len == 0 || len == 1 = "short"
    | len == 2 || len == 3 = "medium-sized"
    | len >= 4 = "long"
    | otherwise = error "list length is negative"
    where len = length l

evaluateLength' :: [a] -> String
evaluateLength' [] = "short"
evaluateLength' [a, b] = "short"
evaluateLength' [a, b, c] = "medium-sized"
evaluateLength' l = "long"
