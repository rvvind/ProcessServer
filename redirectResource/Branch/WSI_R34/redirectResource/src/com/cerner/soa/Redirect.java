package com.cerner.soa;

import java.net.URI;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.ws.rs.GET;
import javax.ws.rs.MatrixParam;
import javax.ws.rs.Path;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/*")
public class Redirect
{
	public static CallableStatement	callableStatement	= null;

	public ODSConnection			odsCon				= new ODSConnection();
	public LookUpProperties			l					= new LookUpProperties();

	public ResultSet				dbResultSet			= null;

	/**
	 * 
	 * @param name
	 *            - Name of the field to be looked up on
	 * @param value
	 *            - Value of the field to be looked up with.
	 * @return
	 */
	@GET
	@Path("/Ticket")
	public Response redirectUTN(@MatrixParam("paramName") String name, @MatrixParam("paramVal") String value)
	{
		try
		{			
			/**
			 * Check for generic name and value parameters for nulls
			 */
			if (name != null)
			{
				if (name.isEmpty() || name.equalsIgnoreCase("")) throw new Exception("Parameter lookup not found");
			}
			else throw new Exception("Required parameter null: Parameter Name: paramName");

			if (value != null)
			{
				if (value.isEmpty() || value.equalsIgnoreCase("")) throw new Exception("Search value not found.");
			}
			else throw new Exception("Required parameter null: Parameter Name: paramVal");

			try
			{
				/**
				 * Query ODSCRM for the record.
				 */
				return processParamsAndExecDB("odscrm", name, value);
			}
			catch (Exception ex)
			{
				try
				{
					/**
					 * Query RemedyIntegration for the record.
					 */
					return processParamsAndExecDB("remedyintegration", name, value);
				}
				catch (Exception ex1)
				{
					/**
					 * If no records found in RemedyIntegration, throw not found exception
					 */
					if (ex1.getMessage().equalsIgnoreCase("NOREC"))
					{
						throw new WebApplicationException(Response.status(404).entity("No records found. " + name + ":" + value)
								.type(MediaType.TEXT_PLAIN).build());
					}
					else throw ex;
				}
			}
		}
		catch (WebApplicationException e)
		{
			throw e;
		}
		catch (Exception ex)
		{
			System.out.println(ex.getMessage());
			throw new WebApplicationException(Response.status(500).entity(ex.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
	}
	
	@GET
	@Path("/SolutionChange")
	public Response redirectSolutionChange(@MatrixParam("paramName") String name, @MatrixParam("paramVal") String value)
	{
		try
		{
			ODSConnection odsCon = new ODSConnection();
			Connection con = odsCon.connect("odscrm");

			ResultSet dbResultSet = null;
			String dbResult = "";

			LookUpProperties l = new LookUpProperties();
			String paramName = l.lookUp("navigator."+name, "Field_Mappings.properties");

			if (name.isEmpty() || name.equalsIgnoreCase("")) throw new Exception("Parameter lookup not found");
			if (value.isEmpty() || value.equalsIgnoreCase("")) throw new Exception("Search value not found.");
			
			PreparedStatement sqlQuery = con.prepareStatement("select distinct row_id from dbo.R3_S_PROD_DEFECT where " + paramName + " = ?");// l.lookUp("clientSourceQuery",
			// "db.properties"));
			sqlQuery.setString(1, value);

			dbResultSet = sqlQuery.executeQuery();

			while (dbResultSet.next())
				dbResult = dbResultSet.getString(1);

			odsCon.close(con);

			if (!dbResult.isEmpty())
			{
				String baseURL = l.lookUp("navigator" + "." + "SolutionChange", "redirect.properties");

				String redirectURL = baseURL.replace("{id}", dbResult);
				return Response.temporaryRedirect(new URI(redirectURL)).build();
			}
			else throw new WebApplicationException(Response.status(404).entity("Requested resource not found. " + name + " : " + value)
					.type(MediaType.TEXT_PLAIN).build());
		}
		catch (WebApplicationException e)
		{
			throw e;
		}
		catch (Exception ex)
		{
			System.out.println(ex.getMessage());
			throw new WebApplicationException(Response.status(500).entity(ex.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}

	}

	@GET
	@Path("/Client")
	public Response redirectClient(@MatrixParam("paramName") String name, @MatrixParam("paramVal") String value,
			@MatrixParam("destination") String destination, @MatrixParam("viewName") String viewName)
	{
		try
		{
			ODSConnection odsCon = new ODSConnection();
			Connection con = odsCon.connect("odscrm");

			ResultSet dbResultSet = null;
			String dbResult = "";

			LookUpProperties l = new LookUpProperties();
			String paramName = l.lookUp(name, "Field_Mappings.properties");

			if (name.isEmpty() || name.equalsIgnoreCase("")) throw new Exception("Parameter lookup not found");
			if (value.isEmpty() || value.equalsIgnoreCase("")) throw new Exception("Search value not found.");
			if (destination.isEmpty() || destination.equalsIgnoreCase("")) throw new Exception("Destination value not found.");

			PreparedStatement sqlQuery = con.prepareStatement("select distinct row_id as id from dbo.R3_S_ORG_EXT where " + paramName + " = ?");// l.lookUp("clientSourceQuery",
			// "db.properties"));
			sqlQuery.setString(1, value);

			dbResultSet = sqlQuery.executeQuery();

			while (dbResultSet.next())
				dbResult = dbResultSet.getString(1);

			odsCon.close(con);

			if (!dbResult.isEmpty())
			{
				String baseURL = l.lookUp(destination + "." + "client" + "." + viewName, "redirect.properties");

				String redirectURL = baseURL.replace("{id}", dbResult);
				return Response.temporaryRedirect(new URI(redirectURL)).build();
			}
			else throw new WebApplicationException(Response.status(404).entity("Requested resource not found. " + name + " : " + value)
					.type(MediaType.TEXT_PLAIN).build());
		}
		catch (WebApplicationException e)
		{
			throw e;
		}
		catch (Exception ex)
		{
			System.out.println(ex.getMessage());
			throw new WebApplicationException(Response.status(500).entity(ex.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}

	}

	private Response processParamsAndExecDB(String source, String name, String value) throws Exception
	{
		String dbResult = "";
		String redirectURL = "";

		if (source.equalsIgnoreCase("remedyintegration"))
		{
			/**
			 * Lookup Navigator field map value. If value not found, do Remedy field map value lookup.
			 */
			String paramName = l.lookUp("remedy." + name, "Field_Mappings.properties");

			if (paramName != null)
			{
				if (!paramName.isEmpty() || !paramName.equalsIgnoreCase(""))
				{
					Connection con = odsCon.connect(source);
					PreparedStatement sqlQuery1 = con
							.prepareStatement("select distinct INSTANCEID from RemedyIntegration.dbo.VW_HPD_HELP_DESK where " + paramName + " = ?");
					sqlQuery1.setString(1, value);

					dbResultSet = sqlQuery1.executeQuery();

					while (dbResultSet.next())
						dbResult = dbResultSet.getString(1);

					if (!dbResult.isEmpty())
					{
						String baseURL = l.lookUp("remedy" + "." + "UTN", "redirect.properties");
						redirectURL = baseURL.replace("{id}", dbResult);
						odsCon.close(con);
					}
					else throw new Exception("NOREC");
				}
				else throw new Exception("Required parameter null: Parameter Name: paramName");
			}
			else throw new Exception("Required parameter null: Parameter Name: paramName");
		}
		else if (source.equalsIgnoreCase("odscrm"))
		{
			String paramName = l.lookUp("navigator." + name, "Field_Mappings.properties");

			if (paramName != null)
			{
				if (!paramName.isEmpty() || !paramName.equalsIgnoreCase(""))
				{
					Connection con = odsCon.connect(source);
					PreparedStatement sqlQuery = con.prepareStatement("select distinct row_id as id from dbo.R3_S_SRV_REQ where " + paramName
							+ " = ?");
					sqlQuery.setString(1, value);

					dbResultSet = sqlQuery.executeQuery();

					while (dbResultSet.next())
						dbResult = dbResultSet.getString(1);

					if (!dbResult.isEmpty())
					{
						String baseURL = l.lookUp("navigator" + "." + "UTN", "redirect.properties");
						redirectURL = baseURL.replace("{id}", dbResult);
						odsCon.close(con);
					}
					else throw new Exception("NOREC");
				}
				else throw new Exception("Required parameter null: Parameter Name: paramName");
			}
			else throw new Exception("Required parameter null: Parameter Name: paramName");
		}

		if (!redirectURL.isEmpty()) return Response.temporaryRedirect(new URI(redirectURL)).build();
		else throw new WebApplicationException(Response.status(404).entity("Requested resource not found. " + name + " : " + value)
				.type(MediaType.TEXT_PLAIN).build());
	}
}
