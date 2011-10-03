import java.io.*;
import java.util.*;

public class HigherOrder
{
	static double a[][], b[];

	public static void main(String[] args) throws IOException
	{
		//BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
	   //input = keyboard.readLine();
		
		readFromFile("constants.txt");
		
		FixedPoint lolPoint = new FixedPoint(a,b,0,1,2);
		lolPoint.go();
	}
	
	static void readFromFile(String name) throws FileNotFoundException
	{
		Scanner sc = new Scanner(new File(name));
				
		a = new double[3][3];
		for(int x=0; x<3; x++)
		for(int y=0; y<3; y++)
		{
			a[x][y] = sc.nextFloat();
			System.out.println("A["+x+"]["+y+"] = "+a[x][y]);
		}
			
		b = new double[3];
		for(int x=0; x<3; x++)
		{
			b[x] = sc.nextFloat();
			System.out.println("B["+x+"] = "+b[x]);
		}

		sc.close();
	}
}