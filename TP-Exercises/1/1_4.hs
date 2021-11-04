last2 :: [a] -> a
last2 myList = head (reverse myList)

last3 :: [a] -> a
last3 myList = head (drop ((length myList) - 1 ) myList)

init2 :: [a] -> [a]
init2 myList = reverse (drop 1 (reverse myList))

init3 :: [a] -> [a]
init3 myList = reverse (tail (reverse myList))
