type Pos = (Int, Int)

rookMoves :: Pos -> [Pos]
rookMoves p = [(fst p, x) | x <- [1 .. 8]] ++ [(x, snd p) | x <- [1 .. 8] ]

