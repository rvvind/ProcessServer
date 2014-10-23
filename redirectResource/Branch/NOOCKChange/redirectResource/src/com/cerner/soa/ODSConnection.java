package com.cerner.soa;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.*;

public class ODSConnection
{
	public static Connection	connection	= null;
	public static ResultSet		resultset	= null;
	public static Statement		statement	= null;
	private static String		DBURL		= null;
	private static String		username	= null;
	private static String		password	= null;

	public Connection connect(String source) throws Exception
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		this.assignDBCredentials(source);

		connection = DriverManager.getConnection(DBURL, username, password);

		if (connection == null)
		{
			System.out.println("connection failed");
		}

		// connection.setAutoCommit(true);

		// statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

		return connection;
	}

	public void assignDBCredentials(String source) throws IOException
	{
		// load database credentials from properties file
		try
		{
			LookUpProperties l = new LookUpProperties();

			DBURL = l.lookUp(source, "db.properties");
			username = l.lookUp("userName", "db.properties");
			password = l.lookUp("password", "db.properties");
		}
		catch (Exception e)
		{
			System.out.println("Problem reading properties file: " + e.getMessage());
		}
	}

	public void close(Connection c) throws Exception
	{
		if (c != null)
		{
			try
			{
				c.commit();
				c.close();
			}
			catch (Exception e)
			{
				System.out.println("Problem in closing ODS connection: " + e.getMessage());
			}
			c = null;
		}
	}

	public void close() throws Exception
	{
		if (connection != null)
		{
			try
			{
				connection.commit();
				connection.close();
			}
			catch (Exception e)
			{
				System.out.println("Problem in closing DB2 connection: " + e.getMessage());
			}
			connection = null;
		}
	}
}