applyN :: ( Integral n) => (a -> a) -> n -> a -> a
applyN _ 0 x = x
applyN f n x
    | n > 0 = f (applyN f (n-1) x)
    | otherwise = error "N cannot be negative"

cipher :: ( Integral n) => n -> [Char] -> [Char]
cipher _ [] = []
cipher n (x:xs) = applyN nextChar n x : cipher n xs


nextChar :: Char -> Char
nextChar 'z' = 'a'
nextChar c = succ c