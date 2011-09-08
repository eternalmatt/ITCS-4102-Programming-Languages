#include <stdio.h>
#include <stdbool.h>

int sudoku[9][9], max_recurs = 0;
bool solve(int,int),valid(int,int,int);
void output(int[9][9]);

int main()
{
   FILE *file = fopen("sudoku.txt", "r");
   if (file == NULL) return 0;/*nothing fancy*/

   int i, j; /*getting input*/
   for(i = 0; i < 9; i++)
      for(j = 0; j < 9; j++)
      fscanf(file, "%d", &sudoku[i][j]);
   
   //Show we have input correctly
   output(sudoku);

   if (solve(0,0)) /*fingers crossed!*/
      puts("We solved it!");
   else puts("We didn't solve it...");
   
   //Show how grid looks after solving
   output(sudoku);
}


bool solve(int i, int j)
{
   if (i == 9)
   {
      i = 0;
      if (++j == 9)  //end of grid 
         return true;//puzzle is solved
   }
   if (sudoku[i][j] != 0)  //cell is already filled
      return solve(i+1,j); //return result of solving next

   int n;
   for(n = 1; n <= 9; n++)
      if (valid(i, j, n))
      {
         sudoku[i][j] = n;    //try this value out
         if (solve(i+1, j))   //if solving next cell works
            return true;      //return true (puzzle solved!)
         else continue;       //else continue! (not necessary)
      }
   
   //still here? something we tried didn't work
   //don't worry, its normal in backtracking
   sudoku[i][j] = 0; //reset cell
   return false;
}

/* returns true if this (i,j) location is valid for "value"
 *
 * I did some pretty neat integer logic so that I would
 * only have to loop once (and not have 2 for() for the box.
 * Note i/3 will chop off remainder, then 3* will push the 
 * number up to proper place for box to start.
 * THEN, x/3 walks "slowly" left to right
 * while x%3 walks "thrice" left to right
 */
bool valid(int i, int j, int value)
{
   int x, m, n;
   for(x = 0, m=3*(i/3), n=3*(j/3); x < 9; x++)
   {
      if (sudoku[i][x] == value           //all cells in col
       || sudoku[x][j] == value           //all cells in row
       || sudoku[m+x/3][n+x%3] == value)  //all cells in box
         return false;
   }
   return true;
}

/* simple output method for debugging and display purposes */
void output(int grid[9][9])
{
   int i, j;
   for(i = 0; i < 9; i++)
   {
      for(j = 0; j < 9; j++)
         printf("%d ", grid[i][j]);
      printf("\n");
   }
}

