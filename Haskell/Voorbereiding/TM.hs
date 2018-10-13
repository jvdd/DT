
data TuringMachine a = TM {
            toestanden  :: [a],
            aanvToest   :: [a],
            begintoest  :: a ,
            programma   :: P a
}

data Programma a = P [(Toestand a, Char,Toestand a, Char, Beweging)]
                 -- HuidigeToest Lees volgendeToest Schrijf beweegKopNaar  

data Beweging = L | R | O
