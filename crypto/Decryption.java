import java.math.BigInteger;
import java.lang.NumberFormatException;

public class Decryption
{
	public static final BigInteger ONE_TWENTY_EIGHT = new BigInteger("128");
	private       final BigInteger key;
	
	public Decryption(String key)
	{
		this.key = new BigInteger(key);
	}
	
	public String decrypt(String message)
	{
		try
		{
			return algorithm(new BigInteger(message).divide(key));
		}
		catch(NumberFormatException e) 
		{
			return new String();
		}
	}
	
	//if m <= 0 then return "";
	//else return decrypt((m-c)/128)+c where c=m%128
	private String algorithm(BigInteger message)
	{
		if (message.compareTo(BigInteger.ZERO) <= 0)		//if message <= 0
			return "";								            //then return the empty string
	   else
		{ 
			BigInteger letter = message.remainder(ONE_TWENTY_EIGHT);					//(m % 128
			BigInteger newMessage = message.subtract(letter).divide(ONE_TWENTY_EIGHT);	//(m - (m%128)) / 128
			
			int intValue = letter.intValue();
			char character = (char)intValue;
			return algorithm(newMessage) + (intValue == 0 ? "" : character);
		}
	}
}