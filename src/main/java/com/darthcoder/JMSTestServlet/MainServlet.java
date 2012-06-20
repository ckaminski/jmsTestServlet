package com.darthcoder.JMSTestServlet;

import java.io.IOException;
import java.util.Properties;

import javax.jms.*;
import javax.naming.*;
import javax.servlet.http.*; 

//import com.sun.xml.rpc.processor.modeler.j2ee.xml.javaXmlTypeMappingType;

@SuppressWarnings("serial")
public class MainServlet extends HttpServlet {
	boolean stopFlag = false;
	
	private String getJMSNames() { 
		StringBuilder retVal = new StringBuilder();
		try {
			InitialContext ctx = new InitialContext();
			
			System.out.println("Retrieved initialContext..."); 
			
			NamingEnumeration ne = ctx.list("jms"); 
			if ( null != ne ) { 
				System.out.println("We have naming enumeration..."); 
				while ( ne.hasMore() ) { 
					NameClassPair entry = (NameClassPair)ne.next();
					System.out.println("name: " + entry.getName() + " class: " +  entry.getClassName());
					if ( retVal.length() > 0 ) retVal.append(";");
					retVal.append("jms/" + entry.getName()); 
				}
			}
			
		} catch (NamingException e) {
			e.printStackTrace();
		}

		return retVal.toString();
	} 

	// TODO: Add authentication capabilities.
	void runMessageListener(HttpServletRequest request, HttpServletResponse response) { 
		System.out.println("Starting runMessageListener");  
		
		String connFactoryName = request.getParameter("ConnFactoryName"); 
		String replyToName     = request.getParameter("ReplyToName");
		String replyToType     = request.getParameter("ReplyToType");
		InitialContext ctx = null;
		
		assert(connFactoryName != null) : "ConnectionFactoryName is null"; 
		assert(replyToName != null) : "ReplyTo destination is null!"; 
		
		try {
			ctx = new InitialContext();
			ConnectionFactory cfactory = (ConnectionFactory) ctx.lookup(connFactoryName); 
			Queue  queue = (Queue) ctx.lookup (replyToName); 
			
			if ( null == cfactory ) System.out.println("no connection factory!");
			if ( null == queue ) System.out.println("no queue!");
			Connection conn = cfactory.createConnection(); 
			Session msgSession = conn.createSession(false, Session.AUTO_ACKNOWLEDGE);
			MessageConsumer consumer  = msgSession.createConsumer(queue); 
			
			conn.start(); 
			while ( !stopFlag ) { 
				// TODO: wait on exit flag 
				// TODO: make this a user-specifiable parameter. 
				Message msg = consumer.receive(1000); 
			}
			conn.stop(); 
			
			msgSession.close();
			conn.close();
			ctx.close();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally { 
	
		}
	} 
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) { 
		String action = request.getParameter("action"); 
		if ( action.equals("jmsdata") ) { 
			String jmsdata = getJMSNames(); 
			response.setContentType("text/text"); 
			try {
				response.getWriter().write(jmsdata);
			} catch (IOException e) {
				e.printStackTrace();
			} 
		} else if (action.equals("jmsmessages") ) { 
			runMessageListener(request, response);
		} else { 
			
		}
	}
}
