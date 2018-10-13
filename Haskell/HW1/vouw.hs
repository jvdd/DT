-- Gegeven code
suml :: [Int] -> Int
suml [] = 0
suml (x:xs) = x + (suml xs)


prodl :: [Int] -> Int
prodl [] = 1
prodl (x:xs) = x * (prodl xs)


-- vouw
vouw :: [Int] -> Int -> (Int -> Int -> Int) -> Int
vouw [] acc _ = acc
vouw (x:rest) acc f = vouw rest (f x acc) f

-- TEST:
-- vouw [3, 1, (-2)] 0 (+) == suml [3, 1, (-2)]
-- vouw [3, 1, (-2)] 1 (*) == prodl [3, 1, (-2)]
