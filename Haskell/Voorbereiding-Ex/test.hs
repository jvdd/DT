testFunc x ((x,y):_) = y
testFunc x (_:rest) = testFunc x y

test = testFunc 5 [(6,7),(5,4),(5,3),(2,9)]

-- CONFLICTING DEFINITIONS FOR X
