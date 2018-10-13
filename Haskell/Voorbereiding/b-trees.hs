data BTREE a = BTREE {
                      lijst :: (Node a, Node a),
                      children :: (BTREE, BTREE, BTREE) | Leeg
                      parent :: Root | BTREE
                     }
-- data Btree = Leaf' a | Leaf a a | Node' Btree a Btree | Node Btree a Btree a Btree

data Node a = N a | Leeg

insert :: (Ord a) => a -> BTREE a -> BTREE a
insert a boom
        | fst $ lijst boom == Leeg  = Btree (N a, Leeg) Leeg Root
        | children boom == Leeg     = Btree ((fst $ lijst boom), N a) Leeg Root
        | otherwise insertInTree a boom

insertInTree :: (Ord a) => a -> BTREE a -> BTREE a
insertInTree a Leeg = BTREE a
