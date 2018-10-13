-- METHODE
-- Elke rij begint en eindigt met een 1.  De overige getallen in de rij
-- kunnen bekomen worden door telkens twee opeenvolgende elementen uit
-- de vorige rij op te tellen.

pascal :: Int -> [[Int]]
pascal x = pascal2 x [[1]]
    where pascal2 0 acc = acc
          pascal2 x (vorige:rest) = pascal2 (x - 1) ((volgende vorige):vorige:rest)


volgende :: [Int] -> [Int]
volgende vorige = 1 : (midden vorige [1])
    where midden [_] acc = acc
          midden (x:y:rest) acc = midden (y:rest) ((x + y):acc)
