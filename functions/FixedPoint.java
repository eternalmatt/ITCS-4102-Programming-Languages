

public class FixedPoint
{
	double[][] a;
	double[]   b;
	Vector start;
	
	public class Vector
	{
		private final double x,y,z;
		public Vector(double x, double y, double z)
		{
			this.x=x;this.y=y;this.z=z;
		}
		
		public boolean equals(Vector v)
		{
			return this.x==v.x
			     &&this.y==v.y
			     &&this.z==v.z;
		}
		
		public String toString()
		{
			return "\tx:" + x + "\ty:" + y + "\tz:" + z;
		}
	}
	
	public FixedPoint(double[][] a, double[] b, double x, double y, double z)
	{
		this.a = a; 
		this.b = b;
		start = new Vector(x,y,z);
	}
	
	public void go()
	{
	 	F f = new F();
		G g = new G();
		H h = new H();
		
		Vector vec = start;
		double x,y,z;
	
		for(int n=1; n<=100; n++)
		{
			x = calculate(f, vec);
			y = calculate(g, vec);
			z = calculate(h, vec);
			
			vec = new Vector(x,y,z);
			
			System.out.print("n:" + n);
			System.out.println(vec);
		}
		
	}
	
	public double calculate(AbstractFunction function, Vector xyz)
	{
		return function.fixer(xyz);
	}
	
	
	public abstract class AbstractFunction{
		public abstract double fixer(Vector v);
	}
	
	public class F extends AbstractFunction{
		public double fixer(Vector xyz){
			return (b[1] - a[1][2]*xyz.y - a[1][3]*xyz.z) / a[1][1];
	}}
	
	public class G extends AbstractFunction{
		public double fixer(Vector xyz){
			return (b[2] - a[2][1]*xyz.x - a[2][3]*xyz.z) / a[2][2];
	}}
	
	public class H extends AbstractFunction{
		public double fixer(Vector xyz){
			return (b[3] - a[3][1]*xyz.x - a[3][2]*xyz.y) / a[3][3];
	}}
	
}
