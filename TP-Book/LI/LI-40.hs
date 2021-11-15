weirdList :: [Int]
weirdList = [ if mod i 2 == 0 then 2 * i else 2 ^ i - 1 | i <- [0..] ]

fibonacciList :: [Int]
fibonacciList = 0 : 1 : [fibonacciList !! (n - 1) + fibonacciList !! (n - 2) | n <- [2..] ]
