import System.Environment (getArgs)


main = do
    [fileStr] <- getArgs
    contents  <- readFile fileStr
    let input    = take 9 (readPuzzle contents)
        solution = solved input
        output   = showPuzzle solution
    putStrLn output

--separates string by lines, tokenizes by spaces, and converts to integers
readPuzzle :: String -> [[Int]]
readPuzzle = map (map read) . map words . lines

--converts to [[String]], concats with spaces, and separates by newlines
showPuzzle :: Maybe [[Int]] -> String
showPuzzle (Nothing) = "A solution was not found!"
showPuzzle (Just pz) = unlines $ map unwords $ map (map show) pz

--solves a puzzle. do note Haskell lists are zero-based
solved :: [[Int]] -> Maybe [[Int]]
solved grid = solve grid 0 0


solve :: [[Int]] -> Int -> Int -> Maybe [[Int]]
solve grid 8 9 = Just grid
solve grid i 9 = solve grid (i+1) 0
solve grid i j =
 if grid !! i !! j /= 0
 then solve grid i (j+1)
 else first possibilities
  where possibilities   = map guessing [1..9]
        guessing value  = if unique then solution else Nothing
         where solution = solve nextGrid i (j+1)
               nextGrid = replace grid i (replace row j value)
               unique   = all (notElem value) [row,col,box]
               row = getRow grid i
               col = getCol grid j
               box = getBox grid i j


--returns first occurance of Just something
--if list turns out to be all Nothing, return Nothing
--first = fromMaybe Nothing . find (/= Nothing)
first :: [Maybe a] -> Maybe a
first []           = Nothing
first (Nothing:xs) = first xs
first (x:_)        = x

--returns the n-th row or column
getRow,getCol :: [[a]] -> Int -> [a]
getRow grid n = grid !! n
getCol grid n = [ row !! n | row <- grid]

--returns the box AROUND (i,j)
getBox :: [[a]] -> Int -> Int -> [a]
getBox grid i j = let row = 3 * (i `div` 3)
                      col = 3 * (j `div` 3)
                  in  concatMap (take 3 . drop col . getRow grid) [row,row+1,row+2]

--replaces the i-th element with n.
replace :: [a] -> Int -> a -> [a]
replace (_:xs) 0 n = n : xs
replace (x:xs) i n = x : replace xs (i-1) n

--a few test cases
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
	  
{-
Allow me to explain the logic in the solve method, or at least the very last part.
When we are solving a grid we need to do a couple things.
The first thing is to map some values across new grids and see how they try out.
When we map them, we'll have to replace what's currently there (its always a zero).
Now, if this mapping was unique (say, its the only x-value in its row/col/box)
then lets just keep on solving and mapping new values.
If it isn't unique, then return Nothing, signaling nothing worked.
When that happens, it bubbles up to the last grid, where it tries a next value
and so on and so forth until we reach the last grid index and it works.

| otherwise = let fancy = [ solved | value <- [1..9], let solved  = solve (replaceIndex grid i j value) i (j+1), (and ( map (notElem value) [getRow grid i, getCol grid j, getBox grid i j])) && solved /= Nothing]
              in case fancy of []        -> Nothing
                               solutions -> head solutions

--that list comprehension essentially looks like this when undone
concatMap (\ value -> let solvedgrid  = solve newGrid i (j+1)
                          newgrid     = replaceIndex grid i j value
                          uniquevalue = and $ map (notElem value) [getRow grid i, getCol grid j, getBox grid i j]
                      in if uniquevalue && solved /= Nothing 
                         then [solved] 
                         else []
          ) [1 .. 9]
--and after a tremoundous effort, i was able to transform it into
--what is now everything after the "else" in the solve function
-}
                 
