type Pos = (Int, Int)

rookMoves :: Pos -> [Pos]
rookMoves p = [(fst p, x) | x <- [1 .. 8]] ++ [(x, snd p) | x <- [1 .. 8] ]

queenMoves :: Pos -> [Pos]
queenMoves p = rookMoves p ++ [(row, col) | dir <- [-1,1], offset <- [-7,-6.. -1] ++ [1..7] , let row = fst p + offset , let col = fst p + offset * dir , row >= 1, row <= 8, col >= 1, col <= 8]