-- Naieve versie
nrev :: [a] -> [a]
nrev [] = []
nrev (x : xs) = nrev xs ++ [x]

-- Definitie van ++ (zit al in prelude)
{-
[] ++ l = l
(x:xs) ++ l = (x : (xs ++ l))
-}

-- Slimmere versie
srev :: [a] -> [a]
srev l = rev2 l []
    where rev2 [] a = a
          rev2 (x : xs) a = rev2 xs (x : a)
