
max_overeenkomst :: String -> String -> (String, Int)
max_overeenkomst str1 str2 = (res, length res)
   where res = maximumlen [dropStaart s1 s2 | s1 <- substrs str1, s2 <- substrs str2]

maximumlen :: [String] -> String
maximumlen = foldr maxlen ""

maxlen ::  String -> String -> String
maxlen x y = if length x > length y then x else y

dropStaart :: String -> String -> String
dropStaart "" _ = ""
dropStaart _ "" = ""
dropStaart (x:xs) (y:ys) = if x == y then x : dropStaart xs ys else ""

substrs :: String -> [String]
substrs "" = [""]
substrs str@(_:s) = str : substrs s
{-
Het volledige argument is 'str' en da matcht met '(_:s)'
Dus 's' is de staart van 'str'
Dus maakt hij eigenlijk een lijst van alle substrings die ergens beginnen en doorgaan tot het einde van de string
-}

tests =
   max_overeenkomst "abcdefgh" "xcdeyz" == ("cde", 3) &&
   max_overeenkomst "abcdefghi" "xabydefzefght" == ("efgh", 4)

-- Meer uitleg over at
{-
Yes, it's just syntactic sugar, with @ read aloud as "as". ps@(p:pt) gives you names for

the list: ps
the list's head : p
the list's tail: pt
Without the @, you'd have to choose between (1) or (2):(3).

This syntax actually works for any constructor; if you have data Tree a = Tree a [Tree a],
then t@(Tree _ kids) gives you access to both the tree and its children.
-}
