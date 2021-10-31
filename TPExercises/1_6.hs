raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = ((-b + n) / (2 * a), (-b - n) / (2 * a))
    where n = sqrt (b**2 - 4*a*c)
