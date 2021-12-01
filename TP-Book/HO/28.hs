a :: Double
a = sum . map sqrt $ [1..10]
b :: Integer
b = sum $ filter (> 8) $ map (*2) [2 .. 14]
c :: Integer
c = sum . replicate 5 . min 1 $ 3
d :: [Integer]
d = replicate 50 . sum $ map (+3) $ zipWith min [1..5] [4..8]