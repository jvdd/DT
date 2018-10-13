----------------- Data types -----------------

-- Onderstel een orde op de knopen
data Boog a = Boog { start :: a,
                     einde :: a,
                     capaciteit :: Int
                   } deriving (Show)

data GerichteGraaf a = GerichteGraaf { bron :: a,
                                       put :: a,
                                       bogen :: [Boog a]
                                     } deriving (Show)

data Label a = L a a Int deriving (Show)-- Ook eens andere manier zonder record syntax proberen

data Stroom a = F a a Int deriving (Show) -- Ook eens andere manier zonder record syntax proberen


----------------- Voorbeelden -----------------

-- Figuur 1.69 cursus FVI
gerGraaf1 = GerichteGraaf 'a' 'z' [Boog 'a' 'b' 7, Boog 'a' 'd' 2, Boog 'b' 'd' 3,
                                   Boog 'c' 'b' 4, Boog 'c' 'z' 4, Boog 'd' 'c' 4]


----------------- Algoritme -----------------

-- Algoritme: Constructie van een maximale stroming.
maxStroming ::(Ord a) => GerichteGraaf a -> [Stroom a]
maxStroming gerGraaf = fst (maxStroningEnLabels gerGraaf) -- Behandelde knopen = []

maxStroningEnLabels :: (Ord a) => GerichteGraaf a -> ([Stroom a],[a])
maxStroningEnLabels gerGraaf = execAlgo gerGraaf (initialisatie gerGraaf) (labelDeBron gerGraaf) []

execAlgo :: (Ord a) => GerichteGraaf a -> [Stroom a] -> [Label a] -> [a] -> ([Stroom a], [a])
execAlgo gerGraaf stroom labels behandeld =
        if (aangekomen (put gerGraaf) labels) then execAlgo gerGraaf (verbeterStroming gerGraaf stroom labels) (labelDeBron gerGraaf) [] -- Als aangekomen dan verbeter stroming en ga naar 2.
        else if length labels == length behandeld then (stroom, behandeld)       --TODO niet zeker: L\B = Leeg
        else execAlgo gerGraaf stroom ((labelBuren (kiesVolgendeKnoop labels behandeld) gerGraaf labels stroom) ++ labels) ((kiesVolgendeKnoop labels behandeld) : behandeld)

-- 1. Initialisatie
initialisatie :: GerichteGraaf a -> [Stroom a]
initialisatie gerGraaf = definieerF gerGraaf
    where definieerF gerGraaf = [F (start boog) (einde boog) 0 | boog <- (bogen gerGraaf)]

-- 2. Label de bron
labelDeBron :: GerichteGraaf a -> [Label a]
labelDeBron gerGraaf =  [L (bron gerGraaf) (bron gerGraaf) (maxBound)]

-- 3. Aangekomen?
aangekomen :: (Eq a) => a -> [Label a] -> Bool
aangekomen _ [] = False
aangekomen knoop ((L labelKnoop _ _) : rest) = if knoop == labelKnoop then True
                                                else aangekomen knoop rest

verbeterStroming :: (Eq a) => GerichteGraaf a -> [Stroom a] -> [Label a] -> [Stroom a]
verbeterStroming gerGraaf stroom labels = updateStroming (put gerGraaf) stroom labels (getDelta (put gerGraaf) labels)
    where updateStroming knoop stroom labels delta = if (voorganger knoop labels) == knoop then stroom
                                                     else updateStroming (voorganger knoop labels) (updateStroom (voorganger knoop labels) knoop stroom delta) labels delta
          updateStroom knoop1 knoop2 ((F x y stroom) : rest) delta = if (x == knoop1) && (y == knoop2) then ((F x y (stroom + delta)) : rest)        -- Goede knoop
                                                                     else if (y == knoop1) && (x == knoop2) then ((F x y (stroom - delta)) : rest)   -- Slechte knoop
                                                                     else (F x y stroom) : (updateStroom knoop1 knoop2 rest delta)

getDelta :: (Eq a) => a -> [Label a] -> Int
getDelta knoop ((L x _ delta) : rest) = if x == knoop then delta
                                        else getDelta knoop rest

voorganger knoop ((L x y _) : rest) = if x == knoop then y
                                      else voorganger knoop rest

-- 4. Kies volgende knoop
kiesVolgendeKnoop :: (Ord a) => [Label a] -> [a] -> a
kiesVolgendeKnoop labels behandeld = kies (qs (alleGelabeldeKnopen labels)) behandeld -- qs gebruiken om label met kleinste index i te selecteren
    where alleGelabeldeKnopen [] = []
          alleGelabeldeKnopen ((L x _ _) : rest) = x : (alleGelabeldeKnopen rest)
          kies (knoop : rest) behandeld = if not (bevat knoop behandeld) then knoop
                                          else kies rest behandeld

qs :: (Ord a) => [a] -> [a]
qs [] = []
qs (pivot:xs) = (qs [x | x <- xs, x > pivot]) ++ (pivot : qs [y | y <-xs, y < pivot])

bevat :: (Eq a) => a -> [a] -> Bool
bevat _ [] = False
bevat x (y : rest) = if x == y then True
                     else bevat x rest

-- 5. Label buren
labelBuren :: (Eq a) => a -> GerichteGraaf a -> [Label a] -> [Stroom a] -> [Label a]
labelBuren knoop gerGraaf labels stroom = geefBurenLabel knoop (burenZonderLabel (vindAlleBuren knoop gerGraaf) labels) (getDelta knoop labels) stroom gerGraaf
    where vindAlleBuren knoop gerGraaf = [if ((start boog) == knoop) then (einde boog) else (start boog) | boog <- (bogen gerGraaf), (start boog) == knoop || (einde boog) == knoop]
          burenZonderLabel [] _ = []
          burenZonderLabel (knoop : rest) labels = if not (aangekomen knoop labels) then knoop : (burenZonderLabel rest labels)
                                                   else burenZonderLabel rest labels
          geefBurenLabel _ [] _ _ _ = []
          geefBurenLabel knoop (buur : rest) delta stroom gerGraaf= (geefLabel knoop buur delta stroom gerGraaf) ++ (geefBurenLabel knoop rest delta stroom gerGraaf)
          geefLabel _ _ _ [] _ = []
          geefLabel knoop buur delta ((F x y val) : rest) gerGraaf = if x == knoop && y == buur then -- goede boog
                                                                            if (getCapaciteit gerGraaf x y) > val then [L y x (min delta ((getCapaciteit gerGraaf x y) - val))]
                                                                            else []
                                                                     else if y == knoop && x == buur then
                                                                            if val > 0 then [L y x (min delta val)]
                                                                            else []
                                                                     else geefLabel knoop buur delta rest gerGraaf

getCapaciteit :: (Eq a) => GerichteGraaf a -> a -> a -> Int
getCapaciteit gerGraaf x y = capaciteitBoog (bogen gerGraaf) x y
    where capaciteitBoog [] _ _ = minBound -- Komt nooit voor (maar moet om error bij compileren te vermijden)
          capaciteitBoog (boog : rest) x y = if ((start boog) == x) && ((einde boog) == y) then (capaciteit boog)
                                             else capaciteitBoog rest x y

-- Minimale snede (met IO)

maxStromingMinSnede :: (Ord a, Show a) => GerichteGraaf a -> IO()
maxStromingMinSnede gerGraaf = do
        putStrLn ("Maximale stroming: " ++ show (maxStroming gerGraaf))
        putStrLn ("Minimale snede: P = " ++ show (fst (minimaleSnedeVerz gerGraaf (snd (maxStroningEnLabels gerGraaf)))))
        putStrLn ("Minimale snede : ~P = " ++ show (snd (minimaleSnedeVerz gerGraaf (snd (maxStroningEnLabels gerGraaf)))))
        putStrLn ("Capaciteit minimale snede: " ++ show (capaciteitSnede gerGraaf (minimaleSnedeVerz gerGraaf (snd (maxStroningEnLabels gerGraaf)))))
        putStrLn ("Stroom in put: " ++ show (stroomInKnoop (maxStroming gerGraaf) (put gerGraaf)))

minimaleSnedeVerz :: (Ord a) => GerichteGraaf a -> [a] -> ([a],[a])
minimaleSnedeVerz gerGraaf behandeld = (behandeld,(vind2deVerz behandeld (vindAlleKnopen gerGraaf)))
    where vindAlleKnopen gerGraaf = qs ((bron gerGraaf) : [(einde boog) | boog <- (bogen gerGraaf)]) -- Alle knopen buiten de bron zijn het einde van een boog
          vind2deVerz [] andereVerz = andereVerz
          vind2deVerz (knoop : rest) knopen = vind2deVerz rest (verwijder knoop knopen)
          verwijder knoop (x : rest) = if x == knoop then rest
                                       else x : (verwijder knoop rest)

capaciteitSnede :: (Eq a) => GerichteGraaf a -> ([a], [a]) -> Int
capaciteitSnede gerGraaf snedeVerz = capacitetBogen (goedeBogenOpSnede gerGraaf (fst snedeVerz) (snd snedeVerz))
    where goedeBogenOpSnede gerGraaf verz1 verz2 = [boog | boog <- (bogen gerGraaf), bevat (start boog) verz1, bevat (einde boog) verz2]
          capacitetBogen [] = 0
          capacitetBogen (boog : rest) = (capaciteit boog) + (capacitetBogen rest)

stroomInKnoop :: (Eq a) => [Stroom a] -> [a] -> Int
stroomInKnoop [] _ = 0
stroomInKnoop ((F _ y val) : rest) knoop = if y == knoop then val + (stroomInKnoop rest knoop)
                                           else stroomInKnoop rest knoop

---- DEBUG

d1 = initialisatie gerGraaf1
d2 = labelDeBron gerGraaf1
d3 = execAlgo gerGraaf1 (initialisatie gerGraaf1) (labelDeBron gerGraaf1) []
d4 = aangekomen (put gerGraaf1) (labelDeBron gerGraaf1)
d5 = length (labelDeBron gerGraaf1) == length []
d6 = (labelBuren (kiesVolgendeKnoop (labelDeBron gerGraaf1) []) gerGraaf1 (labelDeBron gerGraaf1) (initialisatie gerGraaf1)) ++ (labelDeBron gerGraaf1)


l1 = labelBuren 'a' gerGraaf1 (labelDeBron gerGraaf1) (initialisatie gerGraaf1)
