

int[9][9][10] sudoku;


BOOL solve(int i, int j)
{
	if (i %= 9 == 0)
		if (j=(j+1) % 9 == 0) 
			return true;
	
	if (sudoku[i][j]) 	//if cell filled
		return solve(i+1, j); //solve next position (and exit this function immediately with result)

	int value;
	for(value = 1; value <= 9; value++)
		if (valid(i, j, value))
		{
			sudoku[i][j] = value;
			update_possibilities(i, j);
			if (solve(i+1, j)) return true;
		}

	sudoku[i][j] = 0;
	return false;	
}

void initial_update()
{
	int i, j;
	for(i = 0; i < 9; i++)
	for(j = 0; j < 9; j++)
	    if (sudoku[i][j]) 
		update_others(i, j);
}

void update_others(i, j)
{
	int m, n, x, y;
	for(x = 0; x < 9; x++)
	{
		sudoku[i][x][sudoku[i][j]] = 0;
		sudoku[x][j][sudoku[i][j]] = 0;
	}

	for(m=3*(i%3), n=3*(j%3), x=0; x < 3; x++)
	    for(y=0; y < 3; y++)
		sudoku[m+x][n+y][sudoku[i][j]] = 0;
}


BOOL valid(int i, int j, value)
{
	return sudoku[i][j][value];
}
