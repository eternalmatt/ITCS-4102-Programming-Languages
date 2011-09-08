

type Grid = [[Int]]
type Cell = Int
type Row = [Int]
type Col = [Int]
type Box = [[Int]]

getRow :: Grid -> Int -> Row
getRow grid n = grid !! n

getCol :: Grid -> Int -> Col
getCol grid n = [ row !! n | row <- grid]

getBox :: Grid -> Int -> Int -> Box
getBox grid i j = let threeRows = take 3 $ map (getRow grid) [3*(i`div`3)..]
                  in  take 3 $ map (getCol grid) [3*(j`div`3)..]
--getBox grid (x,y) = [ take 3 (drop (3*(x-1)) row) | row <- take 3 (drop (3*(y-1)) grid)]

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


solve :: Grid -> Int -> Int -> Maybe Grid
solve grid 8 8 = Just grid
solve grid i 9 = solve grid (i+1) 0
solve grid i j
   | position grid i j /= 0 = solve i (j+1)
   | case fancy of []      -> Nothing
                   solution -> Just solution
     where fancy = head [ solved | value <- [1..9], valid value && solved /= Nothing
                          let newGrid = replaceIndex grid i j value
                              valid   = all $ map (notElem value) [getRow i, getCol j, getBox (i`div` 3) (j `div `3)]
                              solved  = solve newGrid i (j+1)
                        ]




