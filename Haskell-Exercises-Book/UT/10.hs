module Stack (Stack (Stk), isEmpty, createEmptyStack, push, pop, top) where

data Stack a = Stk [a]


createEmptyStack :: Stack a
createEmptyStack = Stk []

isEmpty :: Stack a -> Bool 
isEmpty (Stk []) = True
isEmpty _ = False 

push :: Stack a -> a -> Stack a
push (Stk l) val = Stk $ val : l

pop :: Stack a -> Stack a
pop (Stk []) = error "Empty stack"
pop (Stk (x:xs)) = Stk xs

top :: Stack a -> a
top (Stk []) = error "Empty stack"
top (Stk (x:xs)) = x

