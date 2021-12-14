type Pair a = (a,a)
type Relation a = [Pair a]

isReflexive :: Eq a => Relation a -> Bool
isReflexive rel = all (\x -> elem (snd x, fst x) rel) rel

isTransitive :: Eq a => Relation a -> Bool
isTransitive rel = all (isTransitiveAux rel 0) rel

isTransitiveAux :: Eq a => Relation a -> Int -> Pair a -> Bool
isTransitiveAux r i p
    | i >= length r = True
    | fst (r !! i) == snd p = elem (fst p, snd (r !! i)) r && isTransitiveAux r (i + 1) p
    | otherwise = isTransitiveAux r (i + 1) p