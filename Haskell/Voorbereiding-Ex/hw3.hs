
-- Data declaraties (record syntax)
data NFA a b = NFA { start :: a,
                     aanv  :: [a],
                     bogen :: [Boog a b]
                   } deriving (Show)

data Boog a b = Boog { van  :: a,
                       val  :: b,
                       naar :: a
                     } deriving (Show)

-- Voorbeelden
nfa1 = NFA 1 [5,6] [Boog 1 'a' 2, Boog 2 'b' 2, Boog 2 'b' 6,
                 Boog 6 'a' 3, Boog 3 'b' 5, Boog 1 'a' 3,
                 Boog 1 'b' 4, Boog 4 'b' 3, Boog 4 'a' 5]

nfa2 = NFA 'x' ['y','z'] [Boog 'x' 1 'u',                 Boog 'u' 2 'z',
                       Boog 'z' 1 'v', Boog 'v' 2 'y', Boog 'x' 1 'v',
                       Boog 'x' 2 'w', Boog 'w' 2 'v', Boog 'w' 1 'y']


---- VRAAG 1
accepteert :: (Eq a, Eq b) => NFA a b -> [b] -> Bool
accepteert nfa sequentie = length (vindOplossingen nfa sequentie) >= 1

vindOplossingen :: (Eq a, Eq b) => NFA a b -> [b] -> [[a]]
vindOplossingen nfa sequentie = aanvaarded (aanv nfa) $ zoekOplossingen [[(start nfa)]] nfa sequentie
    where zoekOplossingen start nfa sequentie = zoekOplossingen2 start nfa [] sequentie
          zoekOplossingen2 paden _ _ [] = paden
          zoekOplossingen2 [] nfa acc (_:xs) = zoekOplossingen2 acc nfa [] xs
          zoekOplossingen2 (vorig:rest) nfa acc (x:xs) = zoekOplossingen2 rest nfa ((vindVolgende vorig (bogen nfa) x) ++ acc) (x:xs)
          vindVolgende vorig bogen x = expandeer vorig (alleBogen (head vorig) bogen x)
          expandeer vorig [] = []
          expandeer vorig (x:rest) = (x:vorig) : (expandeer vorig rest)
          alleBogen begin bogen x = [(naar b) | b <- bogen, (van b) == begin, (val b) == x]

aanvaarded :: (Eq a) => [a] -> [[a]] -> [[a]]
aanvaarded aanv [] = []
aanvaarded aanv (opl:rest) = if elem (head opl) aanv then opl : (aanvaarded aanv rest)
                             else aanvaarded aanv rest

test1 = accepteert nfa1 "abbbb" == True &&
        accepteert nfa1 "baaa" == False


---- VRAAG 2
meermaals :: (Eq a, Eq b) => NFA a b -> [b] -> Bool
meermaals nfa sequentie = length (vindOplossingen nfa sequentie) > 1

test2 = meermaals nfa1 "abbbb" == False &&
        meermaals nfa1 "baaa" == False &&
        meermaals nfa1 "ab" == True


---- VRAAG 3
oneindig :: (Eq a, Eq b) => NFA a b -> Bool
oneindig nfa = if lussen == [] then False
               else if aanvPadLangsLussen lussen aanvPaden then True
               else False
    where lussen = vindLussen nfa
          aanvPaden = alleAanvPadenZonderLus nfa

vindLussen :: (Eq a) => NFA a b -> [a]
vindLussen nfa = [(van b) | b <- (bogen nfa), (van b) == (naar b)]

aanvPadLangsLussen :: (Eq a) => [a] -> [[a]] -> Bool
aanvPadLangsLussen [] _ = False
aanvPadLangsLussen (x:rest) aanvPaden = if inPad x aanvPaden then True
                                        else aanvPadLangsLussen rest aanvPaden
    where inPad _ [] = False
          inPad x (pad:rest) = if elem x pad then True
                               else inPad x rest

alleAanvPadenZonderLus :: (Eq a) => NFA a b -> [[a]]
alleAanvPadenZonderLus nfa = zoekAllePaden [[(start nfa)]] nfa []
    where zoekAllePaden [] _ acc = acc
          zoekAllePaden (pad:rest) nfa acc = zoekAllePaden (rest ++ nietAanvP) nfa (aanvP ++ acc)
              where nietAanvP = fst $ split expand pad (aanv nfa)
                    aanvP = snd $ split expand pad (aanv nfa)
                    expand = volgende pad (bogen nfa)
          volgende pad bogen = [(naar b) | b <- bogen, (van b) == (head pad), not $ elem (naar b) pad] -- bogen zonder lus of kring v/h pad exapenderen
          split expand pad aanv = split2 expand pad aanv [] []
          split2 [] _ _ acc1 acc2 = (acc1,acc2)
          split2 (x:rest) pad aanv acc1 acc2 = if elem x aanv then split2 rest pad aanv acc1 ([(x:pad)] ++ acc2)
                                               else split2 rest pad aanv ([x:pad] ++ acc1) acc2

test3 = oneindig nfa1 == True &&
        oneindig nfa2 == False


---- Vraag 4
toplevel :: (Eq a) => NFA a Char -> IO()
toplevel nfa = do
    sequentie <- getLine
    if accepteert nfa sequentie then putStrLn "geaccepteerd"
    else putStrLn "verworpen"
