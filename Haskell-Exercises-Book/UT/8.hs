data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (List []) = []
flatten (Elem n) = [n]
flatten (List (x:xs)) = flatten x ++ flatten (List xs)