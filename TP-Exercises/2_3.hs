dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum [ x * y | (x, y) <- zip a b ]
