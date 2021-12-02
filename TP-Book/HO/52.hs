extractDigits :: Integer -> [Integer]
extractDigits = reverse . takeWhile (/= 0) . map (`mod` 10) . iterate (`div` 10)