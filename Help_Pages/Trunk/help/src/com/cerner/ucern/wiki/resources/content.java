package com.cerner.ucern.wiki.resources;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "content")
public class content
{
	// public content()
	// {
	//
	// }

	@XmlAttribute
	String		type;
	@XmlAttribute
	int			id;
	@XmlAttribute
	String		expand;

	@XmlElement
	link		link;
	@XmlElement
	String		title;
	@XmlElement
	String		url;
	@XmlElement
	String		parentId;
	@XmlElement
	String		spaceKey;
	@XmlElement
	children	children;
	@XmlElement
	comments	comments;
	@XmlElement
	String		body;

	public String gettype()
	{
		return type;
	}
	public int getid()
	{
		return id;
	}
	public String getexpand()
	{
		return expand;
	}
	public link getlink()
	{
		return link;
	}
	public String gettitle()
	{
		return title;
	}
	public String geturl()
	{
		return url;
	}
	public String getspaceKey()
	{
		return spaceKey;
	}
	public String getparentId()
	{
		return parentId;
	}
	public children getchildren()
	{
		return children;
	}

}
