---- Problem 21
-- Insert an element at a given position into a list.
insertAt :: a -> [a] -> Int -> [a]
insertAt y rest 1 = y : rest
insertAt y (x : rest) z = x : (insertAt y rest (z - 1))

---- Problem 22
-- Create a list containing all integers within a given range.
range :: Int -> Int -> [Int]
range x y = [x..y]

---- Problem 23
-- Extract a given number of randomly selected elements from a list.




---- Problem 26
-- Generate the combinations of K distinct objects chosen from the N elements of a lis
-- In how many ways can a committee of 3 be chosen from a group of 12 people?
-- We all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the well-known binomial coefficients).
-- For pure mathematicians, this result may be great.
-- But we want to really generate all the possibilities in a list.

combinations :: Int -> [a] -> [[a]]
-- We don't actually need this base case; it's just here to
-- avoid the warning about non-exhaustive pattern matches
combinations _ [] = [[]]
-- Base case--choosing 0 elements from any list gives an empty list
combinations 0 _  = [[]]
-- Get all combinations that start with x, recursively choosing (k-1) from the
-- remaining xs. After exhausting all the possibilities starting with x, if there
-- are at least k elements in the remaining xs, recursively get combinations of k
-- from the remaining xs.
combinations k (x:xs) = x_start ++ others
    where x_start = [ x : rest | rest <- combinations (k-1) xs ]
          others  = if k <= length xs then combinations k xs else []
