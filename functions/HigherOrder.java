import java.io.*;
import java.util.*;

public class HigherOrder
{
	public static void main(String[] args) throws IOException
	{
		//BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
	   //input = keyboard.readLine();
		
//		double[][] a = new double[][]{{0,0,0,0},{0,5,2,9},{0,3,-7,8},{0,-2,4,-10}};
		double[][] a = new double[][]{{0,0,0,0},{0,5,3,-2},{0,2,-7,4},{0,9,8,-10}};
		
		double[] b = new double[]{0,13,21,-6};
		
		FixedPoint lolPoint = new FixedPoint(a,b,0,1,2);
		lolPoint.go();
	}
}