
newtype Set a = Set (a -> Bool)

member :: a -> Set a -> Bool
member a (Set f) = f a

union :: Set a -> Set a -> Set a
union (Set f1) (Set f2) = Set (\x -> f1 x || f2 x)

intersect :: Set a -> Set a -> Set a
intersect (Set f1) (Set f2) = Set (\x -> f1 x && f2 x)

difference :: Set a -> Set a -> Set a
difference (Set f1) (Set f2) = Set (\x -> f1 x && not (f2 x))


