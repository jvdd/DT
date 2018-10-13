{-
foo :: Int -> IO String
foo n = do a <- getnchars n []
           return a

getnchars :: Int -> String -> IO String
getnchars 0     l = return l
getnchars n     l = do a <- getChar
                       getnchars (n-1) (a:l)
                    --return s
-}

foo :: Int -> IO String
foo n = do a <- getnchars n
           return (reverse a)

getnchars :: Int -> IO String
getnchars 0     =  return []
getnchars n     =
                    do a <- getChar
                       s <- getnchars (n-1)
                       return (a:s)


forever :: IO () -> IO ()
forever a = do { a; forever a }

repeatN :: Int -> IO () -> IO ()
repeatN 0 a = return ()
repeatN n a = do { a; repeatN (n-1) a }

-- N-queens interactief
{-
qs :: IO ()
qs = do i <- readi
		  schrijf (queens i)

schrijf :: Show a => [a] -> IO ()
schrijf []       = return ()
schrijf (x : xs) = do putStr “\n”
                      c <- putStr (show x)
		                schrijf xs

readi :: IO Int
readi = riacc 0

riacc :: Int -> IO Int
riacc acc =
     do
        x <- getChar
        if ( (tr x) < 0)
          then return acc
          else do z <- (riacc ((10* acc) + (tr x)))
                  return z

tr '0' = 0
..
tr '9' = 0
tr _ = -1

-}
