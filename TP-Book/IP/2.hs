import System.IO

getNLines :: Integer -> IO String
getNLines 0 = return ""
getNLines n 
    | n > 0 = do    
        l <- getLine 
        ls <- getNLines (n - 1)
        return (l ++ '\n':ls)
    | otherwise = error "Negative n"


-- Other experiments

ioSucc :: IO()
ioSucc = do
    putStrLn "Give me an integer"
    input <- getLine
    let num = read input :: Int
    print $ succ num

funcX :: IO String
funcX = do
    return ()
    return "hello"
    return "123"
funcY :: IO String
funcY = do
    funcX
    funcX
funcZ :: IO ()
funcZ = do
    x <- funcX
    print x
    return ()

f :: Handle -> IO()
f hdl = do
    hPutStrLn hdl "Ola"

main = do
    writeFile "./test.txt" "Testing..."
    withFile "./text.txt" WriteMode f