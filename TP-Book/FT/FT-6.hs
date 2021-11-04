myHead :: [a] -> a
myHead [] = error "empty list"
myHead (x:_) = x
