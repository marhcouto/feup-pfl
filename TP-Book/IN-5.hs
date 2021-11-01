double :: Num a => a -> a
double x = 2*(x)

nand :: Bool -> Bool -> Bool
nand x y = (not) (x && y)

funcX :: Floating a => a -> a -> a -> a -> a
funcX x a b c =
    a*t**2 + b*t + c
    where
        t = cos x + sin x
