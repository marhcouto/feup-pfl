curta :: [a] -> Bool
curta l = length l <= 2

curta2 :: [a] -> Bool
curta2 [] = True
curta2 [_] = True
curta2 [_,_] = True
curta2 _ = False
