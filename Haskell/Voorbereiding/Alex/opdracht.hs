
data Tree a = Leeg | Knoop a (Tree a) (Tree a)
   deriving Show

maptree :: (a -> b) -> Tree a -> Tree b
maptree f Leeg = Leeg
maptree f (Knoop a x y) = Knoop (f a) (maptree f x) (maptree f y)

vouwtree :: (a -> b -> b) -> b -> Tree a -> b
vouwtree _ start Leeg = start
vouwtree f start (Knoop a x y) = vouwtree f tussenwaarde y
   where tussenwaarde = vouwtree f (f a start) x

tree2list :: Tree a -> [a]
tree2list t = concat (layers t)

list2tree :: [a] -> Tree a
list2tree [] = Leeg
list2tree (x:xs) = Knoop x (list2tree left) (list2tree right)
   where
      half = div (length xs) 2
      left = take half xs
      right = drop half xs

layers :: Tree a -> [[a]]
layers Leeg = []
layers (Knoop a x y) = [a] : zipAppend (++) (layers x) (layers y)

zipAppend :: (a -> a -> a) -> [a] -> [a] -> [a]
zipAppend _ [] ys = ys
zipAppend _ xs [] = xs
zipAppend f (x:xs) (y:ys) = (f x y) : zipAppend f xs ys
