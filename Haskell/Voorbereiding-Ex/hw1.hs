---- Vraag 1

-- Gegeven code:
suml :: [Int] -> Int
suml [] = 0
suml (x:xs) = x + (suml xs)

prodl :: [Int] -> Int
prodl [] = 1
prodl (x:xs) = x * (prodl xs)

-- Opdracht:
vouw :: [Int] -> Int -> (Int -> Int -> Int) -> Int
vouw [] b _ = b
vouw (x:rest) b f = vouw rest (f x b) f

test1 = (vouw [1..5] 0 (+)) == (suml [1..5]) &&
        (vouw [1..5] 1 (*)) == (prodl [1..5])


---- Vraag 2

-- Versie zonder accumulator
{-
pascal :: Int -> [[Int]]
pascal 0 = [[1]]
pascal 1 = [[1,1]] ++ (pascal 0)
pascal x = pascal2 x 2 $ (volgende $ head $ pascal 1) : (pascal 1)
    where pascal2 x y acc = if x == y then acc
                            else pascal2 x (y + 1)((volgende $ head acc) : acc)
-}

-- Versie met accumulator
pascal :: Int -> [[Int]]
pascal x = pascal2 x [[1]]
    where pascal2 0 acc = acc
          pascal2 x (vorige:rest) = pascal2 (x - 1) $ volgende vorige : (vorige : rest)

volgende :: [Int] -> [Int]
volgende lijst = 1 : (volgende2 lijst)
    where volgende2 [_] = [1]
          volgende2 (x:y:rest) = (x + y) : (volgende2 $ y : rest)

test2 = pascal 10
