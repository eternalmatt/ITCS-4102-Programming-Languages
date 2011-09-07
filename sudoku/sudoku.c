#include <stdio.h>

int sudoku[9][9][10], solve();
void output(), update_others(), reset_sudoku(), initial_update(), reset_all_dependancies();

int main()
{
	FILE* file = fopen("sudoku.txt", "r");
	if (file == NULL) return;
	
	puts("getting input");

	reset_sudoku();	

	int i, j;
	for(i = 0; i < 9; i++)
	    for(j = 0; j < 9; j++)
		fscanf(file, "%d", sudoku[i][j]);
	fclose(file);

	output();
	
	initial_update();
        
	if (solve(0, 0) == 1)
		puts("we somehow solved it!");
	else
		puts("shit, its not solved");
	
	output();
}




int solve(int i, int j)
{
	printf("%d,%d -> %d\n", i, j, sudoku[i][j][0]);
	if (i == 9)		//if i mod 9 is 0, increment j.
	{	i = 0;	
		if (++j == 9)		//if after j is incremented, j is 9, return true.
			return 1;	//the puzzle is solved.
	}
	if (sudoku[i][j][0] != 0) 		//if cell filled
		return solve(i+1, j);	//solve next position (and exit this function immediately with result)

	puts("Cell was not filled");
	
	int value;
	for(value = 1; value <= 9; value++)
		if (valid(i, j, value) == 1)
		{
			printf("Trying %d\n", value);
			sudoku[i][j][0] = value;		//we're going to try this value out
			update_others(i, j);	//update all it is affecting
			if (solve(i+1, j) == 1)	//if solving the puzzle with this value works
			   return 1;		//return true (puzzle is completely solved)
			/*else continue;*/	//fun optional line. (if solving worked, return true. else, continue solving)
		}
		else
		{
			printf("%d tested invalid.\n",value); 
		}

	puts("A value didn't work.");
	//you're still here? nothing we tried worked....
	sudoku[i][j][0] = 0;	//reset the value
	reset_all_dependancies();
	return 0;		//return false (puzzle not solved)
}

void reset_all_dependancies()
{
	puts("About to reset all");
	int x, y, z;
	for(x = 0; x < 9; x++)
	for(y = 0; y < 9; y++)
	for(z = 1; z < 10; z++)
		sudoku[x][y][z] = 1;

	initial_update();
}

void output()
{
	int i, j;
	for(i = 0; i < 9; i++){
	for(j = 0; j < 9; j++)
		printf("%d", sudoku[i][j][0]);
	putchar('\n');}
}

/* simple method to reset sudoku array
 *
 * basically follows like so: 
 * forall x,y in sudoku[i][j][0] = 0
 * forall x,y and z from (1-9) in sudoku[x][y][z] = 1
 */
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

/*quickly loop through sudoku array and update all possibilities
*/
void initial_update()
{
	int i, j;
	for(i = 0; i < 9; i++)
	for(j = 0; j < 9; j++)
	    if (sudoku[i][j][0]) 
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
	if (i < 3) m = 0;
	if (i > 2 && i < 5) m = 3;
	if (i > 5) m = 6;
	if (j < 3) n = 0;
	if (j > 2 && j < 8) n = 3;
	if (j > 5) n = 6;
	
	if (sudoku[i][j][0] == 0) { printf("In update_others with %d,%d and shouldn't be", i, j); return;}
	printf("Updating others. sudoku[%d][%d][0]=%d\n ", i, j, sudoku[i][j][0]);
	for(x = 0; x < 9; x++)
	{
		sudoku[i][x][ sudoku[i][j][0] ] = 0;
		sudoku[x][j][ sudoku[i][j][0] ] = 0;
		sudoku[m+x/3][n+x%3][ sudoku[i][j][0] ] = 0;
		//printf("(%d,%d)",m+x/3,n+x%3);
		
		printf("sudoku[%d][%d][0]=%d --> sudoku[%d][%d][%d]=0\n",i,j,sudoku[i][j][0],i,x,sudoku[i][j][0]);
		printf("sudoku[%d][%d][0]=%d --> sudoku[%d][%d][%d]=0\n",i,j,sudoku[i][j][0],x,j,sudoku[i][j][0]);
		printf("sudoku[%d][%d][0]=%d --> sudoku[%d][%d][%d]=0\n",i,j,sudoku[i][j][0],m+x/3,n+x%3,sudoku[i][j][0]);
	}
	puts("");

}



int valid(int i, int j, int value)
{
	printf("sudoku[%d][%d][%d]=%d\n",i,j,value,sudoku[i][j][value]);
	return sudoku[i][j][value];
}
