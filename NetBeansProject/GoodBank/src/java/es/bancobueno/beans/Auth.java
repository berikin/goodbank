package es.bancobueno.beans;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author José Antonio Yáñez
 * http://www.jimenezfrontend.es
 */
public class Auth
    {
    private String rawString;
    private String shaString;

    public Auth()
	{
	}

    public void setRawString(String rawString)
	{
	this.rawString = rawString;
	}

    public void calculateSHA512()
	{
	this.shaString = generateSHA(this.rawString);
	}

    
    public String getshaString()
	{
	return shaString;
	}
    
    
    static String generateSHA(String rawInput)
	{
	MessageDigest md;
	try
	    {
	    md = MessageDigest.getInstance("SHA-512");

	    md.update(rawInput.getBytes());
	    byte[] mb = md.digest();
	    String out = "";
	    for (int i = 0; i < mb.length; i++)
		{
		byte temp = mb[i];
		String s = Integer.toHexString(new Byte(temp));
		while (s.length() < 2)
		    {
		    s = "0" + s;
		    }
		s = s.substring(s.length() - 2);
		out += s;
		}
	    return out;
	    }
	catch (NoSuchAlgorithmException e)
	    {
	    return null;
	    }
	}
    }
