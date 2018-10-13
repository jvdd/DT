
fib :: Int -> Int   -- een typedeclaratie voor fib


-- Versie 1
{-
fib 0 = 1
fib 1 = 1
fib n = (fib (n - 1)) + (fib (n - 2))
-}

-- Alternatief 1
{-
fib n = if n == 0 then 1
        else if n == 1 then 1
        else (fib (n-1)) + (fib (n - 2))
-}

-- Alternatief 2

fib n = fib2 n 1 0

fib2 :: Int -> Int -> Int -> Int
fib2 0 n _ = n
fib2 i n m = fib2 (i - 1) (m + n) n


-- Alternatief 3 (Let expressies)
-- Raar hier is het 0de fibonacci number 0, terwijl het bij de andere functies 1 is
{-
fib n = if n == 0 then 0
        else if n == 1 then 1
        else let
                a = fib (n - 1)
                b = fib (n - 2)
             in a + b
-}

-- Alternatief 4 (Where clauses)
{-
fib n =  fib2 n 1 0         -- fib2 is lokaal aan fib
    where fib2 0 n _ = n
          fib2 i n m = fib2 (i - 1) (m + n) n
-}
