/*
Hello, thanks for taking the time to open up my code
and give it a glance. This is basically the driver class
file that contains main(), the file parser, user interaction,
and where it calls encryption / decryption.

If you would please, I'd like to guide you to 
Encryption.java and Decryption.java where I've written 
some beautifully simple recursive algorithms.
I originally wrote this code in Haskell, so a lot of the logic
is gleamed from that, and I think it likely performs well here.

Also, I've tried to retain ideas some standard java themes
like having a public static final 128 as a global constant, 
the fact that the key is a final variable, and BigInteger
is not even imported into this driver class.

Anyway, I'm glad you read all this. This class isn't too exciting,
but the other two are. Also, you might like to see hascryption.hs,
my Haskell solution.

Created by: Matt Senn
Class:      ITCS 4102
Instructor: G. Revesz
*/


import java.io.*;
import java.util.*;


public class EncryptionAssignment
{
	//some file name variables i'd like to declare up here
	public static final String fileKey = "key.txt";
	public static final String filePlain = "plain.txt";
	public static final String fileEncryption = "encryption.txt";
	
	public static void main(String[] args) throws IOException
	{
		String key = readForKey(fileKey);
		BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
		
		String input;
		boolean repeat;
		do{
			repeat = false;
			System.out.println("Would you like encryption or decryption?"
			                  +"\nSimply type 'e' or 'd':");
			input = keyboard.readLine();
			if (input.charAt(0)=='e')
			{
				String longMessage = new String();
				String message = readForEncryption(filePlain);
					
				while (message.length() % 22 != 0)				//while length isn't divisible by 22
					message += ' ';									//add another blank space (not the most efficient, but it works)
				
				encrypt_messages(key, message);					//encrypt the message with this key
			}
			else if (input.charAt(0) == 'd')
			{
				ArrayList<String> messages = readForDecryption(fileEncryption);
				decrypt_messages(key, messages);						//decrypt the messages with this key
			}
			else
			{
				repeat = true;
				System.out.println("Input not understood.");
			}
		}while(repeat);
		
	//	System.out.println("Thank you.\n\nCreated by Matthew Senn");	
	}
	
	static void encrypt_messages(String key, String longMessage)
	{
		Encryption encrypter = new Encryption(key);				//encrypter with the key
			
		for(int i=0; i <= longMessage.length()-22; i += 22)		//loop over each 22 char sequence
		{
			String partial = longMessage.substring(i,i+22);		//get a substring we'll encrypt
			String encryption = encrypter.encrypt(partial);		//encrypt it
			System.out.println(encryption);							//print resulting encryption
		}
	}
	
	
	static void decrypt_messages(String key, ArrayList<String> encryptions)
	{
		Decryption decrypter = new Decryption(key);			//decrypter with the key
		String accumulator = new String();
				
		for(String line : encryptions)							//iterate over encyptions
			accumulator += decrypter.decrypt(line);			//decrypt each one and add to accumulator
		
		System.out.println(accumulator);							//print resulting decrypted string
	}
	
	
	
	
	//I'd like to say that yes I am embarrased by the mess that is below.
	//I had a really difficult time with reading from file, specifically reading \r and \n
	//from the stream correctly and making sure that BigInteger doesn't get fed them.
	//i'm sure I missed something, but seriously....why does it have to be this hard?
	
	
	
	
	static String readForKey(String fileName) throws IOException
	{
		FileReader fr = new FileReader(fileName);
		BufferedReader br = new BufferedReader(fr);
		String key = br.readLine();
		fr.close();
		return key;
	}
	
	static ArrayList<String> readForDecryption(String fileName) throws IOException
	{
		Scanner sc = new Scanner(new File(fileName));
		ArrayList<String> lines = new ArrayList<String>();
		
 		while(sc.hasNext())
			lines.add(sc.nextLine());
			
		sc.close();
		return lines;
	}
	
	static String readForEncryption(String fileName) throws IOException
	{
		FileReader fr = new FileReader(fileName);
		BufferedReader br = new BufferedReader(fr);
 		
		String value="";
		String line ="";
			
		while ((value = br.readLine()) !=null)
			line += value;
			
		fr.close();
		return line;
	}
}
