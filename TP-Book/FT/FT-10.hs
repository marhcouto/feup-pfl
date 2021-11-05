-- a) Function f computes the tuple comprised of the third element of the list passed by argument and the rest if the list (from the third element on)

f :: [a] -> (a, [a])
f l = (l !! 2, drop 3 l)
