metades :: [a] -> ([a],[a])
metades myList = splitAt (div (length myList) 2) myList

metades2 :: [a] -> ([a],[a])
metades2 myList =
    let halfLength = div (length myList) 2 in
    (take halfLength myList, drop halfLength myList)
