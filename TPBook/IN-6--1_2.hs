half :: Fractional a => a -> a
half x = x/2

xor :: Bool -> Bool -> Bool
xor a b = not (a == b)

cbrt :: Floating a => a -> a
cbrt x = x**(1/3)

heron :: Floating a => a -> a -> a -> a
heron a b c =
    let s = (a + b + c) / 2 in
    sqrt (s * (-) s a * (-) s b * (-) s c)
