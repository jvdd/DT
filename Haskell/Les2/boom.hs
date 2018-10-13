-- DATA IBOOM
data IBoom = Knoop IBoom IBoom | Blad Int


-- BALANCED
balanced :: IBoom -> Bool
balanced (Knoop left right) =
		let l = diepte left
		    r = diepte right
		in (ok l r) && (balanced left) && (balanced right)
balanced (Blad _) =  True

diepte :: IBoom -> Int
diepte (Knoop l r) = 1 + maxi (diepte l) (diepte r)
diepte (Blad _)    = 1

ok :: Int -> Int -> Bool
ok l r = (l==r) || (l == (r+1)) || ((l+1) == r)

maxi :: Int -> Int -> Int
maxi x y
	| x > y     = x
	| otherwise = y


-- BLADEREN
data Boom a = Knoop (Boom a) (Boom a) | Blad a
bladeren :: Boom a -> [a]
bladeren (Knoop l r) = bladeren l ++ bladeren r
bladeren (Blad b) = [b]
