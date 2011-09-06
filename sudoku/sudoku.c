

int sudoku[9][9][10];


BOOL solve(int i, int j)
{
	if ( (i %= 9) == 0)		//if i mod 9 is 0, increment j.
		if (++j == 9)		//if after j is incremented, j is 9, return true.
			return true;	//the puzzle is solved.
	
	if (sudoku[i][j]) 		//if cell filled
		return solve(i+1, j);	//solve next position (and exit this function immediately with result)

	int value;
	for(value = 1; value <= 9; value++)
		if (valid(i, j, value))
		{
			sudoku[i][j] = value;		//we're going to try this value out
			update_possibilities(i, j);	//update all it is affecting
			if (solve(i+1, j))	//if solving the puzzle with this value works
			   return true;		//return true (puzzle is completely solved)
			/*else continue;*/	//fun optional line. (if solving worked, return true. else, continue solving)
		}

	//you're still here? nothing we tried worked....
	sudoku[i][j] = 0;	//reset the value
	return false;		//return false (puzzle not solved)
}

void reset_sudoku()
{
	int x, y, z;
	for(x = 0; x < 9; x++)
	for(y = 0; y < 9; y++)
	{
	    sudoku[x][y][0] = 0;
	    for(z = 1; z < 10; z++)
		sudoku[x][y][z] = 1;
	}
}

void initial_update()
{
	int i, j;
	for(i = 0; i < 9; i++)
	for(j = 0; j < 9; j++)
	    if (sudoku[i][j]) 
		update_others(i, j);
}

/* This clever method is to update the other cells' possibilities lists.
 * First assignment is for the row
 * Second assignement is for the column
 * Then this third assignment is a little trick I thought of for the box.
 * It essentially walks through the box in a neat fashion like so:
 * 1 2 3
 * 4 5 6
 * 7 8 9
 * ^where each number indicates the step (x value)
 * and its position indicates the position in the box
**/
void update_others(i, j)
{
	int m, n, x;
	for(m=i%3, n=j%3, x = 0; x < 9; x++)
	{
		sudoku[i][x][sudoku[i][j]] = 0;
		sudoku[x][j][sudoku[i][j]] = 0;
		sudoku[m+x/3][n+x%3][sudoku[i][j]] = 0;
	}

}



BOOL valid(int i, int j, value)
{
	return sudoku[i][j][value];
}
