
---- Problem 1
-- Find the last element of a list.
myLast ::  [a] -> a
myLast (x : []) = x
myLast (_ : rest) = myLast rest

---- Problem 2
-- Find the last but one element of a list.
myButLast :: [a] -> a
myButLast (x : (_ : [])) = x
myButLast (_ : rest) = myButLast rest

---- Problem 3
-- Find the K'th element of a list. The first element in the list is number 1.
elementAt :: [a] -> Int -> a
elementAt (x : _) 1 = x
elementAt (_ : rest) y = elementAt rest (y - 1)

---- Problem 4
-- Find the number of elements of a list.
myLength :: [a] -> Int
myLength [] = 0
myLength (_ : rest) = 1 + (myLength rest)

---- Problem 5
-- Reverse a list.
myReverse :: [a] -> [a]
myReverse lijst = myReverseAcc lijst []
    where myReverseAcc [] acc = acc
          myReverseAcc (x : rest) acc = myReverseAcc rest (x : acc)

---- Problem 6
-- Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome lijst = isPalindrome3 lijst (myReverse lijst) (div (myLength lijst) 2)
    where isPalindrome3 _ _ 0 = True
          isPalindrome3 (x : rest1) (y : rest2) z = if x == y then isPalindrome3 rest1 rest2 (z - 1)
                                                    else False

---- Problem 7
-- Flatten a nested list structure.
-- Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).
data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List nestedList) = flattenNL nestedList
    where flattenNL [] = []
          flattenNL (x : rest) = (flatten x) ++ (flattenNL rest)

---- Problem 8
-- Eliminate consecutive duplicates of list elements.
-- If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.
compress :: (Eq a) => [a] -> [a]
compress [] = []
compress (x : rest) = x : (compress (compress2 rest x))
    where compress2 [] _ = []
          compress2 (y : rest) x = if y == x then (compress2 rest x)
                                   else (y : (compress2 rest x))

---- Problem 9
-- Pack consecutive duplicates of list elements into sublists. If a list contains repeated elements they should be placed in separate sublists.
pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack (x : (y : rest)) = if x /= y then ([x] : (pack (y : rest)))
                        else ([x,y] ++ select x rest) : (pack (selectRest x rest))
        where select _ [] = []
              select x (y : rest) = if x == y then x : (select x rest)
                                    else []
              selectRest _ [] = []
              selectRest x (y : rest) = if x /= y then (y : rest)
                                        else (selectRest x rest)

---- Problem 10
-- Run-length encoding of a list.
-- Use the result of problem P09 to implement the so-called run-length encoding data compression method.
-- Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.
encode :: (Eq a) => [a] -> [(Int, a)]
encode lijst = runLength (pack lijst)
    where runLength [] = []
          runLength (x : rest) = ((myLength x), first x) : (runLength rest)
          first (x : _) = x
