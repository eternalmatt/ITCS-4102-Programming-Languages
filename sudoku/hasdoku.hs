import Data.List (sort)
import Data.Maybe (fromMaybe)

main = print $ fromMaybe [] (solve hard 0 0)

--and $ map (\x -> sort x == [1..9]) $ fromJust solved
empty, hard, puzzle :: [[Int]]
empty  = replicate 9 $ replicate 9 0
hard   = [[0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,3,0,8,5],
          [0,0,1,0,2,0,0,0,0],
          [0,0,0,5,0,7,0,0,0],
          [0,0,4,0,0,0,1,0,0],
          [0,9,0,0,0,0,0,0,0],
          [5,0,0,0,0,0,0,7,3],
          [0,0,2,0,1,0,0,0,0],
          [0,0,0,0,4,0,0,0,9]]
puzzle = [[0,5,0,0,6,0,0,0,1],
	  [0,0,4,8,0,0,0,7,0],
	  [8,0,0,0,0,0,0,5,2],
	  [2,0,0,0,5,7,0,3,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,3,0,6,9,0,0,0,5],
	  [7,9,0,0,0,0,0,0,8],
	  [0,1,0,0,0,6,5,0,0],
	  [5,0,0,0,3,0,0,6,0]]
	  
solved :: [[Int]] -> Maybe [[Int]]
solved grid = solve puzzle 0 0

checkit :: [[Int]] -> Bool
checkit grid = and $ map (\x -> sort x == [1..9]) $ fromMaybe [] $ solved grid


	  
             

solve :: [[Int]] -> Int -> Int -> Maybe [[Int]]
solve grid 8 9 = Just grid
solve grid i 9 = solve grid (i+1) 0
solve grid i j | valueAt grid i j /= 0 = solve grid i (j+1) 
               | otherwise = 
 case  possibilities of {[] -> Nothing; solutions -> head solutions}
 where possibilities   = concatMap guess [1..9]
       guess value     = if unique && solution /= Nothing then [solution] else []
        where solution = solve nextGrid i (j+1)
              nextGrid = replaceIndex grid i j value
              unique   = and uniques
              uniques  = map (notElem value) [row,col,box]
              row = getRow grid i
              col = getCol grid j
              box = getBox grid i j
                  
                                   
getRow :: [[a]] -> Int -> [a]
getRow grid n = grid !! n

getCol :: [[a]] -> Int -> [a]
getCol grid n = [ row !! n | row <- grid]

getBox :: [[a]] -> Int -> Int -> [a]
getBox grid i j = let rowStart  = 3 * (i `div` 3)
                      colStart  = 3 * (j `div` 3)
                      threeRows = take 3 $ map (getRow grid) [rowStart..]
                  in  concat $ map (take 3 . drop colStart) threeRows
                               
valueAt :: [[a]] -> Int -> Int -> a
valueAt grid i j = (grid !! i) !! j

replaceIndex :: [[a]] -> Int -> Int -> a -> [[a]]
replaceIndex grid i j value = replace grid i $ replace (getRow grid i) j value

replace :: [a] -> Int -> a -> [a]
replace (_:xs) 0 n = n : xs
replace (x:xs) i n = x : replace xs (i-1) n

{-

| otherwise = let fancy = [ solved | value <- [1..9], let solved  = solve (replaceIndex grid i j value) i (j+1), (and ( map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing]
              in case fancy of []        -> Nothing
                               solutions -> head solutions
                                              
[21:44] <Jafet> @undo [ solved | value <- [1..9], let solved  = solve (replaceIndex grid i j value) i (j+1), (and ( map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing]
[21:44] <lambdabot> concatMap (\ value -> let { solved = solve (replaceIndex grid i j value) i (j + 1)} in if (and (map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing then [
[21:44] <lambdabot> solved] else []) [1 .. 9]
[21:45] <Jafet> wtf, undo is scary
[21:45] <rwbarton> I didn't know @undo could do that
                                              


--this is essentially what lambdabot said
concatMap (\ value -> let solvedgrid  = solve newGrid i (j+1)
                          newgrid     = replaceIndex grid i j value
                          uniquevalue = and $ map (notElem value) [getRow grid i, getCol grid j, getBox grid i j]
                      in if uniquevalue && solved /= Nothing 
                         then [solved] 
                         else []
          ) [1 .. 9]
          
-}
                 
