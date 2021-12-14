import Data.Char

palavras :: String -> [String]
palavras = palavrasaux []

palavrasaux :: [String] -> String -> [String]
palavrasaux l "" = reverse l
palavrasaux l s = palavrasaux (firstWord : l) (if length rest > 0 then tail rest else "")
    where
        firstWord = takeWhile (\ch -> ch /= ' ') s
        rest = dropWhile (\ch -> ch /= ' ') s

despalavras :: [String] -> String
despalavras l = tail (foldr (\w acc -> ' ' : (w ++ acc)) "" l)
