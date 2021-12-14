separateSingleDigits :: (Num a, Ord a) => [a] -> ([a], [a])
separateSingleDigits l = (foldr (\x acc -> if x >= 10 || x <= (-10) then x : acc else acc) [] l, foldr (\x acc -> if x < 10 && x > (-10) then x : acc else acc) [] l )
