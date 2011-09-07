

type Grid = [[Int]]
type Cell = Int
type Row = [Int]
type Col = [Int]
type Box = [[Int]]

getRow :: Grid -> Int -> Row
getRow grid n = grid !! n

getCol :: Grid -> Int -> Col
getCol grid n = [ row !! n | row <- grid]

getBox :: Grid -> (Int,Int) -> Box
getBox grid (x,y) = [ take 3 (drop (3*(x-1)) row) | row <- take 3 (drop (3*(y-1)) grid)]

allRows :: Grid -> [Row]
allRows = id

allCols :: Grid -> [Col]
allCols grid = map (getCol grid) [1..9]

allBoxes :: Grid -> [Box]
allBoxes grid = map (getBox grid) [ (x,y) | x<-[1..3], y<-[1..3]]

partSolved :: [Int] -> Bool
partSolved part = sort part == [1..9]


allSolved :: Grid -> Bool
allSolved grid = all (map (all . partSolved) [allRows, allCols, concat allBoxes])


solve :: Grid -> Grid
solve grid = case analyze grid of
                  Just new | allSolved new = new
                           | otherwise     = solve new
                  Nothing  = grid





