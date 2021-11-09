-- supondo que p: < 10 e f: 2*x e xs [1..100]
lista = map (\x -> 2*x) (filter (\x -> x < 10) [1..100])
