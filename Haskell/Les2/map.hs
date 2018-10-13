map f (filter p xs) = [f x | x <- xs, p x]
