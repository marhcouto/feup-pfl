f :: (a -> b -> b) -> b -> a -> b
f f1 val1 val2 = f1 val2 val1