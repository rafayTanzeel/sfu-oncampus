import java.awt.image.BufferedImage;
import java.io.Serializable;

import javax.swing.ImageIcon;

/**
 * Created on: Feb 16, 2015 at 4:23:21 PM
 * Project: SFUDrawMap
 * File: NavPage.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class NavPage implements Serializable
{
	private Graph g;
	ImageIcon i;
	private String path;
	private String name;
	/**
	 * @param i2
	 */
	public void setBackgroundImage(ImageIcon i2)
	{
		this.i=i2;
		g= new Graph();
		
	}
	/**
	 * @param represents
	 * @param represents2
	 */
	public void addEdge(GraphNode a, GraphNode b)
	{
		g.addEdge(a,b);
		
	}
	/**
	 * @param xRel
	 * @param yRel
	 * @return
	 */
	public GraphNode addPoint(double xRel, double yRel)
	{
		return g.addPoint(xRel,yRel);
	}
	/**
	 * @param represents
	 * @param represents2
	 */
	public void removeEdge(GraphNode a, GraphNode b)
	{
		g.removeEdge(a,b);
		
	}
	
	public String getName()
	{
		return name;
	}
	/**
	 * @param id
	 */
	public void removeNode(int id)
	{
		g.removeNode(id);
		
	}
}
