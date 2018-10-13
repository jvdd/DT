
returnDelers :: IO [Int]
returnDelers = do
    getal <- readLn :: IO Int
    return (delers getal)
    where delers x = [y | y <- [1..(div x 2)], mod x y == 0]

printDelers :: IO ()
printDelers = do
    getal <- readLn :: IO Int
    print (delers getal)
    where delers x = [y | y <- [1..(div x 2)], mod x y == 0]
