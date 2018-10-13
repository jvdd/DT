
-------- Vraag 1 --------

-- Data declaratie graaf

data Graaf a = Graaf {
               knopen  :: [a],
               bogen   :: [(a,a)]
               }

-- Code

isomorf :: (Eq a, Eq b) => Graaf a -> Graaf b -> Bool
isomorf graaf1 graaf2 =
        if length (knopen graaf1) == length (knopen graaf2) -- Checken of ze evenveel knopen hebben
            then if bestaatBijectie graaf1 graaf2 (permKnopen (knopen graaf1))
                    then True
                 else False
        else False

bestaatBijectie :: (Eq a, Eq b) => Graaf a -> Graaf b -> [[a]] -> Bool
bestaatBijectie _ _ [] = False
bestaatBijectie grf1 grf2 (perm : rest) =
        if vindBijectie (bogen grf1) mappedBogen2 then True
        else bestaatBijectie grf1 grf2 rest
        where mappedBogen2 = mapBogen perm (knopen grf1) (knopen grf2) (bogen grf2)

mapBogen :: (Eq a, Eq b) => [a] -> [a] -> [b] -> [(b,b)] -> [(a,a)]
mapBogen perm knpn1 knpn2 bgn2 =
    vervangBogen (zip perm knpn1) (zip knpn1 knpn2) bgn2

vervangBogen :: (Eq a, Eq b) => [(a,a)] -> [(a,b)] -> [(b,b)] -> [(a,a)]
vervangBogen _ _ [] = []
vervangBogen permMap mapping (boog : rest) = ((mapped permMap (fst boog) mapping), (mapped permMap (snd boog) mapping)) : (vervangBogen permMap mapping rest)
    where mapped permMap x (mp : rest) = if x == (snd mp) then findPerm (fst mp) permMap
                                 else mapped permMap x rest
          findPerm x (prm : rest) = if x == (snd prm) then fst prm
                                    else findPerm x rest

vindBijectie :: (Eq a) => [(a,a)] -> [(a,a)] -> Bool
vindBijectie [] []  = True
vindBijectie [] _   = False
vindBijectie _ []   = False
vindBijectie (x : rest) bogen2 =
    if elem x bogen2 then vindBijectie rest $ delete x bogen2
    else if elem (snd x, fst x) bogen2 then vindBijectie rest $ delete (snd x, fst x) bogen2
    else False

permKnopen :: (Eq a) => [a] -> [[a]]
permKnopen [] = [[]]
permKnopen l = [ y | x <- l, y <- map (x:) (permKnopen (delete x l))]

delete :: (Eq a) => a -> [a] -> [a]
delete _ [] = []
delete x (el : rest) = if x == el then rest -- enkel eerste x wordt uit lijst verwijderd
                      else el : (delete x rest)

-- Test data:
graaf1 = Graaf [1, 2, 3, 4]        [(1,2),(1,3),(1,4)]
graaf2 = Graaf ['a','b','c','d']   [('a','b'),('a','c'),('a','d')]
graaf3 = Graaf ['w','x','y','z']   [('x','y'),('y','w'),('z','y')]
graaf4 = Graaf [1, 4, 3, 2]        [(1,2),(1,4),(1,3)]
graaf5 = Graaf ['a','b','c','d']   [('a','b'),('b','c'),('c','d')]

test1 = isomorf graaf1 graaf1 == True
       && isomorf graaf2 graaf2 == True
       && isomorf graaf1 graaf2 == True
       && isomorf graaf1 graaf3 == True
       && isomorf graaf2 graaf3 == True
       && isomorf graaf1 graaf4 == True
       && isomorf graaf1 graaf5 == False
       && isomorf graaf2 graaf5 == False
       && isomorf graaf3 graaf5 == False
       && isomorf graaf4 graaf5 == False


---------------------------- BONUS ----------------------------
-- Deze bonus controleert of gewogen grafen isomorf zijn
{-
-- Data declaratie graaf
data Graaf a = Graaf {
              knopen  :: [a],
              bogen   :: [(a,a,Int)]
              }

isomorf :: (Eq a, Eq b) => Graaf a -> Graaf b -> Bool
isomorf graaf1 graaf2 =
       if length (knopen graaf1) == length (knopen graaf2) -- Checken of ze evenveel knopen hebben
           then if bestaatBijectie graaf1 graaf2 (permKnopen (knopen graaf1))
                   then True
                else False
       else False

bestaatBijectie :: (Eq a, Eq b) => Graaf a -> Graaf b -> [[a]] -> Bool
bestaatBijectie _ _ [] = False
bestaatBijectie grf1 grf2 (perm : rest) =
       if vindBijectie (bogen grf1) mappedBogen2 then True
       else bestaatBijectie grf1 grf2 rest
       where mappedBogen2 = mapBogen perm (knopen grf1) (knopen grf2) (bogen grf2)

mapBogen :: (Eq a, Eq b) => [a] -> [a] -> [b] -> [(b,b,Int)] -> [(a,a,Int)]
mapBogen perm knpn1 knpn2 bgn2 =
   vervangBogen (zip perm knpn1) (zip knpn1 knpn2) bgn2

vervangBogen :: (Eq a, Eq b) => [(a,a)] -> [(a,b)] -> [(b,b,Int)] -> [(a,a,Int)]
vervangBogen _ _ [] = []
vervangBogen permMap mapping (boog : rest) = ((mapped permMap (frst boog) mapping), (mapped permMap (scnd boog) mapping), lst boog) : (vervangBogen permMap mapping rest)
   where mapped permMap x (mp : rest) = if x == (snd mp) then findPerm (fst mp) permMap
                                else mapped permMap x rest
         findPerm x (prm : rest) = if x == (snd prm) then fst prm
                                   else findPerm x rest
         frst (x,_,_) = x
         scnd (_,x,_) = x
         lst (_,_,x) = x

vindBijectie :: (Eq a) => [(a,a,Int)] -> [(a,a,Int)] -> Bool
vindBijectie [] []  = True
vindBijectie [] _   = False
vindBijectie _ []   = False
vindBijectie (x : rest) bogen2 =
   if elem x bogen2 then vindBijectie rest $ delete x bogen2
   else if elem (scnd x, frst x, lst x) bogen2 then vindBijectie rest $ delete (scnd x, frst x, lst x) bogen2
   else False
   where frst (x,_,_) = x
         scnd (_,x,_) = x
         lst (_,_,x) = x

permKnopen :: (Eq a) => [a] -> [[a]]
permKnopen [] = [[]]
permKnopen l = [ y | x <- l, y <- map (x:) (permKnopen (delete x l))]

delete :: (Eq a) => a -> [a] -> [a]
delete _ [] = []
delete x (el : rest) = if x == el then rest -- enkel eerste x wordt uit lijst verwijderd
                     else el : (delete x rest)


-- Test data:
graaf1 = Graaf [1, 2, 3, 4]        [(1,2,1),(1,3,2),(1,4,3)]
graaf2 = Graaf ['a','b','c','d']   [('a','b',2),('a','c',3),('a','d',1)]
graaf3 = Graaf ['a','b','c','d']   [('a','b',1),('b','c',2),('c','d',3)]

test2 = isomorf graaf1 graaf1 == True
      && isomorf graaf1 graaf2 == True
      && isomorf graaf1 graaf3 == False
      && isomorf graaf2 graaf3 == False
-}



-------- Vraag 2 --------

reken :: IO ()
reken = do
   lijn <- getLine :: IO String
   --print $ bewerking lijn -- Print gewoon het resultaat
   print ("bewerking: " ++ lijn ++ " = " ++ show (bewerking lijn))
   where bewerking lijn = (getSign lijn) (get1 lijn) (get2 lijn)
         getSign lijn = if (last $ take 3 lijn) == '+' then (+)
                        else (*)
         get1 lijn = getGetal $ head lijn
         get2 lijn = getGetal $ last lijn
         getGetal '0' = 0
         getGetal '1' = 1
         getGetal '2' = 2
         getGetal '3' = 3
         getGetal '4' = 4
         getGetal '5' = 5
         getGetal '6' = 6
         getGetal '7' = 7
         getGetal '8' = 8
         getGetal '9' = 9
