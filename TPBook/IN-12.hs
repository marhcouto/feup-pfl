testBMI :: (Ord a, Fractional a) => a -> a -> [Char]
testBMI w h
    | bmi < 18.5 = "underweight"
    | bmi >= 18.5 && bmi < 25.0 = "healthy weight"
    | bmi >= 25.0 && bmi < 30.0 = "over-weight"
    | otherwise = "obese"
    where bmi = w / h^2
