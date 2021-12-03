ioSucc :: IO()
ioSucc = do
    putStrLn "Give me an integer"
    input <- getLine
    let num = read input :: Int
    print $ succ num