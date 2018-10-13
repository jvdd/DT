----- PREVIOUS PROBLEMS NEEDED

myLength :: [a] -> Int
myLength [] = 0
myLength (_ : rest) = 1 + (myLength rest)

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

elementAt :: [a] -> Int -> a
elementAt (x : _) 1 = x
elementAt (_ : rest) y = elementAt rest (y - 1)


---- Problem 11
-- Modified run-length encoding.
-- Modify the result of problem 10 in such a way that if an element has no duplicates
-- it is simply copied into the result list. Only elements with duplicates are transferred
-- as (N E) lists.
data ListItem a = Single a | Multiple Int a
        deriving Show

encodeModified :: (Eq a) => [a] -> [ListItem a]
encodeModified lijst = runLengthModified (pack lijst)
    where runLengthModified [] = []
          runLengthModified (x : rest) = if (myLength x) > 1 then (Multiple (myLength x) (first x)) : (runLengthModified rest)
                                         else (Single (first x)) : (runLengthModified rest)
          first (x : _) = x

-- OPM: head [1, 2, 3] == 1

---- Problem 12
-- Decode a run-length encoded list.
-- Given a run-length code list generated as specified in problem 11.
-- Construct its uncompressed version.
decodeModified :: [ListItem a] -> [a]
decodeModified [] = []
decodeModified ((Single x) : rest) = x : (decodeModified rest)
decodeModified ((Multiple nb x) : rest) = (reconstructModified nb x) ++ (decodeModified rest)
    where reconstructModified 0 _ = []
          reconstructModified nb x = x : (reconstructModified (nb - 1) x)

---- Problem 13
-- Run-length encoding of a list (direct solution).
-- Implement the so-called run-length encoding data compression method directly.
-- I.e. don't explicitly create the sublists containing the duplicates, as in problem 9,
-- but only count them. As in problem P11, simplify the result list by replacing
-- the singleton lists (1 X) by X.
encodeDirect :: (Eq a) => [a] -> [ListItem a]
encodeDirect [] = []
encodeDirect (x :( y : (rest))) = if x /= y then (Single x) : (encodeDirect (y : rest))
                                  else (Multiple (2 + (count x rest)) x) : (encodeDirect (selectRest x rest))
    where count _ [] = 0
          count x (y : rest) = if x /= y then 0
                               else 1 + (count x rest)
          selectRest _ [] = []
          selectRest x (y : rest) = if x /= y then rest
                                    else (selectRest x rest)

---- Problem 14
-- Duplicate the elements of a list.
dupli :: [a] -> [a]
dupli [] = []
dupli (x : rest) = x : (x : (dupli rest))

---- Problem 15
-- Replicate the elements of a list a given number of times.
repli :: [a] ->  Int -> [a]
repli _ 0 = []
repli lijst y = lijst ++ (repli lijst (y -1))

---- Problem 16
-- Drop every N'th element from a list.
dropEvery :: [a] -> Int -> [a]
dropEvery lijst n = dropEvery3 lijst n n
    where dropEvery3 [] _ _ = []
          dropEvery3 (x : rest) 1 n = dropEvery3 rest n n
          dropEvery3 (x : rest) y n = x : (dropEvery3 rest (y - 1) n)

---- Problem 17
-- Split a list into two parts; the length of the first part is given.
-- Do not use any predefined predicates.
split :: [a] -> Int -> ([a], [a])
split lijst nb = ((split2 lijst nb), (restSplit lijst nb))
    where split2 _ 0 = []
          split2 (x : rest) y = (x : (split2 rest (y - 1)))
          restSplit rest 0 = rest
          restSplit (x : rest) y = restSplit rest (y - 1)

---- Problem 18
-- Extract a slice from a list.
-- Given two indices, i and k, the slice is the list containing the elements
-- between the i'th and k'th element of the original list (both limits included).
-- Start counting the elements with 1.
slice :: [a] -> Int -> Int -> [a]
slice lijst 1 z = getSublist lijst z
    where getSublist _ 0 = []
          getSublist (x : rest) y = x : (getSublist rest (y -1))
slice (x : rest) y z = slice rest (y - 1) (z - 1)

---- Problem 19
-- Rotate a list N places to the left.
-- Hint: Use the predefined functions length and (++).
rotate :: [a] -> Int -> [a]
rotate lijst x = if x >= 0 then createRotation lijst x
                 else createRotation lijst ((length lijst) + x)
    where createRotation lijst x = (snd (split lijst x)) ++ (fst (split lijst x))

---- Problem 20
-- Remove the K'th element from a list.
removeAt :: Int -> [a] -> (a,[a])
removeAt y lijst = ((elementAt lijst y), (removeElAt y lijst))
removeElAt 1 (_ : rest) = rest
removeElAt y (x : rest) = x : (removeElAt (y - 1) rest)
