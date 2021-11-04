mindiv :: Int -> Int
mindiv n = head ([ x | let p = round (sqrt (fromIntegral n)), x <- [2 .. p], mod n x == 0 ] ++ [n])

primo' :: Int -> Bool
primo' n = mindiv n == n
