data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

listar :: Arv a -> [a]
listar Vazia = []
listar (No val a b) = listar b ++ [val] ++ listar a
