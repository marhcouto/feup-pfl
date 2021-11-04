mdc :: Integer -> Integer -> Integer
mdc a 0 = a
mdc a b = mdc b (mod a b)
