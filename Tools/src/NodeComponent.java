import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.geom.Point2D;

import javax.swing.JComponent;
import javax.swing.JLabel;

/**
 * Created on: Feb 16, 2015 at 4:17:11 PM
 * Project: SFUDrawMap
 * File: NodeComponent.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class NodeComponent extends JLabel
{
	GraphNode represents;
	final static Color DEFAULT_COLOR = Color.ORANGE;
	Point2D pos;
	private PagePanel panel;
	final static int radius = 15;
 /**
	 * @param panel 
 * @param g
	 */
	public NodeComponent(PagePanel panel, GraphNode g)
	{
		// TODO Auto-generated constructor stub
		represents =g;
		this.panel=panel;
		pos = panel.relativeToPixelPosition(g.pos);
	}
/* (non-Javadoc)
 * @see javax.swing.JComponent#paint(java.awt.Graphics)
 */
@Override
public void paint(Graphics g)
{
	// TODO Auto-generated method stub
	//System.out.println("Will paint"+pos);
	super.paint(g);
	
	pos = panel.relativeToPixelPosition(represents.pos);
	this.setBounds((int)(pos.getX()-radius/2.0), (int)(pos.getY()-radius/2.0), (int)radius, (int)radius);
	
	g.setColor(DEFAULT_COLOR);
	
	int ctrX = (int)(pos.getX()-radius/2.0);
	int ctrY = (int)(pos.getY()-radius/2.0);
	
	g.fillOval(ctrX,ctrY , radius, radius);
	g.setColor(Color.red);
	System.out.println("=========");
	for(GraphNode gn : represents.getAdjacent())
	{
		Point2D p = panel.relativeToPixelPosition(gn.pos);
		
		int octrX = (int)(p.getX());
		int octrY = (int)(p.getY());
		System.out.println(represents.id+"-"+gn.id);
		g.drawLine( (int)(pos.getX()), (int)(pos.getY()), octrX, octrY);
	}
}


}
