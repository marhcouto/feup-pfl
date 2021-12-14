data Country = Ct { name :: String, area :: Float, pop :: Float, continent :: String }

populateDensity :: Country -> Float
populateDensity (Ct _ area pop _) = pop / area

countContinent :: [Country] -> String -> Int 
countContinent [] _ = 0
countContinent ((Ct _ _ _ continent):xs) cont
    | continent == cont = countContinent xs cont + 1
    | otherwise = countContinent xs cont


