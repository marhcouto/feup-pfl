myConcat' :: [[a]] -> [a]
myConcat' l = [ x | xs <- l, x <- xs]

myReplicate' :: Integral a => a -> b -> [b]
myReplicate' a b = [ b | _ <- [1 .. a]]

(@@@) :: Integral b => [a] -> b -> a
l @@@ n = head [ x | (x,i) <- zip l [0 ..], i == n ]

myReverse' :: [a] -> [a]
myReverse' l = myReverse'Aux l []

myReverse'Aux :: [a] -> [a] -> [a]
myReverse'Aux [] acc = acc
myReverse'Aux (x:xs) acc = myReverse'Aux xs (x:acc)
