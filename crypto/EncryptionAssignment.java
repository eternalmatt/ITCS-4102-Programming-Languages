import java.io.*;
import java.util.*;


public class EncryptionAssignment
{
	public static final String fileKey = "key.txt";
	public static final String filePlain = "plain.txt";
	public static final String fileEncryption = "encryption.txt";
	
	public static void main(String[] args) throws IOException
	{
		String key = readFromFile(fileKey).get(0);
		BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
		
		String input;
		boolean repeat = false;
		do{
			System.out.println("Would you like encryption or decryption?"
			                  +"\nSimply type 'e' or 'd':");
			input = keyboard.readLine();
			if (input.charAt(0)=='e')
			{
				String longMessage = new String();
				ArrayList<String> messages = readFromFile(filePlain);
				for(String message : messages)
					longMessage += message;
				
				encrypt_messages(key, longMessage);
			}
			else if (input.charAt(0) == 'd')
			{
				ArrayList<String> messages = readFromFile(fileEncryption);
				decrypt_messages(key, messages);
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
		Encryption encrypter = new Encryption(key);
			
		for(int i=0; i < longMessage.length()-22; i += 22)
		{
			String encryption = encrypter.encrypt(longMessage.substring(i,i+22));
			System.out.println(encryption);
		}
	}
	
	static void decrypt_messages(String key, ArrayList<String> encryptions)
	{
		Decryption decrypter = new Decryption(key);
		String accumulator = new String();
				
		for(String line : encryptions)
		{
			String decrypted = decrypter.decrypt(line);
			accumulator += decrypted;
		}
		
		System.out.println(accumulator);
	}
	
	
	static ArrayList<String> readFromFile(String fileName) throws IOException
	{
		FileReader fr = new FileReader(fileName);
		BufferedReader br = new BufferedReader(fr);
 		String line = new String();
		ArrayList<String> message = new ArrayList<String>();
		
		while ((line = br.readLine()) != null)
     // {
			message.add(line);				//add to accumulator
			//System.out.println(line);	//print to stdout
     // }
		
		fr.close();		
		return message;
	}
}
