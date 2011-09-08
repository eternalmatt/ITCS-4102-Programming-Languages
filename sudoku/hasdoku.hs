



getRow :: [[Int]] -> Int -> [Int]
getRow grid n = grid !! n

getCol :: [[Int]] -> Int -> [Int]
getCol grid n = [ row !! n | row <- grid]

getBox :: [[Int]] -> Int -> Int -> [Int]
getBox grid i j = let threeRows = take 3 $ map (getRow grid) [3*(i`div`3)..]
                  in  concat $ take 3 $ drop (3*(j`div`3)) threeRows
--getBox grid (x,y) = [ take 3 (drop (3*(x-1)) row) | row <- take 3 (drop (3*(y-1)) grid)]
{-
type Grid = [[Int]]
type Cell = Int
type Row = [Int]
type Col = [Int]
type Box = [Int]
allRows :: Grid -> [Row]
allRows = id

allCols :: Grid -> [Col]
allCols grid = map (getCol grid) [0..8]

allBoxes :: Grid -> [Box]
allBoxes grid = map (getBox grid) [ (x,y) | x<-[1..3], y<-[1..3]]

partSolved :: [Int] -> Bool
partSolved part = sort part == [1..9]


allSolved :: Grid -> Bool
allSolved grid = all (map (all . partSolved) [allRows, allCols, concat allBoxes])
-}


solve :: [[Int]] -> Int -> Int -> Maybe [[Int]]
solve grid 8 8 = Just grid
solve grid i 9 = solve grid (i+1) 0
solve grid i j
   | position grid i j /= 0 = solve grid i (j+1)
   | otherwise = head [ solved | value <- [1..9], let solved  = solve (replaceIndex grid i j value) i (j+1), (and ( map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing]
                      
position i j k = 0
replaceIndex i j k l = [[0]]
                      
