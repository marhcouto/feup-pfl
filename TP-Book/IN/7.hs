isTriangular :: (Num a, Ord a) => a -> a -> a -> Bool
isTriangular a b c = (a < b + c) && (c < b + a) && (b < c + a)

isPythagorean :: (Num a, Eq a) => a -> a -> a -> Bool
isPythagorean a b c
    | a^2 == b^2 + c^2 = True
    | c^2 == b^2 + a^2 = True
    | b^2 == c^2 + a^2 = True
    | otherwise = False
