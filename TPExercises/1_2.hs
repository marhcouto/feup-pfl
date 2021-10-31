areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c =
    let s = (a + b + c) / 2 in
    sqrt (s * (-) s a * (-) s b * (-) s c)
