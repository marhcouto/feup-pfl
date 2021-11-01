tens = ["dez", "vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]
hundreds = ["cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"]
numbers = ["um", "dois", "tres", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez", "onze", "doze", "treze", "catorze", "quinze", "dezasseis", "dezassete", "dezoito", "dezanove"]

getTen :: Int -> String
getHundred :: Int -> String
converte :: Int -> String

getTen n
    | n > 99 = "error"
    | n > 19 && mod n 10 == 0 = ten
    | n > 19 && mod n 10 /= 0 = ten ++ " e " ++ num
    | otherwise = numbers !! (n - 1)
    where
        ten = tens !! ((div n 10) - 1)
        num = numbers !! ((mod n 10) - 1)

getHundred n
    | n > 999 = "error"
    | n == 100 = "cem"
    | n > 99 && mod n 100 == 0 = hundred
    | n > 99 && mod n 100 /= 0 = hundred ++ " e " ++ ten
    | otherwise = getTen n
    where
        hundred = hundreds !! ((div n 100) - 1)
        ten = getTen (mod n 100)

converte n
    | n > 1000000 = "Number too big"
    | n == 1000000 = "um milhao"
    | n > 999 && mod n 1000 /= 0 = thousand ++ " mil e " ++ hundred
    | n > 999 && mod n 1000 == 0 = thousand ++ " mil"
    | otherwise = getHundred n
    where
        thousand = getHundred (div n 1000)
        hundred = getHundred(mod n 1000)
