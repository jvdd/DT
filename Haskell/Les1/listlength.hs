listlength :: [Int] -> Int

-- Versie 1
{-
listlength [] = 0
listlength (_:xs) = 1 + (listlength xs)
-}

-- Versie 2 (met accumulator)
{-
listlength l = ll l 0
    where ll [] acc = acc
          ll (x:xs) acc = ll xs (acc + 1)
-}

-- Versie 3 (met $!)

listlength l = llstrict l 0
    where llstrict [] l = l
          llstrict (x:xs) l = llstrict xs $! (l + 1)

-- f $! x behaves as f x, except that the evaluation of the argument x
--        is forced before f is applied 
