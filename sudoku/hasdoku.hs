

--and $ map (\x -> sort x == [1..]) $ fromJust solved
puzzle :: [[Int]]
puzzle = [[0,5,0,0,6,0,0,0,1],
	  [0,0,4,8,0,0,0,7,0],
	  [8,0,0,0,0,0,0,5,2],
	  [2,0,0,0,5,7,0,3,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,3,0,6,9,0,0,0,5],
	  [7,9,0,0,0,0,0,0,8],
	  [0,1,0,0,0,6,5,0,0],
	  [5,0,0,0,3,0,0,6,0]]
	  


getRow :: [[a]] -> Int -> [a]
getRow grid n = grid !! n

getCol :: [[a]] -> Int -> [a]
getCol grid n = [ row !! n | row <- grid]

getBox :: [[a]] -> Int -> Int -> [a]
getBox grid i j = let rowStart  = 3 * (i `div` 3)
                      colStart  = 3 * (j `div` 3)
                      threeRows = take 3 $ map (getRow grid) [rowStart..]
                  in  concat $ map (take 3 . drop colStart) threeRows
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
solve grid 8 9 = Just grid
solve grid i 9 = solve grid (i+1) 0
solve grid i j
   | valueAt grid i j /= 0 = solve grid i (j+1)
   | otherwise             = let fancy = [ solved | value <- [1..9], let solved  = solve (replaceIndex grid i j value) i (j+1), (and ( map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing]
                             in case fancy of []        -> Nothing
                                              solutions -> head solutions
   
{-
   | otherwise             = case filter valid $ map tryValues [1..9] of {[] -> Nothing; solutions -> head solutions}
     where tryValues v  = solvedgrid v
           solvedgrid v = solve (newgrid v) i (j+1)
           newgrid v    = replaceIndex grid i j v
           valid        = uniquevalue && solvedgrid /= Nothing
           uniquevalue  = and $ map (notElem value) [getRow grid i, getCol grid j, getBox i j]
-}
   
   
                      
valueAt :: [[a]] -> Int -> Int -> a
valueAt grid i j = (grid !! i) !! j

replaceIndex :: [[a]] -> Int -> Int -> a -> [[a]]
replaceIndex grid i j value = replace grid i $ replace (getRow grid i) j value

replace :: [a] -> Int -> a -> [a]
replace (_:xs) 0 n = n : xs
replace (x:xs) i n = x : replace xs (i-1) n

{-

| otherwise = head [ solved | value <- [1..9], let solved  = solve (replaceIndex grid i j value) i (j+1), (and ( map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing]

-}
   
                      
