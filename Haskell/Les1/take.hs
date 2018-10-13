takeL :: Int -> [Int] -> [Int]      -- take bestaat al in de prelude
takeL 0 _ = []
takeL n (x:xs) = x : (take (n - 1) xs)

fib :: [Int]
fib = (1: 1: (f 1 1))
    where f a b = (a + b) : (f b (a + b))
