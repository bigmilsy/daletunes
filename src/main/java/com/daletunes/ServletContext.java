/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daletunes;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebListener;

/**
 *
 * @author dmiller
 * NOTE: This class is called before and after the container (tomcat) is loaded
 */
@WebListener
public class ServletContext implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        //ServletContext ctx = arg0.getServletContext();
        FileIO fileIO = new FileIO();
        event.getServletContext().setAttribute("fileIO", fileIO);
        System.out.println("---DaleTunes: FileIO loaded into memory");		

    }
    @Override
    public void contextDestroyed(ServletContextEvent event) {
        event.getServletContext().removeAttribute("fileIO");
        System.out.println("---DaleTunes: FileIO removed from memory");
    }
}