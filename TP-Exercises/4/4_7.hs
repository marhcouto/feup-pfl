data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No n a b) = n + sumArv a + sumArv b
