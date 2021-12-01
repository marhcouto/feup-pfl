myPermutations :: Eq a => [a] -> [[a]]
myPermutations l = [ [x,y,z] | x <- l, y <- l, z <- l, x /= y && x /= z && y /= z]
