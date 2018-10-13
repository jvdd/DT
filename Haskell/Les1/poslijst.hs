posLijst :: [Int] -> [Int]
posLijst []  = []
posLijst (x : rest) = if x > 0 then x : (posLijst rest)
                      else posLijst rest

-- Versie met accumulator (lijst wel omgekeerd)
{-
posLijst a = posLijst2 a []

posLijst2 :: [Int] -> [Int] -> [Int]
posLijst2 [] acc = acc
posLijst2 (x : rest) acc = if x > 0 then posLijst2 rest (x : acc)
                           else posLijst2 rest acc
-}

somLijst :: [Int] -> Int
somLijst a = somL a 0
    where somL [] acc = acc
          somL (x : rest) acc = somL rest (acc + x)

maxLijst :: (Ord a) => [a] -> a
maxLijst (x : rest) = ml x rest
    where ml x [] = x
          ml x (y : rest) = if y > x then ml y rest
                            else ml x rest
