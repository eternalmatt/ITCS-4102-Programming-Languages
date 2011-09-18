#include <stdio.h>
#include <stdbool.h>

int sudoku[9][9], max_recurs = 0;
bool solve(int,int),valid(int,int,int);
void output(int[9][9]);

int main()
{
   char fileName[20];
   printf("%s","Please input a file name: \t");
   scanf("%s", fileName);
   printf("%s","Thank you. Parsing and solving now.\n");

   FILE *file = fopen(fileName, "r");
   if (file == NULL) return 0;/*nothing fancy*/

   int i, j; /*getting input*/
   for(i = 0; i < 9; i++)
      for(j = 0; j < 9; j++)
         fscanf(file, "%d", &sudoku[i][j]);
   fclose(file);
   
   //Show we have input correctly
   output(sudoku);

   if (solve(0,0)) /*fingers crossed!*/
      puts("We solved it!");
   else 
      puts("We didn't solve it...");  

   //Show how grid looks after solving
   output(sudoku);
}

/* this method for solving the puzzle is heavily recursive
 * and its allll good.
 *
 * Structure goes like this:
 * 1) check for base case
 * 2) check if index off grid
 * 3) check if cell filled
 * 4) see if any [1..9] values are valid
 * 5) if one is, try it out, keep solving
 * 6) if nothing was valid, return false */
bool solve(int i, int j)
{
   if      (i==9 && j==8) return true;          //the recursive base case
   else if (   i == 9   ) return solve(0,j+1);  //if i off grid,  move to next row
   else if (sudoku[i][j]) return solve(i+1,j);  //if cell filled, move to next cell
   else
   {
      int n;
      for(n = 1; n <= 9; n++)
         if (valid(i, j, n))
         {
            sudoku[i][j] = n;                   //try this value out
            if (solve(i+1,j)) return true;      //if solving next works, return true (puzzle solved!)
            else continue;                      //else continue and keep solving! (not necessary)
         }
   
      //still here? something we tried didn't work
      //don't worry, its normal in backtracking
      sudoku[i][j] = 0; //reset cell
      return false;
   }
}

/* returns true if this (i,j) location is valid for "value"
 *
 * I did some pretty neat integer logic so that I would
 * only have to loop once (and not have 2 for() for the box.
 * Note i/3 will chop off remainder, then 3* will push the 
 * number up to proper place for box to start.
 * THEN, x/3 walks "slowly" left to right
 * while x%3 walks "thrice" left to right */
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
      printf("%s","\n");
   }
}

