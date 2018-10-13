max2 :: Int -> Int -> Int
max2 a b = if a > b then  a
           else b

max3 :: Int -> Int -> Int -> Int
max3 a b c = max2 (max2 a b) c
