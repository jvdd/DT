
data Keigraaf t = K [(t, t)] [(t, Int)] deriving (Eq, Show)

maak_keigraaf :: [Int] -> Keigraaf Int
maak_keigraaf ints = K (zip (l:[1..l-1]) [1..l]) (zip [1..l] ints)
   where l = length ints

herhalend :: Eq t => Keigraaf t -> (Keigraaf t, Int)
herhalend graaf = loop [graaf] graaf
   where loop vorige graaf =
            let
               nieuw = update_all graaf
               (gevonden, lengte) = zoeklus nieuw vorige
            in
               if gevonden
               then (nieuw, lengte)
               else loop (nieuw:vorige) nieuw

zoeklus :: Eq a => a -> [a] -> (Bool, Int)
zoeklus x xs = zoeklus' xs 1
   where
      zoeklus' [] _ = (False, 0)
      zoeklus' (y:ys) count =
         if x == y
         then (True, count)
         else zoeklus' ys (count + 1)

update_all :: Eq t => Keigraaf t -> Keigraaf t
update_all graaf@(K _ keien) = foldr update (leeg graaf) keien

leeg :: Keigraaf t -> Keigraaf t
leeg (K bogen keien) = K bogen (map (\(a,b) -> (a,0)) keien)

update :: Eq t => (t, Int) -> Keigraaf t -> Keigraaf t
update (x, aantal) graaf@(K bogen keien) = K bogen (map check keien)
   where
      buren = verbonden x graaf
      (teverdelen, rest) = divMod aantal (length buren)
      check (knoop, gewicht)
         | knoop == x         = (knoop, gewicht + rest)
         | elem knoop buren   = (knoop, gewicht + teverdelen)
         | otherwise          = (knoop, gewicht)

verbonden :: Eq t => t -> Keigraaf t -> [t]
verbonden x (K bogen _) = zoek bogen
   where
      zoek [] = []
      zoek ((a,b):rest)
         | a == x    = b : zoek rest
         | b == x    = a : zoek rest
         | otherwise = zoek rest

tests =
   herhalend (maak_keigraaf [5,3,2]) ==
      (K [(3,1),(1,2),(2,3)] [(1,3),(2,4),(3,3)], 2)
