merge :: [Int] -> [Int] -> [Int]
merge [] l = l
merge l [] = l
merge (x:xs) (y:ys) =
		if (x < y) then (x : merge xs (y:ys))
		else if x > y then (y : merge (x:xs) ys)
		else (x : merge xs ys)

-- of ook : laatste clause met guards
{-
merge (x:xs) (y:ys) | x < y = (x : merge xs (y:ys))
				    | x > y = (y : merge (x:xs) ys)
				    | True  = (x : merge xs ys)
-}
