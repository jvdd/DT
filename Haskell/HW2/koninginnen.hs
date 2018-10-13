
koninginnen :: Int -> [[(Int,Int)]]
koninginnen n = [ y | x <- perm [1..n], diagConstr [1..n] x, y <- [zip [1..n] x]]
    where diagConstr [] [] = True
          diagConstr (x1 : rest1) (x2 : rest2) = if not (gelijkElem (dif x1 rest1) (dif x2 rest2)) then diagConstr rest1 rest2
                                                 else False
          dif x lijst = dif3 x lijst [] -- accumulator voor efficiëntie
          dif3 _ [] acc = acc           -- lijst is dan wel omgekeerd, maar dat maakt niet uit
          dif3 x (el : rest) acc = dif3 x rest (abs(x - el) : acc)

perm :: [Int] -> [[Int]]
perm [] = [[]]
perm l = [ y | x <- l, y <- map (x:) (perm (delete x l))]

delete :: Int -> [Int] -> [Int]
delete _ [] = []
delete x (el : rest) = if x == el then rest -- enkel eerste x wordt uit lijst verwijderd
                       else el : (delete x rest)

gelijkElem :: [Int] -> [Int] -> Bool
gelijkElem [] [] = False
gelijkElem (x1 : rest1) (x2 : rest2) = if (x1 == x2) then True
                                       else gelijkElem rest1 rest2
