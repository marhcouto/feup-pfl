distance2 :: Floating a => (a, a) -> (a, a) -> a
distance2 (x, y) (n, m) = sqrt ( (x - n) ** 2 + (y - m) **2)

distanceInf :: (Floating a, Ord a) => (a, a) -> (a, a) -> a
distanceInf (ax, ay) (bx, by) = max (abs (ax - bx)) (abs (ay - by))
