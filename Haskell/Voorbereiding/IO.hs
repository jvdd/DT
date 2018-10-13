
bepaalDelers :: IO [Int]
bepaalDelers = do
    getal <- readLn :: IO Int
    return $ delers getal :: IO [Int]
    where delers x = [a | a <- [1..(div x 2)], mod x a == 0]


bepaalDelers' :: IO [Int]
bepaalDelers' = do
    getal <- readLn :: IO Int
    return (delers getal)
    where delers x = [a | a <- [1..(div x 2)], mod x a == 0]


bepaalDelersOutput :: IO ()
bepaalDelersOutput = do
    getal <- readLn :: IO Int
    print (delers getal)
    where delers x = [a | a <- [1..(div x 2)], mod x a == 0]
