import Data.Char

cifraChave :: String -> String -> String
cifraChave s key = zipWith cifra s (take (length s) (cycle key))


cifra :: Char -> Char -> Char
cifra c key
    | val > 64 && val < 91 = chr (mod ((val - 65) + (ord key - 65)) 26 + 65)
    | val > 96 && val < 123 = chr (mod ((val - 97) + (ord key - 65)) 26 + 97)
    | otherwise = c
    where
        val = ord c
