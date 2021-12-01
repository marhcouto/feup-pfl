module Stack (Stack, push, pop, top, empty, isEmpty) where

import Data.List.Split


data Stack a = Stk [a] deriving Show

push :: a -> Stack a -> Stack a
push x (Stk xs) = Stk (x:xs)

pop :: Stack a -> Stack a
pop (Stk (_:xs)) = Stk xs
pop _ = error "Stack.pop: empty stack"

top :: Stack a -> a
top (Stk (x:_)) = x
top _ = error "Stack.top: empty stack"

empty :: Stack a
empty = Stk []

isEmpty :: Stack a -> Bool
isEmpty (Stk [])= True
isEmpty (Stk _) = False

parent :: String -> Bool
parent s = parentAux s (Stk [])


parentAux :: String -> Stack Char -> Bool
parentAux [] st
    | isEmpty st = True
    | otherwise = False
parentAux s st
    | head s == '[' || head s == '(' = parentAux (tail s) (push (head s) st)
    | not (isEmpty st) && head s == ')' && top st == '(' || head s == ']' && top st == '[' = parentAux (tail s) (pop st)
    | otherwise = False


-- a)
calc :: Stack Float -> String -> Stack Float
calc st s
    | s == "+" = push ( top (pop st) + top st) (pop (pop st))
    | s == "-" = push ( top (pop st) - top st) (pop (pop st))
    | s == "*" = push ( top (pop st) * top st) (pop (pop st))
    | s == "/" = push ( top (pop st) / top st) (pop (pop st))
    | otherwise = push (read s) st

-- b)
calcular :: String -> Float
calcular s = top (last listaStack)
    where
        listaStack = empty : [calc (listaStack !! i) x | (x, i) <- zip z [0 .. length z - 1]]
        z = splitOn " " s

-- c)
main :: IO()
main = do
    a <- getLine
    print (calcular a)