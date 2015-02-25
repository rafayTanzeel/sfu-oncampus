import java.awt.geom.Point2D;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Set;

/**
 * Created on: Feb 16, 2015 at 4:21:19 PM
 * Project: SFUDrawMap
 * File: GraphNode.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class GraphNode implements Serializable
{
	/**
	 * @param xRel
	 * @param yRel
	 */
	public GraphNode(Graph graph, double xRel, double yRel)
	{
		pos = new Point2D.Double(xRel, yRel);
		this.graph = graph;
	}
	public Point2D pos;
	public float radius =1;
	public int id;
	private Graph graph;
	/**
	 * @return
	 */
	public Set<GraphNode> getAdjacent()
	{
		return graph.getAdjacent(this);
	}
}
