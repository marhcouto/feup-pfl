data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

maisDir :: Arv a -> a
maisDir (No x _ Vazia) = x
maisDir (No _ _ dir) = maisDir dir

remover :: Ord a => a -> Arv a -> Arv a
remover _ Vazia = Vazia
remover a (No val arvE Vazia)
    | a == val = arvE
    | otherwise remover a arvE
remover a (No val Vazia arvD)
    | a == val = arvD
    | otherwise remover a arvD
remover a (No val arvE arvD)
    | a < val = No val (remover a arvE) arvD
    | a > val = No val arvE (remover a arvD)
    | a == val = No biggerLeft (remover biggerLeft arvE) arvD
        where biggerLeft = maisDir arvE
