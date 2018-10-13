maxJ :: Int -> Int -> Int
maxJ a b = if a > b then a
           else b

maxDrie :: Int -> Int -> Int -> Int
maxDrie a b c = maxJ a $ maxJ b c

hof ::  (a -> a -> Bool) -> a -> a -> Bool
hof f a b = f a b

-- ++ in prelude
appendJ :: [a] -> [a] -> [a]
appendJ [] lijst = lijst
appendJ (x:rest) lijst = x : restLijst
    where restLijst = appendJ rest lijst

lengthJ :: [a] -> Int
lengthJ [] = 0
lengthJ (_:rest) = 1 + lengthJ rest

lengthJAcc :: [a] -> Int
lengthJAcc lijst = lengthJAcc2 lijst 0
    where lengthJAcc2 [] acc = acc
          lengthJAcc2 (_:rest) acc = lengthJAcc2 rest $ acc + 1

posLijst :: [Int] -> [Int]
posLijst [] = []
posLijst (x:rest) = if x > 0 then (x:posLijst rest)
                    else posLijst rest

somPosLijst :: [Int] -> Int
somPosLijst lijst = som $ posLijst lijst
    where som [] = 0
          som (x:rest) = x + som rest

maxLijst :: [Int] -> Int
maxLijst (x:rest) = foldr maxJ x rest

plus1 :: [Int] -> [Int]
plus1 [] = []
plus1 (x:rest) = (x + 1) : (plus1 rest)

oneindigeLijst = (1 : plus1 oneindigeLijst)

takeJ :: Int -> [a] -> [a]
takeJ 0 _ = []
takeJ a (x:rest) = x : (take (a - 1) rest)

plus2 :: [Int] -> [Int]
plus2 [] = []
plus2 (x:rest) = (x + 2) : (plus2 rest)

oneindigPosOnevenLijst = (1 : plus2 oneindigPosOnevenLijst)

isPriem :: Int -> Bool
isPriem x = legitPriem [2..helft] x -- div 2 2 = []
    where helft = div x 2
          legitPriem [] _ = True
          legitPriem (a:rest) x = if mod x a == 0 then False
                                  else legitPriem rest x

allePriemen = 2 : infPriemLijst 3
    where infPriemLijst x = if isPriem x then x : (infPriemLijst $ x + 2)
                            else infPriemLijst $ x + 2

allePriemen2 = filter isPriem oneindigeLijst

pythagorees = [(a,b,c)| c <- [1..], a <- [1..c-1], b <- [1..c-1], a^2 + b^2 == c^2]

mapFilterLC funct filterFunct lijst = [funct a | a <- lijst, filterFunct a]

qs [] = []
qs (pivot:rest) = (qs [a | a <- rest, a < pivot]) ++ (pivot : (qs [a | a <- rest, a > pivot]))
