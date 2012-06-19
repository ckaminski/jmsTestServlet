package com.darthcoder.JMSTestServlet;

import java.io.IOException;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NameClassPair;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.servlet.http.*; 

import com.sun.xml.rpc.processor.modeler.j2ee.xml.javaXmlTypeMappingType;

@SuppressWarnings("serial")
public class MainServlet extends HttpServlet {
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
					retVal.append(entry.getName()); 
				}
			}
			
		} catch (NamingException e) {
			e.printStackTrace();
		}

		return retVal.toString();
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
		} else { 
			
		}
	}
}
