---- Vraag 1
isVanGraaf :: [Int] -> Bool
isVanGraaf [] = True
isVanGraaf (x:rest) = if alNul volgendeLijst then True
                      else if legit volgendeLijst then isVanGraaf volgendeLijst
                      else False
    where volgendeLijst = qs $ volgende x rest
          volgende 0 rest = rest
          volgende _ [] = [-1]
          volgende x (y:rest) = (y - 1) : (volgende (x-1) rest)
          alNul (x:rest) = (foldr max x rest) == 0 && (foldr min x rest) == 0
          legit lijst = (foldr min x rest) >= 0

qs :: (Ord a) => [a] -> [a]
qs [] = []
qs (pivot:xs) = (qs [x | x <- xs, x > pivot]) ++ (pivot : qs [y | y <-xs, y <= pivot])

test1 = isVanGraaf [2,1,1] == True &&
        isVanGraaf [3,1,1] == False

---- Vraag 2:
-- Gewoon keer bekijken
