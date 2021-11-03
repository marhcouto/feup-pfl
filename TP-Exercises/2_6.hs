pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [ (x, y, z) | x <- [1 .. n], y <- [1 .. n], z <- [1 .. n], x^2 + y^2 == z^2]

pitagoricos' :: Integer -> [(Integer, Integer, Integer)]
pitagoricos' n = concat [ [(x,y,z),(y,x,z) | x <- [1 .. n], y <- [1 .. n], z <- [1 .. n], x^2 + y^2 == z^2]


pitagoricos'' :: Integer -> [(Integer, Integer, Integer)]
pitagoricos'' n = concat [ [(x,y,z),(y,x,z) | x <- [1 .. n], y <- [1 .. n], let z = ( floor . sqrt . fromtIntegral )(x^2 + y^2), z <= n, x^2 + y^2 == z^2]
