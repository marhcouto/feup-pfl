mdc :: Integral a => a -> a -> a
mdc a b = fst (until (\(x, y) -> y == 0) (\(x, y) -> (y, mod x y)) (a, b))
