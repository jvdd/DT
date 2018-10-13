add :: (Int, Int) -> Int
add (x, y) =  x + y

cadd :: Int -> Int -> Int
cadd x y  =  x + y

plus4 = (cadd 4)

-- enkele nuttige functies gedefinieerd door sections
isNul = (== 0)
verdubbel = (2*)
tweeTotde = (2^)

f :: (Int -> Int) -> Int -> Int
f g a = g a

f3 :: (Int -> Int -> Int) -> Int -> Int -> Int
f3 g a b = g a b
