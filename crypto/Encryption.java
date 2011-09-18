import java.math.BigInteger;
<<<<<<< HEAD
import java.lang.StringBuilder;
=======
>>>>>>> master

public class Encryption
{
   public static final BigInteger ONE_TWENTY_EIGHT = new BigInteger("128");
   private       final BigInteger key;

   public Encryption(String key)
   {
      this.key = new BigInteger(key);
   }

   //returns a string representation of a number which is the encrypted message
   public String encrypt(String message)
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
	
	public String newEncrypt(String message)
	{
<<<<<<< HEAD
		return recursive(reverse(message)).toString();
	}
	
	public BigInteger recursive(String reversed)
	{
		if (reversed.equals(""))
			return BigInteger.ZERO;
		else
		{
			BigInteger letter = BigInteger.valueOf(reversed.charAt(0));
			return ONE_TWENTY_EIGHT.multiply(key.multiply(letter).add(recursive(reversed.substring(1,reversed.length()))));
		}
=======
		String reversed = reverse(message);
		return keyTimesLetterPlusEncryption(reversed).toString();
	}
	
	private BigInteger recursively(String reversed)
	{
		if (reversed.length() == 0)
			return BigInteger.ZERO;
		else
			return ONE_TWENTY_EIGHT.multiply(keyTimesLetterPlusEncryption(reversed));
	}
	
	private BigInteger keyTimesLetterPlusEncryption(String reversed)
	{
		BigInteger letter = BigInteger.valueOf(reversed.charAt(0));					//letter = (BigInt)letter
		BigInteger keyTimesLetter = key.multiply(letter);								//key * letter
		
		String minusFirstCharacter = reversed.substring(1,reversed.length());	//m.sub(1,len)
		BigInteger restOfEncryption = recursively(minusFirstCharacter);			//encrypt(m.sub(1,len))
		
		return keyTimesLetter.add(restOfEncryption);			//key * letter + encrypt(message.sub(1,len))
>>>>>>> master
	}
	
	private String reverse(String str)
	{
		return new StringBuilder(str).reverse().toString();
	}

}
