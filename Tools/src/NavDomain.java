import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created on: Feb 18, 2015 at 7:22:44 AM
 * Project: SFUDrawMap
 * File: NavDomain.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class NavDomain implements Serializable
{
	ArrayList<NavPage> pages = new ArrayList<NavPage>();
	/**
	 * @param withName
	 */
	public NavDomain(String withName)
	{
		// TODO Auto-generated constructor stub
	}
	public ArrayList<NavPage> listPages()
	{
		 return pages;
	}

}
