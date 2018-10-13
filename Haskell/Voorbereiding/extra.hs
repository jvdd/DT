
maxLijst :: [Int] -> Int
maxLijst (x:rest) = foldr max x rest

fac :: Int -> Int
fac x = foldr (*) x [1..(x-1)]
