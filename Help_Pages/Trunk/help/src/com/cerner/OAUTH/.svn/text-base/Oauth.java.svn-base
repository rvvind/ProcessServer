package com.cerner.OAUTH;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Hashtable;
import java.util.Random;

import javax.servlet.http.HttpUtils;
import javax.xml.ws.http.HTTPException;

import org.joda.time.DateTime;
import org.joda.time.Days;

import com.cerner.soa.LookUpProperties;

@SuppressWarnings("deprecation")
public class Oauth
{
	public Hashtable<String, String> getToken() throws IOException, URISyntaxException
	{
		// Hashtable to hold OAUTH return values
		Hashtable<String, String> oauthTokenHash = new Hashtable<String, String>();

		// Initialize lookup class
		LookUpProperties l = new LookUpProperties();

		// Lookup OAUTH request properties.
		String principal = l.lookUp("principal", "oauth_toke.properties");
		String key = l.lookUp("key", "oauth_toke.properties");
		String signature = l.lookUp("signature", "oauth_toke.properties");
		String tokenhost = l.lookUp("tokenhost", "oauth_toke.properties");

		// Initialize UTC epoch date
		DateTime utc = new DateTime(1970, 1, 1, 0, 0);
		// Calculate difference in seconds between current time and UTC epoch date
		String timestamp = String.valueOf(Days.daysBetween(utc, DateTime.now()).toStandardSeconds().getSeconds());
		// Initialize random class to calculate nonce.
		Random r = new Random();
		String nonce = timestamp + String.valueOf(generateRandomInteger(123400, 9999999, r));

		// Initialize auth method and version
		String method = "PLAINTEXT";
		String version = "1.0";

		// Construct GET url to obtain OAUTH toke.
		URL getTokenURL = new URL(tokenhost + "?xoauth_principal=" + principal + "&oauth_consumer_key=" + key + "&oauth_signature_method=" + method
				+ "&oauth_timestamp=" + timestamp + "&oauth_nonce=" + nonce + "&oauth_version=" + version + "&oauth_signature=" + signature);

		// Open HTTP connection
		HttpURLConnection getTokenCall = (HttpURLConnection) getTokenURL.openConnection();

		// If response is a 200 process response. else throw exception.
		if (getTokenCall.getResponseCode() == 200)
		{
			// Instantiate hash table to store OAUTH response.
			Hashtable<String, String[]> oauthResponseHash = new Hashtable<String, String[]>();

			// Extract response stream and initialize buffered reader
			InputStream responseStream = getTokenCall.getInputStream();
			BufferedReader reader = null;

			// Reading the response stream to convert to string.
			reader = new BufferedReader(new InputStreamReader(responseStream));
			
			for (String line; (line = reader.readLine()) != null;)
			{
				// Apply parse function to extract key value pairs.
				oauthResponseHash = HttpUtils.parseQueryString(line);
			}

			// Extract token and secret from properties object.
			String tokenString = oauthResponseHash.get("oauth_token")[0]; 
			tokenString = URLEncoder.encode(tokenString);
			String secret = oauthResponseHash.get("oauth_token_secret")[0];

			// concat OAUTH info to be sent out to the calling code.
			tokenString = "OAuth oauth_token=\"" + tokenString + "\", oauth_consumer_key=\"" + key + "\", oauth_signature_method=\"" + method
					+ "\", oauth_timestamp=\"" + timestamp + "\", oauth_nonce=\"" + nonce + "\", oauth_version=\"" + version
					+ "\", oauth_signature=\"" + signature + secret + "\"";
			

			// Add concatenated OAUTH response including token and secret to hash table. to be returned to calling code.
			oauthTokenHash.put("Authorization", tokenString);
		}
		else
		{
			throw new HTTPException(getTokenCall.getResponseCode());
		}

		return oauthTokenHash;
	}

	private static int generateRandomInteger(int aStart, int aEnd, Random aRandom)
	{
		if (aStart > aEnd)
		{
			throw new IllegalArgumentException("Start cannot exceed End.");
		}
		// get the range, casting to long to avoid overflow problems
		long range = (long) aEnd - (long) aStart + 1;
		// compute a fraction of the range, 0 <= frac < range
		long fraction = (long) (range * aRandom.nextDouble());
		return (int) (fraction + aStart);

	}
}
