import java.math.BigInteger;

public class Decryption
{
	public static final BigInteger ONE_TWENTY_EIGHT = new BigInteger("128");
	private       final BigInteger key;
	
	public Decryption(String strKey)
	{
		key = new BigInteger(strKey);
	}
	
	public String decrypt(String message)
	{
		return algorithm(new BigInteger(message));
	}
	
	
	private String algorithm(BigInteger message)
	{
		if (message.compareTo(key) <= 0)
			return "";
	   else
		{
			BigInteger bigChar = message.divide(key).mod(ONE_TWENTY_EIGHT);					//(m / k) % 128
			BigInteger newMessage = message.subtract(bigChar).divide(ONE_TWENTY_EIGHT);	//(m - c) / 128
				
			char character = (char)bigChar.intValue(); 	//typecast down to char
			return algorithm(newMessage) + character;		//build rest of output string
		}
	}
}