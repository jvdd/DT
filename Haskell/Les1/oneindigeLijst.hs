plus1 :: [Int] -> [Int]
plus1 [] = []
plus1 (x:xs) = (x + 1) : (plus1 xs)

langeLijst :: [Int] -- Functie zonder argumenten
langeLijst = (1 : (plus1 langeLijst))

-- WERKING:
-- langeLijst = 1 : plus1(1 : plus1(1 : plus1(1: plus1(1: plus1(1 : ... )))))
--              1         2         3         4        5        6
