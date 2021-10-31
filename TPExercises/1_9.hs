classifica :: Int -> String
classifica nota
    | nota <= 9 = "reprovado"
    | nota > 9 && nota <= 12 = "suficiente"
    | nota > 12 && nota <= 15 = "bom"
    | nota > 15 && nota <= 18 = "muito bom"
    | nota > 18 && nota <= 20 = "muito bom com distincao"
    | otherwise = "-"

classifica' :: Int -> [Char]
classifica' nota = if nota <= 9 then "reprovado" else
    if nota > 9 && nota <= 12 then "suficiente" else
    if nota > 12 && nota <= 15 then "bom" else
    if nota > 15 && nota <= 18 then "muito bom" else
    if nota > 18 && nota <= 20 then "muito bom com distincao" else
    "-"
