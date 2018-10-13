isSorted :: [Int] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:rest) = (x <= y) && isSorted(y:rest)


iterateL :: (a -> a) -> a -> [a]        -- iterate bestaat al in de prelude
iterateL next x = x : iterate next (next x)
