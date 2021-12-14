testPh :: (Ord a, Floating a) => a -> [Char]
testPh ah
    | ph <= 7.0 = "acid"
    | ph == 7.0 = "neutral"
    | ph >= 7.0 = "basic"
    | otherwise = error "Invalid pH"
    where ph = -logBase 10 ah
