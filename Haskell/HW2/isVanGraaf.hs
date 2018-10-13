isVanGraaf :: [Int] -> Bool
isVanGraaf [] = True
isVanGraaf (x : rest) = if x == 0  -- Omdat de lijst steeds gesorteerd is staat hoeven we enkel het eerste el. op == 0 te checken
                            then (
                                    if bevatNeg rest then False
                                    else True -- Al de waarden in rest zijn dan ook 0
                                 )
                        else if x < 0 then False -- Bij negatieve waarden is het geen graaf
                        else isVanGraaf (qs (sAccent x rest [])) -- Moet gesorteerd zijn voor de volgende stap
                            where sAccent 0 rest acc = acc ++ rest -- Met accumulator dus lijst is omgekeerd, maar maakt niet uit want wordt toch gesorteerd
                                  sAccent x [] acc = if x > 0 then [-1] -- Zodat het dan false zal teruggeven
                                                     else acc
                                  sAccent n (x : xs) acc = sAccent (n - 1) xs ((x - 1) : acc)

bevatNeg :: [Int] -> Bool
bevatNeg [] = False
bevatNeg (x : rest) = if x < 0 then True
                      else bevatNeg rest

qs [] = []
qs (pivot:xs) = (qs [x | x <- xs, x > pivot]) ++ (pivot : qs [y | y <-xs, y <= pivot])
