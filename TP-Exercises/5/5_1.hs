module Stack (Stack, push, pop, top, empty, isEmpty) where

data Stack a = Stk [a]

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
    | not (isEmpty st) && (head s == ')' && top st == '(') || (head s == ']' && top st == '[') = parentAux (tail s) (pop st)
    | otherwise = False