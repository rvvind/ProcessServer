package com.cerner.ucern.wiki.resources;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "comments")
public class comments
{
//	public comments()
//	{
//
//	}

	@XmlAttribute
	String	total;

}
