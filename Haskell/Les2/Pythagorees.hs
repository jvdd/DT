-- Versie 1 (werkt niet)
{-
pythagorees = [(a,b,c) | a <- [1..], b <- [1..], a < b, c <- [1..], b < c, c^2 == (a^2 + b^2)]
-}

-- Versie 2
pythagorees = [(a,b,c) | c <- [1..], b <- [1..c-1], a <- [1..b-1], c^2 == (a^2 + b^2)]
