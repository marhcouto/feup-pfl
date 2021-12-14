isTriangular :: Float -> Float -> Float -> Bool
isTriangular a b c = (a < b + c) && (c < b + a) && (b < c + a)
