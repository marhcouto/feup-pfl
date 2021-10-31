safetail :: [a] -> [a]
safetail [] = []
safetail l = tail l

safetail' :: [a] -> [a]
safetail' l
    | length l == 0 = []
    | otherwise = tail l

safetail'' :: [a] -> [a]
safetail'' l = case l of
    [] -> []
    _ -> tail l
