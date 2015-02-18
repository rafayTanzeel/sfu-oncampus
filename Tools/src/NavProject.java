import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created on: Feb 18, 2015 at 7:17:06 AM
 * Project: SFUDrawMap
 * File: NavProject.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class NavProject implements Serializable
{
	ArrayList<NavDomain> domains = new ArrayList<NavDomain>();
	
	public NavDomain getDomain(int i)
	{
		return domains.get(i);
	}
	
	public NavDomain createDomain(String withName)
	{
		NavDomain d= new NavDomain(withName);
		 domains.add(d);
		 return d;
	}
	
	public ArrayList<NavDomain> listPages()
	{
		return domains;
		
	}

}
