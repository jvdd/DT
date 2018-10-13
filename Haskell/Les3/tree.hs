------- VRAAG 1 -------

-- Definieer een polymorf datatype Tree a voor een boom. Zo'n boom kan
--    enerzijds een lege boom zijn of anderzijds een knoop met een waarde
--    en een linker en rechter deelboom.
data Tree a = Leeg | Knoop a (Tree a) (Tree a) deriving Show


------- VRAAG 2 -------

-- Definieer de functie maptree::(a -> b) -> Tree a -> Tree b die met
--    behulp van een functie alle elementen in een boom vervangt.
maptree :: (a -> b) -> Tree a -> Tree b
maptree _ Leeg = Leeg
maptree f (Knoop x boom1 boom2) = Knoop (f x) (maptree f boom1) (maptree f boom2)

-- Voor te testen
test :: Integer -> [Char]
test _ = "iets"


------- VRAAG 3 -------

-- Definieer een functie tree2list::Tree a -> [a] die de elementen in
--    de boom in breedte eerst volgorde in een lijst teruggeeft.

tree2list :: Tree a -> [a]
tree2list Leeg = []
tree2list (Knoop x boom1 boom2) = x : (tree2list2 [boom1, boom1])
    where tree2list2 [] = []
          tree2list2 (Leeg : rest) = tree2list2 rest
          tree2list2 (((Knoop x boom1 boom2) : rest)) = x : (tree2list2 (rest ++ [boom1, boom2]))

--  Implementatie met accumulator (nadeel: lijst moeten omdraaien op het einde)
{-
tree2list Leeg = []
tree2list (Knoop x boom1 boom2) = tree2List [x] [boom1, boom2]
    where tree2List lijst ((Knoop x boom1 boom2) : rest) = tree2List (x : lijst) (rest ++ [boom1, boom2])
          tree2List lijst (Leeg : rest) = tree2List lijst rest
          tree2List lijst [] = reverse lijst
-}


------- VRAAG 4 -------

-- Definieer een functie vouwtree::(a -> b -> b) -> b -> Tree a -> b
--    analoog aan de functie vouw uit Haskellopdracht 2.
vouwtree :: (a -> b -> b) -> b -> Tree a -> b
vouwtree f acc Leeg = acc
vouwtree f acc (Knoop x boom1 boom2) = vouwtree2 f (f x acc) [boom1, boom2]
    where vouwtree2 f acc (Leeg : rest) = vouwtree2 f acc rest
          vouwtree2 f acc ((Knoop x boom1 boom2) : rest) = vouwtree2 f (f x acc) (boom1 : boom2 : rest)
          vouwtree2 f acc [] = acc

-- vouwtree (+) 0 (Knoop 3 (Knoop 4 (Knoop 2 Leeg Leeg) Leeg) (Knoop 5 (Knoop 6 Leeg Leeg) Leeg))
