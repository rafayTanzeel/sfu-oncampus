import java.awt.Component;
import java.awt.EventQueue;

import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.Box;

import java.awt.BorderLayout;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JLayeredPane;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.filechooser.FileNameExtensionFilter;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JScrollPane;

/**
 * Created on: Feb 16, 2015 at 4:06:43 PM
 * Project: SFUDrawMap
 * File: SFUDrawMap.java
 */

/**
 *
 * @author Abram Wiebe (c) 2015
 *
 */
public class SFUDrawMap
{

	private JFrame frame;
	protected NavPage page = new NavPage();

	/**
	 * Launch the application.
	 */
	public static void main(String[] args)
	{
		EventQueue.invokeLater(new Runnable()
		{
			public void run()
			{
				try
				{
					SFUDrawMap window = new SFUDrawMap();
					window.frame.setVisible(true);
				}
				catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public SFUDrawMap()
	{
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize()
	{
		frame = new JFrame();
		frame.setBounds(100, 100, 450, 300);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		Box horizontalBox = Box.createHorizontalBox();
		frame.getContentPane().add(horizontalBox, BorderLayout.SOUTH);
		
		JButton btnPoint = new JButton("Point");
		btnPoint.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				
			}
		});
		horizontalBox.add(btnPoint);
		
		JButton btnEdge = new JButton("Edge");
		
		horizontalBox.add(btnEdge);
		
		JButton btnInspect = new JButton("Inspect");
		horizontalBox.add(btnInspect);
		
		JPanel panel = new JPanel();
		frame.getContentPane().add(panel, BorderLayout.CENTER);//JLayeredPane lp = new JLayeredPane();
		panel.setLayout(new BorderLayout(0, 0));
		
		JScrollPane scrollPane = new JScrollPane();
		panel.add(scrollPane, BorderLayout.CENTER);
		
		final PagePanel pc = new PagePanel();
		scrollPane.setViewportView(pc);
		pc.page=this.page;
		
		JButton btnSetBg = new JButton("Set Bg");
		btnSetBg.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				 JFileChooser chooser = new JFileChooser();
				    FileNameExtensionFilter filter = new FileNameExtensionFilter(
				        "JPG & GIF Images", "jpg", "gif");
				    chooser.setFileFilter(filter);
				    int returnVal = chooser.showOpenDialog((Component) e.getSource());
				    if(returnVal == JFileChooser.APPROVE_OPTION) {
				       System.out.println("You chose to open this file: " +
				            chooser.getSelectedFile().getName());
				       ImageIcon i = null;
					try
					{
						BufferedImage b = ImageIO.read(chooser.getSelectedFile());
						i= new ImageIcon(b);
					}
					catch (IOException e1)
					{
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
						page.setBackgroundImage(i);
						pc.invalidate();
						pc.repaint();
				    }
				
			}
		});
		horizontalBox.add(btnSetBg);
		
		final JButton btnToolRemove = new JButton("Remove");
		btnToolRemove.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				pc.toolRemove = !pc.toolRemove;
				
				if(pc.toolRemove)
				{
				btnToolRemove.setText("Add");
				}else
				{
					btnToolRemove.setText("Remove");	
				}
			}
		});
		horizontalBox.add(btnToolRemove);
		
		
		
		JMenuBar menuBar = new JMenuBar();
		frame.getContentPane().add(menuBar, BorderLayout.NORTH);
		
		JMenu mnFile = new JMenu("File");
		menuBar.add(mnFile);
		
		JMenuItem mntmOpen = new JMenuItem("Open");
		mnFile.add(mntmOpen);
		
		JMenuItem mntmSave = new JMenuItem("Save");
		mnFile.add(mntmSave);
		
		JMenuItem mntmExportXml = new JMenuItem("Export XML");
		mnFile.add(mntmExportXml);
		
		JMenuItem mntmExportDomain = new JMenuItem("Export Domain");
		mnFile.add(mntmExportDomain);
		
		JMenuItem mntmExportPage = new JMenuItem("Export Page");
		mntmExportPage.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				NavPage currentPage = pc.page;
				String path ="";
				JFileChooser c = new JFileChooser();
			      // Demonstrate "Save" dialog:
			      int rVal = c.showSaveDialog(frame);
			      if (rVal == JFileChooser.APPROVE_OPTION) {
			        path = c.getSelectedFile().getAbsolutePath();
			       // dir.setText(c.getCurrentDirectory().toString());
			      }
			      
				if(!path.endsWith(".SFUNavPage"))
				{
					path+=".SFUNavPage";
				}
				try
				{
					ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream (new File(path)));
					oos.writeObject(currentPage);
					oos.close();
				}
				catch (FileNotFoundException e1)
				{
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				catch (IOException e1)
				{
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
			}
		});
		mnFile.add(mntmExportPage);
		
		JMenuItem mntmImportdomain = new JMenuItem("Import Domain");
		mnFile.add(mntmImportdomain);
		
		JMenuItem mntmImportPage = new JMenuItem("Import Page");
		mntmImportPage.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				String path ="";
				JFileChooser c = new JFileChooser();
			      // Demonstrate "Save" dialog:
			      int rVal = c.showOpenDialog(frame);
			      if (rVal == JFileChooser.APPROVE_OPTION) {
			        path = c.getSelectedFile().getAbsolutePath();
			       // dir.setText(c.getCurrentDirectory().toString());
			        try
					{
						 FileInputStream fis = new FileInputStream(path);
					     ObjectInputStream ois = new ObjectInputStream(fis);
					     try
						{
							pc.page=(NavPage) ois.readObject();
						}
						catch (ClassNotFoundException e1)
						{
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
					}
					catch (FileNotFoundException e1)
					{
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					catch (IOException e1)
					{
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
			        
					frame.repaint();
			      }
			      
				
				
			}});
		mnFile.add(mntmImportPage);
		
		JMenu mnEdit = new JMenu("Edit");
		menuBar.add(mnEdit);
		
		JMenuItem mntmSelectPagedomain = new JMenuItem("Select Page/Domain");
		mnEdit.add(mntmSelectPagedomain);
		
		JMenuItem mntmMetaLabels = new JMenuItem("Meta Labels");
		mnEdit.add(mntmMetaLabels);
		
		btnEdge.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				pc.setToolMode(PagePanel.EDGE_TOOL);
			}
		});
		
		btnPoint.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				pc.setToolMode(PagePanel.POINT_TOOL);
			}
		});
		//lp.add(pc,0);
		
		//frame.getContentPane().add(pc, BorderLayout.CENTER);
		//loadGraph(lp);
		//this.frame.repaint();
	}

	/**
	 * @param lp
	 */
	private void loadGraph(JLayeredPane lp)
	{
		PagePanel pc = new PagePanel();
		lp.add(pc,0);
		this.frame.repaint();
		
	}
}
