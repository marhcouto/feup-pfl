data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

-- Construção por inserção simples
construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
  | x==y = No y esq dir -- já ocorre; não insere
  | x<y = No y (inserir x esq) dir -- insere à esquerda
  | x>y = No y esq (inserir x dir) -- insere à direita

-- Construção por particão binária
-- Pré-condição: a lista de valores deve estar por ordem crescente
construir' :: [a] -> Arv a
construir' [] = Vazia
construir' xs = No x (construir' xs') (construir' xs'')
  where n = length xs `div` 2 -- ponto médio
        xs' = take n xs -- partir a lista
        x:xs'' = drop n xs

altura :: (Num b, Ord b) => Arv a -> b
altura Vazia = 0
altura (No _ l r) = 1 + max (altura l) (altura r)

comparaAlturasN :: (Integral a, Show a) => a -> IO ()
comparaAlturasN n = do
  putStrLn $ "n = " ++ (show n) ++ ":"
  putStrLn $ "Por inserção simples: " ++ (show $ altura $ construir [1 .. n])
  putStrLn $ "Por partição binária: " ++ (show $ altura $ construir' [1 .. n])
  putStrLn $ "Minorante teórico da altura: " ++ (show $ ((+1) . floor . logBase 2 . fromIntegral) n)

comparaAlturas :: IO ()
comparaAlturas = do
  comparaAlturasN 10
  comparaAlturasN 100
  comparaAlturasN 1000
