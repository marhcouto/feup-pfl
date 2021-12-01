orderedTriples ::Ord a => [(a, a, a)] -> [(a, a, a)]
orderedTriples = filter (\(a, b, c) -> a <= b && b <= c)