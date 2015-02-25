import java.awt.Component;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.geom.Point2D;

import javax.swing.DebugGraphics;
import javax.swing.JComponent;
import javax.swing.JLayeredPane;
import javax.swing.JPanel;

/**
 * Created on: Feb 16, 2015 at 4:21:55 PM
 * Project: SFUDrawMap
 * File: PageComponent.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class PagePanel extends JLayeredPane
{
	protected static final int EDGE_TOOL = 1;
	protected static final int POINT_TOOL = 0;
	PagePanel panel;
	NavPage page;
	private int tool;
	protected NodeComponent nodeA;
	protected boolean toolRemove;
	PagePanel()
	{
		panel = this;
		page = new NavPage();
		this.addMouseListener(new MouseAdapter()
		{
		
			/* (non-Javadoc)
			 * @see java.awt.event.MouseAdapter#mouseReleased(java.awt.event.MouseEvent)
			 */
			@Override
			public void mouseReleased(MouseEvent e)
			{
				super.mouseReleased(e);
				Component mousedOver= panel.getComponentAt(e.getPoint());
				switch(tool)
				{
				case EDGE_TOOL:
				
				if(mousedOver instanceof NodeComponent)
				{
					NodeComponent nc = (NodeComponent)mousedOver;
					if(nodeA == null)
					{
						nodeA = nc ;
					}
					else
					{
						if(toolRemove)
						{
							page.removeEdge(nodeA.represents,nc.represents);
						}
						else
						{
							if(nodeA != nc)
							page.addEdge(nodeA.represents,nc.represents);
						}
						nodeA = null;
						repaint();
					}
					System.out.println("From Page"+nc);
				}else
				{
					System.out.println(mousedOver);
				}
				break;
		
				default:
				System.out.print(e.getPoint());
				double xRel = e.getPoint().getX() / page.i.getIconWidth();
				double yRel = e.getPoint().getY() / page.i.getIconHeight();
				System.out.println(" ("+xRel+","+yRel+")");
				if(toolRemove)
				{
					if(mousedOver instanceof NodeComponent)
					{
						panel.remove(mousedOver);
						page.removeNode(((NodeComponent) mousedOver).represents.id);
					}
				}else
				{
					GraphNode g = page.addPoint(xRel,yRel);
					final NodeComponent nc = new NodeComponent(panel,g);
					
					panel.add(nc,1);
					nc.setDebugGraphicsOptions(DebugGraphics.FLASH_OPTION);
					
					//nc.validate();
				}
				
				panel.repaint();
				}
				
			}
			
		});
	}
	

	/* (non-Javadoc)
	 * @see javax.swing.JComponent#paint(java.awt.Graphics)
	 */
	@Override
	public void paint(Graphics g)
	{
		
		// TODO Auto-generated method stub
		super.paint(g);
		if(page == null)
		{
			g.drawString("Doc not open",10, 60);
			System.out.println("no doc img");
			return;
		}
		else if(page.i != null)
		{
		g.drawImage(page.i.getImage(), 0, 0, this);
		
		}
		else
		{
			
		}
		for(Component c : this.getComponents())
		{
			c.paint(g);
		}
		
	}
	public Dimension getPreferredSize() {
        if (page.i == null) {
            return new Dimension(320, 480);
        } else {
        	return new Dimension(page.i.getIconWidth(), page.i.getIconHeight());
        }
    }
	/**
	 * @param pos
	 * @return
	 */
	public Point2D relativeToPixelPosition(Point2D pos)
	{
		long x = Math.round(page.i.getIconWidth()*pos.getX());
		long y = Math.round(page.i.getIconHeight()*pos.getY());
		return new Point2D.Double(x, y);
	}


	/**
	 * @param edgeTool
	 */
	public void setToolMode(int tool)
	{
		this.tool = tool;
		
	}
}
