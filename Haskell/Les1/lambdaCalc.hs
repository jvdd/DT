f2 :: (Int -> Int) -> Int -> Int
f2 g a = g a     -- apply g to a

f3 :: ( Int -> Int -> Int) -> Int -> Int -> Int
f3 g a b = g a b
