
----------------- data types -----------------

-- Bron: http://learnyouahaskell.com/making-our-own-types-and-typeclasses (sectie Record syntax)
-- Ik weet hoe dit moet dankzij Alexander

{-
data Knoop = Knoop { naam = a
                     aanvaardend = Bool

}
-}

data NFA a b = NFA { begin :: a,
                     aanvaardend :: [a],
                     bogen :: [Boog a b]
                   } deriving (Show)

data Boog a b = Boog { start :: a,
                       naam :: b,
                       aankomst :: a
                     } deriving (Show)


----------------- voorbeelden -----------------

nfa1 = NFA 1 [5,6] [Boog 1 'a' 2, Boog 2 'b' 2, Boog 2 'b' 6,
                    Boog 6 'a' 3, Boog 3 'b' 5, Boog 1 'a' 3,
                    Boog 1 'b' 4, Boog 4 'b' 3, Boog 4 'a' 5]

nfa2 = NFA 'x' ['y','z'] [Boog 'x' 1 'u',                 Boog 'u' 2 'z',
                          Boog 'z' 1 'v', Boog 'v' 2 'y', Boog 'x' 1 'v',
                          Boog 'x' 2 'w', Boog 'w' 2 'v', Boog 'w' 1 'y']


----------------- VRAAG 1 -----------------

{-
accepteert :: (Eq a, Eq b) => NFA a b -> [b] -> Bool
accepteert nfa sequentie = accepteertSeq nfa rest (vindGerichteBogen (start nfa) nfa)
    where accepteertSeq _ _ [] = False
          accepteertSeq nfa (boogNaam : rest) bogen = accepteert nfa rest (geldigeBogen boogNaam bogen)
-}

{-
vindGerichteBuren :: (Eq a) => a -> NFA a b -> [a]
vindGerichteBuren begin nfa = vindEindpunten begin (bogen nfa)
    where vindEindpunten _ [] = []
          vindEindpunten begin (boog : rest) =
                if begin == (start boog) then (aankomst boog) : (vindEindpunten begin rest)
                else vindEindpunten begin rest
-}


vindGerichteBogen :: (Eq a) => a -> NFA a b -> [Boog a b]
vindGerichteBogen begin nfa = vindBogen begin (bogen nfa)
    where vindBogen _ [] = []
          vindBogen begin (boog : rest)  =
                if begin == (start boog) then boog : (vindBogen begin rest)
                else vindBogen begin rest

geldigeBogen :: (Eq b) => b -> [Boog a b] -> [Boog a b]
geldigeBogen _ [] = []
geldigeBogen boogNaam (boog : rest) =
        if boogNaam == (naam boog) then boog : (geldigeBogen boogNaam rest)
        else geldigeBogen boogNaam rest
