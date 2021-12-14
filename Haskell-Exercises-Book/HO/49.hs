import Data.Char

countLetters :: String -> Int 
countLetters = length . filter isAlpha 

countFirst :: String -> Int 
countFirst = length . head . words 