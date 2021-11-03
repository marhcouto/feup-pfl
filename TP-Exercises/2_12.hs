import Data.Char

forte :: String -> Bool
forte s = length s >= 8 && or (map isUpper s) && or (map isLower s) && or (map isDigit s)
