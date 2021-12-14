isVowel :: Char -> Bool 
isVowel c = elem c ['a', 'e', 'i', 'o', 'u']

countVowels :: String -> Int 
countVowels "" = 0
countVowels (x:xs) = if isVowel x then 1 + countVowels xs else countVowels xs