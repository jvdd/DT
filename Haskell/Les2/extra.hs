
qs :: (Ord a) => [a] -> [a]
qs []  = []
qs (pivot : rest) = qs [x | x <- rest, x < pivot] ++ (pivot : (qs [y | y <- rest, y > pivot]))

oneindigePosOnevenLijst :: [Int]
oneindigePosOnevenLijst = (1 : (plus2 oneindigePosOnevenLijst))
    where plus2 [] = []
          plus2 (x : rest) = (2 + x) : (plus2 rest)

oneindigePriemGetallenLijst :: [Int]
oneindigePriemGetallenLijst = (2 : (priem 3))
    where priem x = if isPrime x then (x : (priem (x + 1)))
                    else priem (x + 1)
          isPrime x = isPrime2 x 2 (div x 2)
          isPrime2 x y z = if y > z then True
                           else if (mod x y) == 0 then False
                           else isPrime2 x (y + 1) z

-- andere versie
{-
priemgetallen n = [ x | x <- [1..n], priem x]
priem x = factors x == [1,x]
factors n = [ x | x <- [1..n], n `mod` x == 0]

-}

pythagorees :: [(Int, Int, Int)]
pythagorees = [(a, b, c) | c <- [1..], b <- [1..(c-1)], a <- [1..(b-1)], c^2 == a^2 + b^2]
