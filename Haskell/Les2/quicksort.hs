
qs [] = []
qs (pivot:xs) = (qs [x | x <- xs, x < pivot]) ++ (pivot : qs [y | y <-xs, y >= pivot])
