package com.cerner.soa;

import info.bliki.wiki.filter.HTMLConverter;
import info.bliki.wiki.filter.PlainTextConverter;
import info.bliki.wiki.model.WikiModel;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.ws.rs.GET;
import javax.ws.rs.MatrixParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.jsefa.Deserializer;
import org.jsefa.csv.CsvIOFactory;
import org.jsefa.csv.config.CsvConfiguration;

import com.cerner.ucern.wiki.resources.children;
import com.cerner.ucern.wiki.resources.content;
import com.cerner.ucern.wiki.resources.link;
import com.cerner.ucern.wiki.resources.ucern_wiki_references;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

@Path("/")
public class Help
{
	public ResultSet	rs;

	// GET method that takes in a Service Invoke URL looks for the/help keyword and looks up the internal references database to obtain the right re-direct url
	// and sends a redirect response to the call.
	@GET
	@Path("{var:.*}")
	public Response redirect(@PathParam("var") String var)
	{
		try
		{
			String redirectURL = "";
			LookUpProperties l = new LookUpProperties();

			String SERVICE_NAME = extractServiceName(var);

			DB2Connection db2con = new DB2Connection();
			Connection c = db2con.connect();

			PreparedStatement selectStmt = c.prepareStatement("SELECT CONTENT_URL FROM " + l.lookUp("ucernWikiTable", "db.properties")
					+ " WHERE LOWER(SERVICE_NAME) LIKE '%' || ? || '%' FETCH FIRST ROW ONLY");

			selectStmt.setString(1, SERVICE_NAME.toLowerCase());

			rs = executeDBOperation(selectStmt, "select");

			while (rs.next())
			{
				redirectURL = rs.getString(1);
			}

			db2con.close(c);

			if (redirectURL != "") return Response.temporaryRedirect(new URI(l.lookUp("wikiBaseURL", "help.properties") + redirectURL)).build();
			else throw new WebApplicationException(Response.status(404)
					.entity("Requested resource's wiki page not found. \n\n Resource looked up: " + SERVICE_NAME).type(MediaType.TEXT_PLAIN).build());
		}
		catch (URISyntaxException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (IOException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (WebApplicationException e)
		{
			throw e;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
	}

	// POST service that accepts CSV content, and updates our internal reference database.
	// POST m that takes in a CSV file to update our internal reference database
	@POST
	@Path("/Update/Invoke")
	public String InvokeUpdate(String csvContent, @MatrixParam("type") String sourceType, @MatrixParam("format") String sourceFormat)
	{
		try
		{
			if (sourceFormat != null && sourceType != null)
			{
				if (sourceFormat.equalsIgnoreCase("CSV") && sourceType.equalsIgnoreCase("WIKI"))
				{
					CsvConfiguration config = new CsvConfiguration();
					config.setFieldDelimiter(',');

					Deserializer deserializer = CsvIOFactory.createFactory(config, ucern_wiki_references.class).createDeserializer();
					StringReader reader = new StringReader(csvContent);
					deserializer.open(reader);

					while (deserializer.hasNext())
					{
						ucern_wiki_references ref = deserializer.next();
						try
						{
							dbUpdate(ref);
						}
						catch (Exception e)
						{
							e.printStackTrace();
							throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
						}
					}

				}
				return "success";
			}
			else
			{
				throw new WebApplicationException(Response.status(400).entity("Bad Request").type(MediaType.TEXT_PLAIN).build());
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}

	}

	// POST service that accepts a REST-ful wiki.ucern.com resource URL, calls their API and writes response to our internal reference database.
	@POST
	@Path("/Sync/Invoke")
	public String InvokeSync(String wikiContent, @MatrixParam("type") String sourceType, @MatrixParam("format") String sourceFormat, @Context HttpHeaders headers)
	{
		HttpClient httpclient = new DefaultHttpClient();

		try
		{
			if (sourceFormat != null && sourceType != null && wikiContent != null)
			{
				if (sourceFormat.equalsIgnoreCase("REST") && sourceType.equalsIgnoreCase("WIKI") && wikiContent.startsWith("https"))
				{
					HttpGet ucernWikiGet = new HttpGet(wikiContent);
					//ucernWikiGet.setHeader("Authorization", "Basic " + Base64.encode("username:password".getBytes()));
					ucernWikiGet.setHeader("Authorization", "Basic " + getEncodedCredentials(headers));
					
					HttpResponse response = httpclient.execute(ucernWikiGet);
					int responseStatus = response.getStatusLine().getStatusCode();
					String responseMessage = response.getStatusLine().getReasonPhrase();

					if (responseStatus == 200)
					{
						HttpEntity responseEntity = response.getEntity();
						InputStream inStream = responseEntity.getContent();

						content[] childrenContent = marshalContent(inStream, "wiki");

						for (content c : childrenContent)
						{
							dbInsertUpdate(c);
						}

					}
					else
					{
						throw new WebApplicationException(Response.status(responseStatus).entity(responseStatus + " : " + responseMessage)
								.type(MediaType.TEXT_PLAIN).build());
					}

				}
				else if (sourceFormat.equalsIgnoreCase("XML") && sourceType.equalsIgnoreCase("WIKI"))
				{
					InputStream inputStream = new ByteArrayInputStream(wikiContent.getBytes("UTF-8"));

					content[] childrenContent = marshalContent(inputStream, "wiki");

					for (content c : childrenContent)
					{
						dbInsertUpdate(c);
					}
				}
				else
				{
					throw new WebApplicationException(Response.status(400).entity("Bad Request").type(MediaType.TEXT_PLAIN).build());
				}
			}
			else
			{
				throw new WebApplicationException(Response.status(400).entity("Bad Request").type(MediaType.TEXT_PLAIN).build());
			}

			return "success";
		}
		catch (JAXBException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (IOException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (XMLStreamException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (NamingException e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		catch (WebApplicationException we)
		{
			we.printStackTrace();
			throw we;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new WebApplicationException(Response.status(500).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build());
		}
		finally
		{
			// When HttpClient instance is no longer needed,
			// shut down the connection manager to ensure
			// immediate deallocation of all system resources
			httpclient.getConnectionManager().shutdown();
		}
	}

	// Marshaller method that takes in an input stream and a class type that it can serialize with.
	// When supplied with the parameter 'wiki' it uses the content.java class residing in 'com.cerner.ucern.wiki.resources' package to de-serialize
	// the response from the wiki API.
	private content[] marshalContent(InputStream inputStream, String resourceClass) throws Exception
	{
		if (resourceClass.equalsIgnoreCase("wiki"))
		{
			JAXBContext jc = JAXBContext.newInstance("com.cerner.ucern.wiki.resources");
			Unmarshaller u = jc.createUnmarshaller();

			XMLInputFactory inputFactory = XMLInputFactory.newInstance();
			XMLStreamReader xReader = inputFactory.createXMLStreamReader(inputStream);

			JAXBElement<content> jaxBElement = (JAXBElement<content>) u.unmarshal(xReader, content.class);

			content wikiPageContent = (content) jaxBElement.getValue();
			children childElement = wikiPageContent.getchildren();
			content[] childrenContent = childElement.getcontent();

			return childrenContent;
		}
		else
		{
			throw new Exception("Invalid resource request");
		}
	}

	// Method to insert or update content in our internal references database
	private void dbInsertUpdate(content c) throws Exception
	{
		LookUpProperties l = new LookUpProperties();

		String contentType = c.gettype().replace("'", "''");
		int contentId = c.getid();
		String contentTitle = c.gettitle().replace("'", "''");
		String contentURL = c.geturl().replace("'", "''");
		String parentId = c.getparentId().replace("'", "''");
		String contentSpaceKey = c.getspaceKey().replace("'", "''");

		link resource = c.getlink();
		String resourceURL = resource.gethref();

		DB2Connection db2Con = new DB2Connection();
		Connection con = db2Con.connect();

		PreparedStatement selectStmt = con.prepareStatement("SELECT COUNT(*) as count FROM " + l.lookUp("ucernWikiTable", "db.properties")
				+ " WHERE ID = ?");
		selectStmt.setInt(1, contentId);

		rs = executeDBOperation(selectStmt, "select");

		while (rs.next())
		{
			if (rs.getInt(1) > 0)
			{
				PreparedStatement updateStmt = con.prepareStatement("UPDATE " + l.lookUp("ucernWikiTable", "db.properties")
						+ " SET TITLE = ?, RESOURCE_URL = ? , TYPE = ?, CONTENT_URL = ?, PARENT_ID = ?, SPACE_KEY = ? WHERE ID = ?");

				updateStmt.setString(1, contentTitle);
				updateStmt.setString(2, resourceURL);
				updateStmt.setString(3, contentType);
				updateStmt.setString(4, contentURL);
				updateStmt.setString(5, parentId);
				updateStmt.setString(6, contentSpaceKey);
				updateStmt.setInt(7, contentId);

				executeDBOperation(updateStmt, "update");
			}
			else
			{
				PreparedStatement insertStmt = con
						.prepareStatement("INSERT INTO SOAADM.UCERN_WIKI_REFERENCES (ID, TITLE, RESOURCE_URL, TYPE, CONTENT_URL, PARENT_ID, SPACE_KEY, SERVICE_NAME) VALUES (? , ? , ?, ?, ?, ?, ?,'')");

				insertStmt.setInt(1, contentId);
				insertStmt.setString(2, contentTitle);
				insertStmt.setString(3, resourceURL);
				insertStmt.setString(4, contentType);
				insertStmt.setString(5, contentURL);
				insertStmt.setString(6, parentId);
				insertStmt.setString(7, contentSpaceKey);

				executeDBOperation(insertStmt, "insert");
			}
		}

		db2Con.close(con);
	}

	// Method to update content in our internal references database
	private int dbUpdate(ucern_wiki_references u) throws Exception
	{
		int affectedRows = 0;

		LookUpProperties l = new LookUpProperties();

		int contentId = u.getID();
		String serviceName = u.getSERVICE_NAME();

		DB2Connection db2Con = new DB2Connection();
		Connection con = db2Con.connect();

		PreparedStatement selectStmt = con.prepareStatement("SELECT COUNT(*) as count FROM " + l.lookUp("ucernWikiTable", "db.properties")
				+ " WHERE ID = ?");

		selectStmt.setInt(1, contentId);

		rs = executeDBOperation(selectStmt, "select");

		while (rs.next())
		{
			if (rs.getInt(1) == 1)
			{
				PreparedStatement updateStmt = con.prepareStatement("UPDATE " + l.lookUp("ucernWikiTable", "db.properties")
						+ " SET SERVICE_NAME = ? WHERE ID = ?");

				updateStmt.setString(1, serviceName);
				updateStmt.setInt(2, contentId);

				executeDBOperation(updateStmt, "update");

				affectedRows = 1;
			}
			else
			{
				affectedRows = 0;
			}
		}

		return affectedRows;
	}

	// Parser method to extract service name from the URL on the GET call
	private String extractServiceName(String URL)
	{
		if (URL.indexOf('/') > 0) return URL.substring(0, URL.indexOf('/'));
		else return URL;
	}

	// Executes Query and Returns XML String for Response
	private ResultSet executeDBOperation(PreparedStatement SQL, String action) throws Exception
	{
		if (action.equalsIgnoreCase("select"))
		{
			// Execute Query Get Result Set
			rs = SQL.executeQuery();
			return rs;
		}
		else
		{
			SQL.executeUpdate();
			return null;
		}
	}

	// Incomplete method that I'mplaying with that can parse wiki content. It uses the bliki framework to parse wiki content to html.
	private String convertWikiToHTML(String wikiContent)
	{
		WikiModel w = new WikiModel("http://www.mywiki.com/wiki/${image}", "http://www.mywiki.com/wiki/${title}");
		String test1 = "h4. Purpose[AQPMonitor|http://wservice.cerner.com/AQPMonitor/AQPMon.html]&amp;nbsp;is an application used to query for Process Instances of AQP Business Process executions. The application lets users query for process instances based on the client mnemonic or any part of the opty name. Users can also query based on date ranges of execution times. These times would correspond to when the execution was started.h5.h5. TechnologyFront End : GWT (Google Web Toolkit)Service Layer: JAX-RS REST-ful BPELData service.Data Source:[IBM BFM API|http://publib.boulder.ibm.com/infocenter/dmndhelp/v7r0mx/index.jsp?topic=%2Fcom.ibm.bspace.help.api.rest.doc%2Frest%2Fwsprocessserver%2Frest_bpm_bfm.htm]h5. UI Elementsh6. SearchOpty Name: This field accepts whole or part of the Opty Name to search for process instances.From, To:These fields accept date choices that would correspond to when the business process was executed.!aqpmon_Search.PNG!h6. ResultsThe results are displayed in a stacked panel. Clicking on the panel header will drop down details about the execution that includes all the execution steps the process has gone through. Each step will have an icon showing if the action is in a running, succeeded, failed or terminated state.!aqpmon_Results.PNG!h6. Human Task ActionThe Human Task actions, part of the AQP process (such as Push to Contracts Human Task) that provide restart capability in the event of business errors at specific submit tasks is implemented in the form of a refresh button!aqpmon_HT.PNG!h6. Error MessagesApplication error messages are implemented as in-screen pop-ups like the ones shown below. Users can click outside the box to dismiss the pop-up.!aqpmon_ERR.PNG!";
		String TEST = "*{+}Upload PROJECT ONTO SERVER (EAR FILE)+*# &nbsp;Run administrative console:## Launch ucern (ucern.com)## Go to WebSphere Process Server group## Click on Process Server Links## Under Administration Console heading, select the environment you need to work with# Administration Console login screen appears.# Login using your network domain name and password.# On left-hand pane, select Applications Enterprise Applications# Select the check-box next to the application you wish to upload the EAR file for.# Click the Update button.# &nbsp;Under Local file system radial button à Full Path, Browse to where you exported the EAR file to.# Click Next.# Click Next on \"Select installation options\" screen.# On the \"Map modules to servers\" screen, ## Check the select column's checkbox next to the modules## GRDSOAWSDEV00: select WebSphere:cell=DEVCELL,cluster=WPSCL and WebSphere:cell=DEVCELL,node=NODE00,server=WSWEB00 and click the Apply button and then the Next button.&nbsp;## GRDSOAWSTST00: select WebSphere:cell=TSTCELL,cluster=WPSCL and WebSphere:cell=TSTCELL,node=NODE00,server=WSWEB00 and click the Apply button and then the Next button.&nbsp;## GRDSOAWSCRT00: select WebSphere:cell=CRTCELL,cluster=WPSCL and WebSphere:cell=CRTCELL,node=WPS00NODE,server=WEBWS00 and WebSphere:cell=CRTCELL,node=WPS00NODE,server=WEBWS01 and click the Apply button and then the Next button.&nbsp;## GRDSOAWSWHQ00: select \"WebSphere:cell=PRODCELL,cluster=WPSCL\" and \"WebSphere:cell=PRODCELL,node=WPS00NODE,server=WEBWS00\" and \"WebSphere:cell=PRODCELL,node=WPS00NODE,server=WEBWS01\" and click the Apply button and then the Next button.&nbsp;# Click Finish on \"Summary\" screen.# Click Finish on \"Summary\" screen.# Progress screen beginning with \"Updating...\" will appear. When successful you will see a message stating \"Application xxxxxx installed successfully\"# Click the +Save+ hyperlink.# You are returned to the main Enterprise Applications screen.# Next, update the Web Services client bindings and Client security bindings.# Click on the hyperlink for your application name.# Click on +Manage Modules+ hyperlink.# Click on the module hyperlink for the EJB module.# To update the end point URL for services, select +Web services client bindings+\\## Select +Edit...+ hyperlink under Port Information## In the URL within Overridden Endpoint URL field, update the URL.## Click Apply## Click Save## &nbsp;Click OK&nbsp;and Click Save";
		String htmlstr = w.render(new HTMLConverter(), test1);
		String plainStr = w.render(new PlainTextConverter(), test1);

		return htmlstr;
	}

	// Transform Clob data from Database to a String Oracles JDBC driver does
	// not support querying the XML Data Type so XML must be queried as a Clob
	private String clobToString(Clob data) throws Exception
	{
		StringBuilder sb = new StringBuilder();

		Reader reader = data.getCharacterStream();
		BufferedReader br = new BufferedReader(reader);

		String line;
		while (null != (line = br.readLine()))
		{
			sb.append(line);
		}

		br.close();

		return sb.toString();
	}

	// Get Datasource from WAS
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private DataSource getDS() throws Exception
	{
		// Get Initial Context from WAS
		Hashtable env = new Hashtable();
		env.put(javax.naming.Context.INITIAL_CONTEXT_FACTORY, "com.ibm.websphere.naming.WsnInitialContextFactory");
		InitialContext ctx = new InitialContext(env);

		// Get JNDI Datasource from WAS
		DataSource ds = (DataSource) ctx.lookup("jdbc/WPRDEV");

		return ds;
	}

	private String getEncodedCredentials(HttpHeaders headers) throws Base64DecodingException
	{
		String auth = headers.getRequestHeader("authorization").get(0);
		auth = auth.substring("Basic ".length());

		return auth;
	}
}
