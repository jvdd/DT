
---- Isomorfe grafen
data Graaf a b = Graaf { knopen :: [a],
                         bogen  :: [Boog a b]
                       }

data Boog a b = Boog (a,a,b)

isomorf :: (Eq c, Eq a) => Graaf a b -> Graaf c d -> Bool
isomorf graaf1 graaf2 = if length (knopen graaf1) == length (knopen graaf2)
                            then (if bijectieGevonden graaf1 graaf2 then True
                                  else False
                                 )
                         else False

bijectieGevonden :: (Eq c, Eq a) => Graaf a b -> Graaf c d -> Bool
bijectieGevonden graaf1 graaf2 = if matchGevonden permKnopenGr2 knopenGr1 bogenGr2 bogenGr1
                                     then True
                                 else False
    where permKnopenGr2 = permuteKnopen (knopen graaf2)
          knopenGr1 = (knopen graaf1)
          bogenGr1 = vereenv (bogen graaf1)
          bogenGr2 = vereenv (bogen graaf2)
          vereenv [] = []
          vereenv ((Boog (x,y,_)):rest) = ((x,y)) : (vereenv rest)

matchGevonden :: (Eq a, Eq c) => [[c]] -> [a] -> [(c,c)] -> [(a,a)] -> Bool
matchGevonden [] _ _ _ = False
matchGevonden (permKnGr2:rest) kn1 bg2 bg1 = if gelijk (woordenboek) bg1 bg2
                                                 then True
                                             else matchGevonden rest kn1 bg2 bg1
    where woordenboek = vertaal permKnGr2 kn1
          vertaal permKnGr2 kn1 = zip kn1 permKnGr2

gelijk :: (Eq a, Eq c) => [(a,c)] -> [(a,a)] -> [(c,c)] -> Bool
gelijk woordenboek bg1 bg2 = equiv (mapVert woordenboek bg1) bg2
    where mapVert woordenboek [] = []
          mapVert woordenboek (boog:rest) = (vertaling woordenboek boog) : (mapVert woordenboek rest)
          vertaling woordenboek (x,y) = (vertaald x woordenboek, vertaald y woordenboek)
          vertaald x ((y,z):rest) = if x == y then z
                                    else vertaald x rest

equiv :: (Eq c) => [(c,c)] -> [(c,c)] -> Bool
equiv [] [] = True
equiv ((x,y):rest) bg2 = if elem (x,y) bg2 then equiv rest $ delete (x,y) bg2
                         else if elem (y,x) bg2 then equiv rest $ delete (y,x) bg2
                         else False

permuteKnopen :: (Eq a) => [a] -> [[a]]
permuteKnopen [] = [[]]
permuteKnopen l = [ y | x <- l, y <- map (x:) (permuteKnopen (delete x l))]

delete :: (Eq a) => a -> [a] -> [a]
delete _ [] = []
delete x (el : rest) = if x == el then rest -- enkel eerste x wordt uit lijst verwijderd
                       else el : (delete x rest)

-- Test
graaf1 = Graaf [1, 2, 3, 4]        [Boog (1,2,'a'), Boog (1,3,'a'), Boog (1,4,'a')]
graaf2 = Graaf ['a','b','c','d']   [Boog ('a','b','a'), Boog ('a','c','a'), Boog ('a','d','a')]
graaf3 = Graaf ['w','x','y','z']   [Boog ('x','y','a'), Boog ('y','w','a'), Boog ('z','y','a')]
graaf4 = Graaf [1, 4, 3, 2]        [Boog (1,2,'a'), Boog (1,4,'a'), Boog (1,3,'a')]
graaf5 = Graaf ['a','b','c','d']   [Boog ('a','b','a'), Boog ('b','c','a'), Boog ('c','d','a')]

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

---- IO
reken :: IO ()
reken = do
    input <- getLine
    print (bewerking input)
    where bewerking input = (op input) (get1 input) (get2 input)
          get1 input = getGet 1 input
          get2 input = getGet 5 input
          op   input = getTeken 3 input
          getGet 1 (y:_) =
            if        y == '0' then 0
            else if   y == '1' then 1
            else if   y == '2' then 2
            else if   y == '3' then 3
            else if   y == '4' then 4
            else if   y == '5' then 5
            else if   y == '6' then 6
            else if   y == '7' then 7
            else if   y == '8' then 8
            else                    9
          getGet x (_:rest) = getGet (x - 1) rest
          getTeken 1 (x:_) =
              if x == '*' then (*)
              else             (+)
          getTeken x (_:rest) = getTeken (x - 1) rest
