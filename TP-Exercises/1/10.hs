classifica :: Float -> Float -> String
classifica weight height
    | bmc <= 18.5 = "baixo peso"
    | bmc > 18.5 && bmc <= 25 = "peso normal"
    | bmc > 12 && bmc <= 30 = "excesso de peso"
    | bmc > 30 = "obesidade"
    | otherwise = "-"
    where bmc = weight / (height**2)
