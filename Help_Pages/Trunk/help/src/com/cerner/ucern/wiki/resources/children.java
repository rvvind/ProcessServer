package com.cerner.ucern.wiki.resources;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "children")
public class children
{
//	public children()
//	{
//
//	}

	@XmlAttribute
	int			size;
	@XmlAttribute
	String		expand;

	@XmlElement
	content[]	content;
	
	public content[] getcontent()
	{
		return content;
	}

}
