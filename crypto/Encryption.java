import java.math.BigInteger;


public class Encryption
{
   public static final BigInteger ONE_TWENTY_EIGHT = new BigInteger("128");
   private       final BigInteger key;

   public Encryption(String key)
   {
      this.key = new BigInteger(key);
   }
	
	//return key*(encrypt(m)+c)
	public String encrypt(String message)
	{
		//this is the same thing that happens in recursively (except for *128)
		BigInteger letter = BigInteger.valueOf(message.charAt(message.length()-1));	
		message = message.substring(0,message.length()-1);
		
		//return key * (encrypt(message) + letter)
		return recursively(message).add(letter).multiply(key).toString();
	}
	
	//if length == 0, return 0;
	//else return 128*(encrypt(m)+c);
	private BigInteger recursively(String message)
	{
		if (message.length() == 0)			//if length is zero
			return BigInteger.ZERO;			//we are done. return 0.
		else
		{
			//grab the last letter from the message and convert to BigInteger
			BigInteger letter = BigInteger.valueOf(message.charAt(message.length()-1));	
		
		
			//get substring minus that letter (basically decrement the length)
			message = message.substring(0,message.length()-1);
		
		
			//return 128 * (letter + encrypt(message))
			return recursively(message).add(letter).multiply(ONE_TWENTY_EIGHT);		//possibly more efficient on the stack
			//return ONE_TWENTY_EIGHT.multiply(letter.add(recursively(message)));	//possibly more readable  on the eyes
		}
	}
	//interesting to note, the above function could be made into a single line
	//using ternary [?:] and just putting the "letter" and "message" exactly in place
	
	
	
	

   //returns a string representation of a number which is the encrypted message
   public String not_recursive_encryption_that_i_dont_like_anymore(String message)
   {
      BigInteger accumulator, coefficient, letterToAdd;							//declare BigIntegers we'll use
      accumulator = coefficient = letterToAdd = BigInteger.ZERO;				//initialize all to zero

      for(int e=0,i=message.length()-1; i>=0; i--)
		{
			coefficient = ONE_TWENTY_EIGHT.pow(e++);									//coeff ^= 128
			
			char letter = message.charAt(i);												//letter = message[i]
			letterToAdd = BigInteger.valueOf(letter);			  						//toAdd  = (BigInt)letter
			letterToAdd = letterToAdd.multiply(coefficient).multiply(key);		//toAdd *= coefficient * key
			
			accumulator = accumulator.add(letterToAdd);								//acc   += toAdd
		}

      return accumulator.toString();
   }
}
