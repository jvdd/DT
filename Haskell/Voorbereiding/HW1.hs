---- VRAAG 1
-- vouw
suml :: [Int] -> Int
suml [] = 0
suml (x:xs) = x + (suml xs)

prodl :: [Int] -> Int
prodl [] = 1
prodl (x:xs) = x * (prodl xs)

vouw :: [Int] -> Int -> (Int -> Int -> Int) -> Int
vouw [x] b f = f x b
vouw (x : rest) b f = f x (vouw rest b f)

test1 = vouw [1..5] 0 (+) == suml [1..5]
test2 = vouw [1..5] 1 (*) == prodl [1..5]


---- Vraag 2
-- pascal
pascal :: Int -> [[Int]]
pascal 0 = []
pascal x = (pasc x) : (pascal (x - 1))
    where pasc 1 = [1]
          pasc 2 = [1,1]
          pasc x = 1 : (createPascOut (pasc (x - 1)))
            where createPascOut [_] = [1]
                  createPascOut (x:y:rest) = (x + y) : (createPascOut (y:rest))
