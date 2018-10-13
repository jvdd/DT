
-- NORMALE VERSIE
{-
isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = insert x (isort xs)

insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys) | x < y = x:y:ys
                | otherwise = y : (insert x ys)
-}


-- POLYMORFE VERSIE
{-
isort :: (t -> t -> Bool) -> [t] -> [t]
isort _ [] = []
-- was  isort (x:xs) = insert x (isort xs)
isort orde (x:xs) = insert orde x (isort orde xs)

insert :: (t -> t -> Bool) -> t -> [t] -> [t]
insert _ x [] = [x]
insert orde x (y:ys)
        | (orde x y) = x:y:ys
        | otherwise = y : (insert orde x ys)
-}


-- OVERLOADING
class HeeftOrde a where     -- klasse-declaratie
        (<<<) :: a -> a -> Bool

isort :: (HeeftOrde t) => [t] -> [t]    -- klasse-constraint
isort [] = []
isort (x:xs) = insert x (isort xs)

insert :: (HeeftOrde t) => t -> [t] -> [t]
insert x [] = [x]
insert x (y:ys) | x <<< y = x:y:ys
                | otherwise = y : (insert x ys)

-- INSTANCE VAN EEN KLASSE
data Dagen = Maan | Dins | Woen | Dond | Vrij -- OF
                    --deriving Show

instance HeeftOrde Dagen where
        Maan <<< _    = True
        _    <<< Maan = False
        Dins <<< _    = True
        _    <<< Dins = False
        Woen <<< _    = True
        _    <<< Woen = False
        Dond <<< _    = True
        _    <<< _    = False

instance Show Dagen where
        show Maan   = "Maan"
        show Dins   = "Dins"
        show Woen   = "Woen"
        show Dond   = "Dond"
