filter :: (t -> Bool) -> [t] -> [t]
filter p [] = []
filter p (x:xs)
		| p x = x : rest
		| otherwise = rest    -- otherwise mag ook ipv TRUE
		where rest = filter p xs

-- Alternatief (met lambda notatie)
filter = \p -> \xs ->
	case xs of
	[] -> []
	(x:xs) -> let
		rest = filter p xs
            in if (p x) then x : rest
	        else rest

filterpos::[Int] -> [Int]
filterpos [] = []
filterpos (x:xs)
          | x > 0 = x : filterpos xs
          | otherwise = filterpos xs

suml :: [Int] -> Int
suml [] = 0
suml (x:xs) = x + suml xs

addposl = suml (filterpos l)
addpos2 = suml . filterpos      -- suml na filterpos
addpos3 = suml . (filter (>0))
addpos4 = foldr (+) 0 . filter (>0)
