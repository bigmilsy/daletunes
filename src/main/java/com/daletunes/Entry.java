/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daletunes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daletunes.Admin;

/**
 *
 * @author dmiller
 */
public class Entry {
    //  Help File : /private-cgi-bin/tomcat/myApp
    //  JSP Check : /usr/local/tomcat/TomcatSandbox/Box
    //  FTP : /private-cgi-bin/tomcat
    public String addTrack(HashMap<String, String> pars, ServletRequest req) {
        DB.Track track = new DB.Track();
        //do command check
        track.pk = new String(String.valueOf(System.currentTimeMillis()));
        track.code = pars.get("code");
        track.title = pars.get("title");
        track.code = pars.get("code");
        int mins = Integer.parseInt(pars.get("mins"));
        int secs = Integer.parseInt(pars.get("secs"));
        track.playLength = (mins * 60) + secs;
        track.startAt = Integer.parseInt(pars.get("startAt"));

        //STUB
        //System.out.println("Youtube Code: " + track.code);
        //System.out.println("Title: " + track.title);
        //System.out.println("Code: " + track.code);
        //System.out.println("PlayLength: " + track.playLength);
        //System.out.println("startAt: " + track.startAt);
        
        FileIO fileIO = (FileIO)req.getServletContext().getAttribute("fileIO");
        Admin admin = new Admin();
        DB.Result result = admin.saveNewTrackFromWebsite(fileIO, track);        
        String json = Library.buildJSONResponse(result);
        return json;
    }
    public String getTracks(HashMap<String, String> pars, ServletRequest req) {
        FileIO fileIO = (FileIO)req.getServletContext().getAttribute("fileIO");
        DB.Tracks tracks = fileIO.getTracks();
        DB.Result result = new DB.Result();
        result.result = true;
        result.msg = new String("ok");
        result.data = tracks;
        String json = Library.buildJSONResponse(result);
        return json;
        
    }
    public DB.Tracks getTracks(ServletRequest req) {
        FileIO fileIO = (FileIO)req.getServletContext().getAttribute("fileIO");
        DB.Tracks tracks = fileIO.getTracks();
        return tracks;
        
    }
    public String deleteTrack(HashMap<String, String> pars, ServletRequest req) {
        FileIO fileIO = (FileIO)req.getServletContext().getAttribute("fileIO");

        DB.Result result = fileIO.deleteTrack(pars.get("code"));
        String json = Library.buildJSONResponse(result);
        return json;
        
    }
    public String editTrack(HashMap<String, String> pars, ServletRequest req) {
        DB.Track track = new DB.Track();
        //do command check
        track.pk = pars.get("key");;
        track.code = pars.get("code");
        track.title = pars.get("title");
        track.code = pars.get("code");
        int mins = Integer.parseInt(pars.get("minsPL"));
        int secs = Integer.parseInt(pars.get("secsPL"));
        //track.mins = pars.get("title");
        //track.secs = pars.get("title");
        track.playLength = (mins * 60) + secs;
        mins = Integer.parseInt(pars.get("minsSA"));
        secs = Integer.parseInt(pars.get("secsSA"));
        track.startAt = (mins * 60) + secs;                
        
        FileIO fileIO = (FileIO)req.getServletContext().getAttribute("fileIO");
        DB.Result result = fileIO.editTrack(track);
        String json = Library.buildJSONResponse(result);
        return json;
        
    }
}
