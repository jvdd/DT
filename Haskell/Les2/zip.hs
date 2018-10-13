zipL :: [a] -> [b] -> [(a,b)]   -- zip bestaat al in de prelude

zipL [] _ = []
zipL _ [] = []
zipL (x:xs) (y:ys) = ( (x,y) : (zip xs ys))
