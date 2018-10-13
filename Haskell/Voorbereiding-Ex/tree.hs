------- VRAAG 1 -------

-- Definieer een polymorf datatype Tree a voor een boom. Zo'n boom kan
--    enerzijds een lege boom zijn of anderzijds een knoop met een waarde
--    en een linker en rechter deelboom.
data Tree a = Leeg | Knoop a (Tree a) (Tree a)
        deriving (Show)


------- VRAAG 2 -------

-- Definieer de functie maptree::(a -> b) -> Tree a -> Tree b die met
--    behulp van een functie alle elementen in een boom vervangt.
maptree :: (a -> b) -> Tree a -> Tree b
maptree f Leeg = Leeg
maptree f (Knoop x lT rT) = Knoop (f x) (maptree f lT) (maptree f rT)

-- Voor te testen
test :: Int -> Char
test _ = 'X'

test2 = maptree test $ Knoop 1 (Knoop 2 (Knoop 3 Leeg Leeg) Leeg) (Knoop 4 Leeg Leeg)


------ VRAAG 3 -------

-- Definieer een functie tree2list::Tree a -> [a] die de elementen in
--    de boom in breedte eerst volgorde in een lijst teruggeeft.

tree2list :: Tree a -> [a]
tree2list Leeg = []
tree2list (Knoop x lT rT) = x : tree2list2 [lT, rT]
    where tree2list2 [] = []
          tree2list2 (Leeg:rest) = tree2list2 rest
          tree2list2 ((Knoop x lT rT):rest) = x : (tree2list2 $ rest ++ [lT,rT])

test3 = tree2list $ Knoop 1 (Knoop 2 (Knoop 3 Leeg Leeg) Leeg) (Knoop 4 Leeg Leeg)


------- VRAAG 4 -------

-- Definieer een functie vouwtree::(a -> b -> b) -> b -> Tree a -> b
--    analoog aan de functie vouw uit Haskellopdracht 2
vouwtree :: (a -> b -> b) -> b -> Tree a -> b
vouwtree f b Leeg = b
vouwtree f b (Knoop a lT rT) = vouwtree2 f (f a b) [lT, rT]
    where vouwtree2 f acc [] = acc
          vouwtree2 f acc (Leeg:rest) = vouwtree2 f acc rest
          vouwtree2 f acc ((Knoop x lT rT):rest) = vouwtree2 f (f x acc) $ rest ++ [lT,rT]
