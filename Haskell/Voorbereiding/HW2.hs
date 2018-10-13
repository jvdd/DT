---- isVanGraaf
-- SKIP IK

---- koninginnen
koningin :: Int -> [[Int]]
koningin x = koninginnen $ perm [1..x]
    where koninginnen [] = []
          koninginnen (x : rest) = if valid x then x : (koninginnen rest)
                                   else koninginnen rest

perm :: [Int] -> [[Int]]
perm [] = [[]]
perm l = [ y | x <- l, y <- map (x:) (perm (delete x l))]

delete :: Int -> [Int] -> [Int]
delete y (x : rest) = if x == y then rest
                      else x : (delete y rest)

valid :: [Int] -> Bool
valid lijst = checkConstr lijst [1..(length lijst)]
    where checkConstr [] [] = True
          checkConstr (x:rest1) (y:rest2) = if control x rest1 y rest2 then checkConstr rest1 rest2
                                            else False
          control _ [] _ [] = True
          control x (x1:rest1) y (y2:rest2) = if (abs (x - x1)) == (abs (y - y2)) then False
                                              else control x rest1 y rest2
