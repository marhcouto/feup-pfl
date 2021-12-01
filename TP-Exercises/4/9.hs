data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

nivel :: Int -> Arv a -> [a]
nivel n Vazia = []
nivel 0 (No val _ _) = [val]
nivel n (No val arv1 arv2) = nivel (n-1) arv1 ++ nivel (n-1) arv2
