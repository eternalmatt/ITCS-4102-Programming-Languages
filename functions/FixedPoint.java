

public class FixedPoint
{
	double[][] a;
	double[]   b;
	F f = new F();
	G g = new G();
	H h = new H();
	Vector start;
	
	public class Vector
	{
		public double x,y,z;
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
			return "n:" + count + "\tx:" + x + "\ty:" + y + "\tz:" + z;
		}
	}
	
	public FixedPoint(double[][] a, double[] b, double x, double y, double z)
	{
		this.a = a; this.b = b;
		start = new Vector(x,y,z);
	}
	
	public String go()
	{
		return iterate(start).toString();
	}
	private int count = 0;
	public Vector iterate(Vector xyz)
	{
		System.out.println(xyz);
		if (++count == 100)
			return xyz;
		
		Vector next = new Vector(
			f.fixer(xyz),
		   g.fixer(xyz),
		   h.fixer(xyz)
		);
		
		if (xyz.equals(next))
			return next;
		else
			return iterate(next);
	}
	
	
	public abstract class AbstractFunction
	{
		public abstract double fixer(Vector lol);
	}
	
	public class F extends AbstractFunction
	{
		public double fixer(Vector xyz)
		{
			return (b[1] - a[1][2]*xyz.y - a[1][3]*xyz.z) / a[1][1];
		}
	}
	
	public class G extends AbstractFunction
	{
		public double fixer(Vector xyz)
		{
			return (b[2] - a[2][1]*xyz.x - a[2][3]*xyz.z) / a[2][2];
		}
	}
	
	public class H extends AbstractFunction
	{
		public double fixer(Vector xyz)
		{
			return (b[3] - a[3][1]*xyz.x - a[3][2]*xyz.y) / a[3][3];
		}
	}
	
	
}
