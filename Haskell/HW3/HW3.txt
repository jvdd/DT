
----------------- Data types -----------------

-- Bron: http://learnyouahaskell.com/making-our-own-types-and-typeclasses (sectie Record syntax)
-- Ik weet hoe dit moet dankzij Alexander

data NFA a b = NFA { begin :: a,
                     aanvaardend :: [a],
                     bogen :: [Boog a b]
                   } deriving (Show)

data Boog a b = Boog { start :: a,
                       naam :: b,
                       aankomst :: a
                     } deriving (Show)


----------------- Voorbeelden -----------------

nfa1 = NFA 1 [5,6] [Boog 1 'a' 2, Boog 2 'b' 2, Boog 2 'b' 6,
                    Boog 6 'a' 3, Boog 3 'b' 5, Boog 1 'a' 3,
                    Boog 1 'b' 4, Boog 4 'b' 3, Boog 4 'a' 5]

nfa2 = NFA 'x' ['y','z'] [Boog 'x' 1 'u',                 Boog 'u' 2 'z',
                          Boog 'z' 1 'v', Boog 'v' 2 'y', Boog 'x' 1 'v',
                          Boog 'x' 2 'w', Boog 'w' 2 'v', Boog 'w' 1 'y']


----------------- VRAAG 1 -----------------

accepteert :: (Ord a, Ord b) => NFA a b -> [b] -> Bool
accepteert nfa sequentie = length (vindOplossingen nfa sequentie) >= 1
{-
    where accepteertSeq _ _ [] = False
          accepteertSeq nfa [] eindBogen = length(aanvaardBogen nfa eindBogen) >= 1
          accepteertSeq nfa (boogNaam : rest) bogen = accepteertSeq nfa rest (qsBoog (volgendeBogen nfa (geldigeBogen boogNaam bogen)))
-}

vindOplossingen :: (Ord a, Ord b) => NFA a b -> [b] -> [Boog a b]
vindOplossingen nfa (boogNaam : restSeq) = acceptSeqBogen nfa boogNaam restSeq (vindGerichteBogen nfa (begin nfa))
    where acceptSeqBogen _ _ _ [] = []
          acceptSeqBogen nfa boogNaam [] eindBogen = aanvaardBogen nfa (geldigeBogen boogNaam eindBogen)
          -- acceptSeqBogen nfa boogNaam (nextBoogNaam : restSeq) bogen = acceptSeqBogen nfa nextBoogNaam restSeq (qsBoog (volgendeBogen nfa (geldigeBogen boogNaam bogen)))
          acceptSeqBogen nfa boogNaam (nextBoogNaam : restSeq) bogen = acceptSeqBogen nfa nextBoogNaam restSeq (volgendeBogen nfa (geldigeBogen boogNaam bogen))
{-
vindGerichteBuren :: (Eq a) => a -> NFA a b -> [a]
vindGerichteBuren begin nfa = vindEindpunten begin (bogen nfa)
    where vindEindpunten _ [] = []
          vindEindpunten begin (boog : rest) =
                if begin == (start boog) then (aankomst boog) : (vindEindpunten begin rest)
                else vindEindpunten begin rest
-}


vindGerichteBogen :: (Eq a) => NFA a b -> a -> [Boog a b]
vindGerichteBogen nfa begin = vindBogen begin (bogen nfa)
    where vindBogen _ [] = []
          vindBogen begin (boog : rest)  =
                if begin == (start boog) then boog : (vindBogen begin rest)
                else vindBogen begin rest

geldigeBogen :: (Eq b) => b -> [Boog a b] -> [Boog a b]
geldigeBogen _ [] = []
geldigeBogen boogNaam (boog : rest) =
        if boogNaam == (naam boog) then boog : (geldigeBogen boogNaam rest)
        else geldigeBogen boogNaam rest

volgendeBogen :: (Eq a) => NFA a b -> [Boog a b] -> [Boog a b]
volgendeBogen _ [] = []
volgendeBogen nfa (boog : rest) = (vindGerichteBogen nfa (aankomst boog)) ++ (volgendeBogen nfa rest)

qsBoog :: (Ord a, Ord b) => [Boog a b] -> [Boog a b]
qsBoog [] = []
qsBoog (pivot:xs) = (qsBoog groter) ++ (pivot : qsBoog kleiner)
    where groter = [x | x <- xs, (start x) > (start pivot) || (naam x) > (naam pivot) || (aankomst x) > (aankomst pivot)]
          kleiner = [y | y <-xs, (start y) < (start pivot) || (naam y) < (naam pivot) || (aankomst y) < (aankomst pivot)]


aanvaardBogen :: (Eq a) => NFA a b -> [Boog a b] -> [Boog a b]
aanvaardBogen _ [] = []
aanvaardBogen nfa (boog : rest) = if elem (aankomst boog) (aanvaardend nfa) then boog : (aanvaardBogen nfa rest)
                                  else aanvaardBogen nfa rest


----------------- VRAAG 2 -----------------

meermaals :: (Ord a, Ord b) => NFA a b -> [b] -> Bool
meermaals nfa sequentie = length (vindOplossingen nfa sequentie) > 1


----------------- VRAAG 3 -----------------

oneindig :: (Ord a) => NFA a b -> Bool
oneindig nfa = bereiktAanvToest nfa (vindLussen nfa)

vindLussen :: (Eq a) => NFA a b -> [Boog a b]
vindLussen nfa = [boog | boog <- (bogen nfa), (start boog) == (aankomst boog)]

bereiktAanvToest :: (Ord a) => NFA a b -> [Boog a b] -> Bool
bereiktAanvToest _ [] = False
bereiktAanvToest nfa (boog : rest) =
        if heeftAanvToest (aanvaardend nfa) (bereikbareKnopen (bogen nfa) (vindAlleBuren (bogen nfa) (begin nfa)) []) then True
        else bereiktAanvToest nfa rest
        {-where bereikbareKnopen _ [] behandeld = behandeld
              bereikbareKnopen bogen (nknoop : rest) behandeld = bereikbareKnopen (nextNieuw (vindAlleBuren bogen nknoop) rest behandeld) (nknoop : behandeld)
              nextNieuw [] nieuw _ = nieuw
              nextNieuw (bknoop : rest) nieuw behandeld =
                    if not (bknoop elem behandeld) then bknoop : (nextNieuw rest nieuw behandeld)
                    else nextNieuw rest nieuw behandeld-}

bereikbareKnopen :: (Ord a) => [Boog a b] -> [a] -> [a] -> [a]
bereikbareKnopen _ [] behandeld = behandeld
bereikbareKnopen bogen (nknoop : rest) behandeld = bereikbareKnopen bogen (qs (nextNieuw (vindAlleBuren bogen nknoop) rest behandeld)) (nknoop : behandeld)

nextNieuw :: (Eq a) => [a] -> [a] -> [a] -> [a]
nextNieuw [] nieuw _ = nieuw
nextNieuw (bknoop : rest) nieuw behandeld =
    if not (elem bknoop behandeld) then (bknoop : (nextNieuw rest nieuw behandeld))
    else nextNieuw rest nieuw behandeld

qs :: (Ord a) => [a] -> [a]
qs [] = [] -- qs gebruiken om dubbele waarden te verwijderen
qs (pivot:xs) = (qs [x | x <- xs, x > pivot]) ++ (pivot : qs [y | y <-xs, y < pivot])

heeftAanvToest :: (Eq a) => [a] -> [a] -> Bool
heeftAanvToest [] _ = False
heeftAanvToest (aanvToest : rest1) bereikbareKnopen =
        if inBereikbareKnopen aanvToest bereikbareKnopen then True
        else heeftAanvToest rest1 bereikbareKnopen
        where inBereikbareKnopen aanvToest (knoop : rest) =
                    if aanvToest == knoop then True
                    else inBereikbareKnopen aanvToest rest

vindAlleBuren :: (Eq a) => [Boog a b] -> a -> [a]
vindAlleBuren bogen knoop = [aankomst boog | boog <- bogen, (start boog) == knoop]

{-
vindAlleKnopen :: (Ord a) => NFA a b -> [a]
vindAlleKnopen nfa = qs ((begin nfa) ++ [knoop | boog <- (boge nfa), knoop <- (aankomst boog)]) -- Alle bogen buiten startknoop worden bereikt
    where qs [] = [] -- qs gebruiken om dubbele waarden te verwijderen
          qs (pivot:xs) = (qs [x | x <- xs, x > pivot]) ++ (pivot : qs [y | y <-xs, y < pivot])

verbondenKnopen nfa knoop = vindGerichteBogen nfa knoop
    where verdereKnopen knopen (boog : rest) nfa boogNaam (nextBoogNaam : restSeq) bogen = acceptSeqBogen nfa nextBoogNaam restSeq (volgendeBogen nfa (geldigeBogen boogNaam bogen))

-}

{-
bereiktAanvToest :: NFA a b -> [Boog a b] -> bool
bereiktAanvToest nfa bogen = raaktTotEindknoop nfa bogen
    where raaktTotEindknoop nfa (boog : rest) =
        if nfa alleBereikBareKnopen nfa (start boog)
           hhh

alleBereikBareKnopen :: (Eq a) => NFA a b -> a -> [a]
alleBereikBareKnopen nfa start = vindBuren begin (bogen nfa)
    where vindBuren _ [] = []
          vindBuren start (boog : rest) =
                if start == (start boog) then (aankomst boog) : (vindEindpunten begin rest)
                else vindEindpunten begin rest
          vindEindpunten _ [] = []
          vindEindpunten begin (boog : rest) =
                if begin == (start boog) then (aankomst boog) : (vindEindpunten begin rest)
                else vindEindpunten begin rest

vindGerichteBuren :: (Eq a) => a -> NFA a b -> [a]
vindGerichteBuren begin nfa = vindEindpunten begin (bogen nfa)
    where vindEindpunten _ [] = []
          vindEindpunten begin (boog : rest) =
                if begin == (start boog) then (aankomst boog) : (vindEindpunten begin rest)
                else vindEindpunten begin rest
-}


----------------- VRAAG 5 -----------------

-- Bron: http://learnyouahaskell.com/input-and-output

toplevel :: (Ord a) => NFA a Char -> IO()
toplevel nfa = do
    sequentie <- getLine
    if accepteert nfa sequentie then putStrLn("geaccepteerd")
    else putStrLn("verworpen")


----------------- TEST -----------------
test = accepteert nfa1 "abbbb" == True &&
       accepteert nfa1 "baaa" == False &&
       meermaals nfa1 "abbbb" == False &&
       meermaals nfa1 "baaa" == False &&
       meermaals nfa1 "ab" == True &&
       oneindig nfa1 == True &&
       oneindig nfa2 == False


----------------- DEBUG -----------------
d1 = vindOplossingen nfa1 "ba"
d2 = vindGerichteBogen nfa1 (begin nfa1)
d3 = geldigeBogen 'b' (vindGerichteBogen nfa1 (begin nfa1))
d4 = volgendeBogen nfa1 (geldigeBogen 'b' (vindGerichteBogen nfa1 (begin nfa1)))
d5 = qsBoog (volgendeBogen nfa1 (geldigeBogen 'b' (vindGerichteBogen nfa1 (begin nfa1))))
d6a = geldigeBogen 'a' (volgendeBogen nfa1 (geldigeBogen 'b' (vindGerichteBogen nfa1 (begin nfa1))))
d7a = volgendeBogen nfa1 (geldigeBogen 'a' (volgendeBogen nfa1 (geldigeBogen 'b' (vindGerichteBogen nfa1 (begin nfa1)))))
