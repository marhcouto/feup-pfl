addPoly :: [Int] -> [Int] -> [Int]
addPoly l [] = l
addPoly [] l = l
addPoly (x:xs) (y:ys) = (x+y) : (addPoly xs ys)

multPoly :: [Int] -> [Int] -> [Int]
multPoly [] _  = [0]
multPoly (x:xs) ys = addPoly ([y * x | y <- ys]) (0 : (multPoly xs ys))
