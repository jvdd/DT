---- Vraag 1
-- String matching
max_overeenkomst :: [Char] -> [Char] -> ([Char], Int)
max_overeenkomst string1 string2 = vindMaxOvereenkomst string1 string2 []
    where vindMaxOvereenkomst [] _ maxMatch = (maxMatch, (length maxMatch))
          vindMaxOvereenkomst (x : rest1) string2 maxMatch =
                if (length $ maxL (vindMatches x rest1 string2)) > (length maxMatch)
                        then vindMaxOvereenkomst rest1 string2 (maxL (vindMatches x rest1 string2))
                else vindMaxOvereenkomst rest1 string2 maxMatch
          vindMatches _ _ [] = []
          vindMatches x rest1 (y : rest2) =
                if x == y then (x : (vindMatch rest1 rest2)) : (vindMatches x rest1 rest2)
                else vindMatches x rest1 rest2
          vindMatch [] _ = []
          vindMatch _ [] = []
          vindMatch (x : rest1) (y : rest2) =
                if x == y then x : (vindMatch rest1 rest2)
                else []

maxL :: [[Char]] -> [Char]
maxL lijst = maxL2 lijst []
    where maxL2 [] maxLijst = maxLijst
          maxL2 (x : rest) maxLijst = if (length x) > (length maxLijst) then maxL2 rest x
                                      else maxL2 rest maxLijst

test1 = max_overeenkomst "abcdefgh" "xcdeyz"
test2 = max_overeenkomst "abcdefghi" "xabydefzefght"


---- Vraag 2
-- De keigraaf

-- Data
data Boog a = Boog a a
data Kei a = Kei a Int

data KeiGraaf a = KeiGraaf { keien :: [(a,Int)],
                             bogen :: [(a,a)]
                           } deriving (Show, Eq)

-- Voorbeeld
keiGraaf1 = KeiGraaf [('a',5), ('b',3), ('c',2)]
                     [('a','b'), ('b','c'), ('a','c')]

-- Code
herhalend :: (Eq a) => KeiGraaf a -> (KeiGraaf a,Int)
herhalend keigraaf = herhalendL [keigraaf]
    where herhalendL keigraafLijst =
            if herhaling $ volgende keigraafLijst
                    then (head $ volgende keigraafLijst, periode $ volgende keigraafLijst)
            else herhalendL $ volgende keigraafLijst

herhaling :: (Eq a) => [KeiGraaf a] -> Bool
herhaling (nieuwe : rest) = equalKeiGraaf nieuwe rest
    where equalKeiGraaf nieuwe rest =  elem (keien nieuwe) (map keien rest)

periode :: (Eq a) => [KeiGraaf a] -> Int
periode (nieuwe : rest) = periodeKeiGraaf nieuwe rest 1
    where periodeKeiGraaf nieuwe (vorige : rest) acc =
            if (==) (keien nieuwe) (keien vorige) then acc
            else periodeKeiGraaf nieuwe rest (acc + 1)

volgende :: (Eq a) => [KeiGraaf a] -> [KeiGraaf a]
volgende (vorige : rest) = (veerdeelKeien (vindKnopen vorige) vorige (initAcc vorige)) : vorige : rest
    where veerdeelKeien [] keigraaf acc = newKeigraaf keigraaf acc
          veerdeelKeien (x : rest) keigraaf acc =
                if length (vindBuren x keigraaf) > (vindWaarde x $ keien keigraaf)
                            then veerdeelKeien rest keigraaf (updateKei x (vindWaarde x $ keien keigraaf) acc)
                else veerdeelKeien rest keigraaf (updateKei x (mod (vindWaarde x $ keien keigraaf) (length $vindBuren x keigraaf)) (updateBuren x keigraaf acc))
          vindKnopen keigraaf = [x | (x,y) <- (keien keigraaf)]
          initAcc keigraaf = [(x,0) | (x,_) <- (keien keigraaf)]

updateKei :: (Eq a) => a -> Int -> [(a,Int)] -> [(a,Int)]
updateKei x val ((y,w) : rest) = if x == y then (x,(w+val)) : rest
                                 else (y,w) : (updateKei x val rest)

updateBuren :: (Eq a) => a -> KeiGraaf a -> [(a,Int)] -> [(a,Int)]
updateBuren x keigraaf acc = update (vindBuren x keigraaf) (div (vindWaarde x $ keien keigraaf) (length $ vindBuren x keigraaf)) acc
    where update [] _ acc = acc
          update (x : rest) val acc = update rest val (updateKei x val acc)

vindBuren :: (Eq a) => a -> KeiGraaf a -> [a]
vindBuren x keigraaf = [if a == x then b else a | (a,b) <- (bogen keigraaf), a == x || b == x]

vindWaarde :: (Eq a) => a -> [(a,b)] -> b
vindWaarde x ((y,w) : rest) = if x == y then w
                            else vindWaarde x rest

newKeigraaf :: KeiGraaf a -> [(a,Int)] -> KeiGraaf a
newKeigraaf keigraaf acc = KeiGraaf acc $ bogen keigraaf

test = herhalend keiGraaf1
