package com.cerner.ucern.wiki.resources;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "link")
public class link
{
//	public link()
//	{
//
//	}

	@XmlAttribute
	String	rel;
	@XmlAttribute
	String	href;
	
	public String gethref()
	{
		return href;
	}
}
