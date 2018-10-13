------- VRAAG 1 -------

-- Definieer een polymorf datatype Tree a voor een boom. Zo'n boom kan
--    enerzijds een lege boom zijn of anderzijds een knoop met een waarde
--    en een linker en rechter deelboom.
data Tree a = Knoop a (Tree a) (Tree a) | Leeg
    deriving Show


------- VRAAG 2 -------

-- Definieer de functie maptree :: (a -> b) -> Tree a -> Tree b die met
--    behulp van een functie alle elementen in een boom vervangt.
maptree :: (a -> b) -> Tree a -> Tree b
maptree f Leeg = Leeg
maptree f (Knoop a ltree rtree) = Knoop (f a) (maptree f ltree) (maptree f rtree)

test :: Int -> Char
test _ = 'a'

------- VRAAG 3 -------

-- Definieer een functie tree2list::Tree a -> [a] die de elementen in
--    de boom in breedte eerst volgorde in een lijst teruggeeft.
tree2list :: Tree a -> [a]
tree2list Leeg = []
tree2list (Knoop a ltree rtree) = a : (bf2List [ltree, rtree] [])
    where bf2List [] [] = []
          bf2List [] next = bf2List next []
          bf2List (Leeg : rest) next = bf2List rest next
          bf2List ((Knoop a ltree rtree) : rest) next = a : (bf2List rest (next ++ [ltree, rtree]))


------- VRAAG 4 -------

-- Definieer een functie vouwtree::(a -> b -> b) -> b -> Tree a -> b
--    analoog aan de functie vouw uit Haskellopdracht 2.
vouwtree :: (a -> b -> b) -> b -> Tree a -> b
vouwtree f b Leeg = b
vouwtree f b (Knoop a ltree rtree) = vouwtree3 f (f a b) [ltree, rtree]
    where vouwtree3 f acc [] = acc
          vouwtree3 f acc (Leeg : rest) = vouwtree3 f acc rest
          vouwtree3 f acc ((Knoop a ltree rtree) : rest) = vouwtree3 f (f a acc) (rest ++ [ltree, rtree])

-- vouwtree (+) 0 (Knoop 3 (Knoop 4 (Knoop 2 Leeg Leeg) Leeg) (Knoop 5 (Knoop 6 Leeg Leeg) Leeg))
