import java.math.BigInteger;

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
		return algorithm(new BigInteger(message).divide(key));
	}
	
	//if m <= 1 then return "";
	//else return decrypt((m-c)/128)+c
	private String algorithm(BigInteger message)
	{
		if (message.compareTo(BigInteger.ZERO) <= 0)		//if message < 1
			return "";								            //then return the empty string
	   else
		{ 
			BigInteger letter = message.mod(ONE_TWENTY_EIGHT);					//(m % 128
			BigInteger newMessage = message.subtract(letter).divide(ONE_TWENTY_EIGHT);	//(m - (m%128)) / 128
				
			char character = (char)letter.intValue(); 	//typecast down to char
			return algorithm(newMessage) + character;		//build rest of output string
		}
	}
}