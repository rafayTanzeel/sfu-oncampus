import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Set;

/**
 * Created on: Feb 16, 2015 at 4:18:55 PM
 * Project: SFUDrawMap
 * File: Graph.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class Graph implements Serializable
{
	Hashtable<String,GraphNode> labels = new Hashtable<String,GraphNode>();
	int autoIncrementID =0;
	Hashtable<GraphNode,Set<GraphNode>> adjacency = new Hashtable<GraphNode,Set<GraphNode>>();
	ArrayList<GraphNode> nodes = new ArrayList();
	/**
	 * @param xRel
	 * @param yRel
	 * @return
	 */
	public GraphNode addPoint(double xRel, double yRel)
	{
		GraphNode gn = new GraphNode(this,xRel,yRel);
		nodes.add(gn);
		gn.id = autoIncrementID;
		autoIncrementID++;
		return gn;
	}
	/**
	 * @param a
	 * @param b
	 */
	public void addEdge(GraphNode a, GraphNode b)
	{
		Set<GraphNode> la;
		Set<GraphNode> lb;
		
		if(adjacency.containsKey(a))
		{
				la = adjacency.get(a);
		}else
		{
			 la = new HashSet<GraphNode>();
			 adjacency.put(a, la);
		}
		
		if(adjacency.containsKey(b))
		{
				lb = adjacency.get(b);
		}else
		{
			 lb = new HashSet<GraphNode>();
			 adjacency.put(b, lb);
		}
		
		if(la.contains(b))
		{
			return;
		}
		la.add(b);
		lb.add(a);
		
	}
	
	public Set<GraphNode> getAdjacent(GraphNode n)
	{
		if(!adjacency.containsKey(n)) 
			return new HashSet<GraphNode>(); // empty list
		
		return adjacency.get(n);
	
	}
	/**
	 * @param a
	 * @param b
	 */
	public void removeEdge(GraphNode a, GraphNode b)
	{
		Set<GraphNode> l;
		Set<GraphNode> l2;
		
		if(adjacency.containsKey(a))
		{
				l = adjacency.get(a);
						l.remove(b);
		}
		if(adjacency.containsKey(b))
		{
				l2 = adjacency.get(b);
				l2.remove(a);
		}
		
		
		
		
		
	}
	/**
	 * @param id
	 * @return 
	 */
	public boolean removeNode(int id)
	{
		for(GraphNode n : nodes)
		{
			if(n.id == id)
			{
				Set<GraphNode> l = adjacency.get(n);
						if(l != null)
						{
							for(GraphNode b : l )
							{
								adjacency.get(b).remove(n);
							}
						}
				
				adjacency.remove(n);
				nodes.remove(n);
				
				return true;
			}
			
		}
		return false;
		
	}
}
