/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daletunes;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author dmiller
 */
@WebServlet(name = "FileIO", urlPatterns = {"/FileIO"})
public class FileIO extends HttpServlet {
    //locked at a method level
    private List lockedFiles;
    private int totalTriesToGetFileLock = 50;
    private long waitPerTryForFileLock = 100;
    private int updateCount = 0;
    private final String strAdd = new String("a");
    private final String strRem = new String("r");
    //  Help File : /private-cgi-bin/tomcat/myApp
    //  JSP Check : /usr/local/tomcat/TomcatSandbox/Box
    //  FTP : /private-cgi-bin/tomcat
    //  TomcatDeploy : /cloud/2/big_milsy/home/
    //  /cust/metawerxdefault/home/private-cgi-bin/tomcat/ROOT
    //private final String DB_FOLDER = new String("C:\\dale\\apps\\daletunes\\database\\");
    public String DB_FOLDER;
    public String TRACKS_FILE;
    public FileIO() {
        String loc1 = new String("/cloud/2/big_milsy/home/database/");
        String loc2 = new String("C:\\dale\\apps\\daletunes\\database\\");
        lockedFiles = new ArrayList<String>();
        File file = new File(loc1);
        if (file.isDirectory()) {
            System.out.println(loc1);
            DB_FOLDER = new String(loc1);
        } else {
            DB_FOLDER = new String(loc2);            
            System.out.println(loc2);
        }
        TRACKS_FILE = new String(DB_FOLDER + "tracks.HM");
    }
    public DB.Result saveNewTrackFromWebsite(DB.Track data) {        
        DB.Result out = new DB.Result();
        String path = TRACKS_FILE;
        DB.Tracks tracks = new DB.Tracks();
        //lock
        if (getFileLock(path) == false) {
            System.out.println("ERROR: Could not get file lock! fileIO : " + path);
            out.result=false;out.msg=new String("ERROR: Could not get file lock! fileIO : " + path);
        } else {
            try {
                //check if file exists
                File fileCheck = new File(path);
                if (fileCheck.exists()) {
                    //get fresh
                    FileInputStream fis = new FileInputStream(path);
                    ObjectInputStream ois = new ObjectInputStream(fis);
                    tracks = (DB.Tracks) ois.readObject();
                    ois.close();                                    
                }               
                //add
                tracks.data.put(data.pk, data);
                //save
                FileOutputStream fos = new FileOutputStream(path);
                ObjectOutputStream oos = new ObjectOutputStream(fos);
                oos.writeObject(tracks);
                oos.close();
            } catch (IOException e) {
              System.out.println("FileIO.saveNewTrackFromWebsite( IOException : " + e.getMessage());
              out.result=false;out.msg=new String("FileIO.saveNewTrackFromWebsite( IOException : " + e.getMessage());
            } catch (Exception f) {
              System.out.println("FileIO.saveNewTrackFromWebsite(Exception : " + f.getMessage());
              out.result=false;out.msg=new String("FileIO.saveNewTrackFromWebsite(Exception : " + f.getMessage());
            }
            //unlock
            if (remFileLock(path) == false) {System.out.println("FileIO.saveNewTrackFromWebsite( ERROR: Could not remove file lock! fileIO : " + path);
                                             out.result=false;out.msg=new String("FileIO.saveNewTrackFromWebsite( ERROR: Could not remove file lock! fileIO : " + path);}                    
            
        }
        out.result = true;
        out.msg = new String("DONE: The track with ID " + data.code + " has been added!!");
        return out;
    }
    public DB.Result deleteTrack(String code) {
        DB.Result out = new DB.Result();
        String path = TRACKS_FILE;
        DB.Tracks tracks = new DB.Tracks();
        //lock
        if (getFileLock(path) == false) {
            System.out.println("ERROR: Could not get file lock! fileIO : " + path);
            out.result=false;out.msg=new String("ERROR: Could not get file lock! fileIO : " + path);
        } else {
            try {
                //check if file exists
                File fileCheck = new File(path);
                if (fileCheck.exists()) {
                    //get fresh
                    FileInputStream fis = new FileInputStream(path);
                    ObjectInputStream ois = new ObjectInputStream(fis);
                    tracks = (DB.Tracks) ois.readObject();
                    ois.close();                                    
                }
                //delete
                tracks.data.remove(code);
                //save
                FileOutputStream fos = new FileOutputStream(path);
                ObjectOutputStream oos = new ObjectOutputStream(fos);
                oos.writeObject(tracks);
                oos.close();
            } catch (IOException e) {
              System.out.println("FileIO.deleteTrack( IOException : " + e.getMessage());
              out.result=false;out.msg=new String("FileIO.deleteTrack( IOException : " + e.getMessage());
            } catch (Exception f) {
              System.out.println("FileIO.deleteTrack(Exception : " + f.getMessage());
              out.result=false;out.msg=new String("FileIO.deleteTrack(Exception : " + f.getMessage());
            }
            //unlock
            if (remFileLock(path) == false) {System.out.println("FileIO.deleteTrack( ERROR: Could not remove file lock! fileIO : " + path);
                                             out.result=false;out.msg=new String("FileIO.deleteTrack( ERROR: Could not remove file lock! fileIO : " + path);}                    
            
        }
        out.result = true;
        out.msg = new String("DONE: The track with ID " + code + " has been deleted!!");
        return out;
    }
    public DB.Result editTrack(DB.Track grab) {
        DB.Result out = new DB.Result();
        String path = TRACKS_FILE;
        DB.Tracks tracks = new DB.Tracks();
        DB.Track returnTrack = new DB.Track();
        //lock
        if (getFileLock(path) == false) {
            System.out.println("ERROR: Could not get file lock! fileIO : " + path);
            out.result=false;out.msg=new String("ERROR: Could not get file lock! fileIO : " + path);
        } else {
            try {
                //check if file exists
                File fileCheck = new File(path);
                if (fileCheck.exists()) {
                    //get fresh
                    FileInputStream fis = new FileInputStream(path);
                    ObjectInputStream ois = new ObjectInputStream(fis);
                    tracks = (DB.Tracks) ois.readObject();
                    ois.close();                                    
                }
                //check no duplicate code
                DB.Track trackHold = tracks.data.get(grab.pk);
                DB.Track tempTrack = new DB.Track();
                tracks.data.remove(grab.pk);
                Iterator it = tracks.data.entrySet().iterator();
                Map.Entry pair;
                String code = new String();
                while (it.hasNext()) {
                    pair = (Map.Entry)it.next();
                    tempTrack = (DB.Track)pair.getValue();
                    if (grab.code.equals(tempTrack.code)) {
                        out.result = false;
                        out.msg = new String("ERROR: The video with code " + code + " already exists!!!");
                        return out;
                    }
                }                
                //edit                
                trackHold.code = new String(grab.code);
                trackHold.playLength = grab.playLength;
                trackHold.startAt = grab.startAt;
                trackHold.title = new String(grab.title);
                //insert back
                tracks.data.put(trackHold.pk, trackHold);
                returnTrack = trackHold;
                //save
                FileOutputStream fos = new FileOutputStream(path);
                ObjectOutputStream oos = new ObjectOutputStream(fos);
                oos.writeObject(tracks);
                oos.close();
            } catch (IOException e) {
              System.out.println("FileIO.deleteTrack( IOException : " + e.getMessage());
              out.result=false;out.msg=new String("FileIO.deleteTrack( IOException : " + e.getMessage());
            } catch (Exception f) {
              System.out.println("FileIO.deleteTrack(Exception : " + f.getMessage());
              out.result=false;out.msg=new String("FileIO.deleteTrack(Exception : " + f.getMessage());
            }
            //unlock
            if (remFileLock(path) == false) {System.out.println("FileIO.deleteTrack( ERROR: Could not remove file lock! fileIO : " + path);
                                             out.result=false;out.msg=new String("FileIO.deleteTrack( ERROR: Could not remove file lock! fileIO : " + path);}                    
            
        }
        out.result = true;
        out.msg = new String("DONE: The track with ID " + grab.code + " has been edited!!");
        //NOTE: Unlocked so can call another locking method
        out.data = getTracks();
        return out;
    }    
    public DB.Tracks getTracks() {
        //System.out.println("-------:" + path);
        DB.Tracks out = new DB.Tracks();
        String path = TRACKS_FILE;
        //check if file exists
        File fileCheck = new File(path);
        if (!fileCheck.exists()) {return out;}
        //lock
        if (getFileLock(path) == false) {System.out.println("ERROR: Could not get file lock! fileIO : " + path);return out;}
        //use
        File file = new File(path);
        if (file.exists()) {
            try {
                FileInputStream fis = new FileInputStream(path);
                ObjectInputStream ois = new ObjectInputStream(fis);
                out = (DB.Tracks) ois.readObject();
                ois.close();                    
            } catch (IOException e) {
              System.out.println("FileIO.getTracks( IOException : " + e.getMessage());
            } catch (ClassNotFoundException f) {
              System.out.println("FileIO.getTracks( IOException : " + f.getMessage());
            }
        }
        //unlock
        if (remFileLock(path) == false) {System.out.println("ERROR: Could not remove file lock! fileIO : " + path);return out;}
        return out;        
    }
/****LOCKS******/
    private boolean getFileLock(String path) {
        boolean gotLock = false;
        try {
            for (int x = 0 ; x < this.totalTriesToGetFileLock ; x++) {
                if (useLockedFiles(strAdd, path)) {
                    x = this.totalTriesToGetFileLock;
                    gotLock = true;
                } else {
                    Thread.sleep(waitPerTryForFileLock);
                }
            }            
        } catch (InterruptedException e) {
            System.out.println("ERROR in FileIO : Sleep inturrupted! : " + e.getMessage());
        }
        return gotLock;
    }
    private boolean remFileLock(String path) {        
        return useLockedFiles(strRem, path);
    }
    //sync methods
    private synchronized boolean useLockedFiles(String type, String path) {
        //System.out.println("PATH : " + path);
            if (path.contains("\\\\")) {
                path = path.replace("\\\\", "\\");
            }
            if (type.equals("a")) {
                if (this.lockedFiles.contains(path)) {
                    return false;
                } else {
                    this.lockedFiles.add(path);
                    //System.out.println(updateCount + " : LOCKED: " + path);
                    //if (this.lockedFiles.size() > 1) {
                    //    System.out.println("**********WOW MORE THAN ONE!!!! : " + this.lockedFiles.size());
                    //}
                    return true;
                }            
            } else if (type.equals("r")) {
                //System.out.println(updateCount + " : UN-LOCKED: " + path);            
                return this.lockedFiles.remove(path);
            }
            return false;            
    }
}