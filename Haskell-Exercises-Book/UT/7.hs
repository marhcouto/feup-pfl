import qualified Data.Maybe
type HashMap k v = [(k,v)]


lookup :: Eq k => HashMap k v -> k -> Maybe v
lookup [] k = Nothing
lookup (x:xs) k
    | fst x == k = Just $ snd x
    | otherwise = Main.lookup xs k

areEqual :: (Eq k, Eq v) => HashMap k v -> HashMap k v -> Bool
areEqual h1 h2 = length h1 == length h2 && areEqualAux h1 h2
    where
        areEqualAux [] _ = True
        areEqualAux (x:xs) h2
            | elem x h2 = areEqualAux xs h2
            | otherwise = False

ceilingKey :: Ord k => HashMap k v -> k -> Maybe k
ceilingKey hm k = ceilingKeyAux hm k Nothing

ceilingKeyAux :: Ord k => HashMap k v -> k -> Maybe k -> Maybe k
ceilingKeyAux [] _ k2 = k2
ceilingKeyAux (x:xs) k1 (Just k2)
    | k1 <= fst x && k2 > fst x = ceilingKeyAux xs k1 $ Just $ fst x
    | otherwise = ceilingKeyAux xs k1 $ Just k2
ceilingKeyAux (x:xs) k1 Nothing
    | k1 <= fst x = ceilingKeyAux xs k1 $ Just $ fst x
    | otherwise = ceilingKeyAux xs k1 Nothing