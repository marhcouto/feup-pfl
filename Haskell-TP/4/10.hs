data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show


mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Vazia = Vazia
mapArv f (No val arv1 arv2) = No (f val) (mapArv f arv1) (mapArv f arv2)
