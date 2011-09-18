import java.math.BigInteger;

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

}
