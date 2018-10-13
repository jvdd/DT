appendL :: [Int] -> [Int] -> [Int]
appendL [] l = l
appendL (x:xs) a = x : (appendL xs a)
