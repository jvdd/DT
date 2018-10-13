{-  EXAMEN DT 20/06/2017
  @Author Jeroen Van Der Donckt
-}

-- Data declaraties

data C1DAutom = Autom [Cel] deriving (Show)

instance Eq C1DAutom where
    a == b  = gelijk a b    -- gelijk staat bij Vraag 2

data Cel = Zwart | Wit deriving (Show)
instance Eq Cel where
    Zwart == Zwart  = True
    Wit   == Wit    = True
    _     == _      = False

---- Vraag 1

-- Code
volgende_generatie :: C1DAutom -> Int -> C1DAutom
volgende_generatie autom@(Autom celLijst) getal = genereerVolgende autom l tLijst
    where l = length celLijst
          tLijst = initTLijst kleurLijst
          kleurLijst = maakLengteT binList 8
          binList = getalToBinairLijst getal

getalToBinairLijst :: Int -> [Int]
getalToBinairLijst x = getalToBinairLijst2 x []
    where getalToBinairLijst2 0 acc = acc
          getalToBinairLijst2 x acc = getalToBinairLijst2 (div x 2) $ (mod x 2) : acc

maakLengteT :: [Int] -> Int -> [Int]
maakLengteT lijst l = if (length lijst) == l then lijst
                      else maakLengteT (0:lijst) l

initTLijst :: [Int] -> [((Int,Int,Int),Int)]
initTLijst kleurLijst = zip tVolgorde kleurLijst
    where tVolgorde = [(1,1,1),(1,1,0),(1,0,1),(1,0,0),(0,1,1),(0,1,0),(0,0,1),(0,0,0)]

genereerVolgende :: C1DAutom -> Int -> [((Int,Int,Int),Int)] -> C1DAutom
genereerVolgende autom l tLijst = toAutom $ genereerVolgende2 autom l l tLijst
    where genereerVolgende2 _ 0 _ _ = []
          genereerVolgende2 autom@(Autom celLijst) index l tLijst = (getKleur (getDrieTupleIndex celLijst index l) tLijst) : (restKleur index)
          restKleur index = genereerVolgende2 autom (index - 1) l tLijst
          getKleur tuple ((tTuple,kleur):rest) = if tuple == tTuple then kleur
                                                 else getKleur tuple rest

getDrieTupleIndex :: [Cel] -> Int -> Int -> (Int,Int,Int)
getDrieTupleIndex celLijst index l = (binLE,binIE,binRE)
    where newIndex = index - 1
          binLE = vertaalKleurToBin $ getElem celLijst (mod (newIndex - 1) l)
          binIE = vertaalKleurToBin $ getElem celLijst newIndex
          binRE = vertaalKleurToBin $ getElem celLijst (mod (newIndex + 1) l)
          getElem (x:_) 0 = x
          getElem (_:rest) y = getElem rest (y - 1)
          vertaalKleurToBin Zwart = 0
          vertaalKleurToBin Wit = 1

toAutom :: [Int] -> C1DAutom
toAutom lijst = Autom $ toAutom2 lijst []
    where toAutom2 [] acc = acc
          toAutom2 (x:rest) acc = if x == 0 then (toAutom2 rest (Zwart:acc))
                                  else (toAutom2 rest (Wit:acc))

-- TEST

test1 = volgende_generatie (Autom [Wit,Zwart,Zwart,Wit,Zwart,Wit]) 105


---- Vraag 2

eerste_al_gezien :: C1DAutom -> Int -> C1DAutom
eerste_al_gezien autom getal = herhaling [gen1] getal
    where gen1 = volgende_generatie autom getal

herhaling :: [C1DAutom] -> Int -> C1DAutom
herhaling (vorig:rest) getal = if kwamEerderVoor then volgende
                         else herhaling (volgende:vorig:rest) getal
    where volgende = volgende_generatie vorig getal
          kwamEerderVoor = elem volgende (vorig:rest)

gelijk :: C1DAutom -> C1DAutom -> Bool
gelijk (Autom a) (Autom b) = elem a $ alternatieven ((length b) - 1) [b]
    where alternatieven 0 acc = acc
          alternatieven x (vorig:rest) = alternatieven (x - 1) $ (schuifDoor vorig) : vorig : rest
          schuifDoor (x:rest) = rest ++ [x]

-- TEST

test2 = eerste_al_gezien (Autom [Wit,Zwart,Zwart,Wit,Zwart,Wit]) 105
