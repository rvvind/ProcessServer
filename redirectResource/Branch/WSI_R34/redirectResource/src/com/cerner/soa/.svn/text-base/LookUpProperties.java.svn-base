package com.cerner.soa;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class LookUpProperties
{
	public String lookUp (String key, String propFileLoc) throws IOException
	{
		Properties prop = new Properties();
		InputStream is;
		is = this.getClass().getResourceAsStream(propFileLoc);

		prop.load(is);
		is.close();

		String value = prop.getProperty(key);
		return value;
	}

}
