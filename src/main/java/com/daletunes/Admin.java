/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daletunes;

import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author dmiller
 */
public class Admin {
    public DB.Result saveNewTrackFromWebsite(FileIO fileIO, DB.Track grab) {
        DB.Result result = new DB.Result();
        DB.Tracks tracks = fileIO.getTracks();
        DB.Track track = new DB.Track();
        System.out.println("TRACKS : " + tracks.data.size());
        Iterator it = tracks.data.entrySet().iterator();
        Map.Entry pair;
        String code = new String();
        while (it.hasNext()) {
            pair = (Map.Entry)it.next();
            track = (DB.Track)pair.getValue();
            code = track.code;
            if (code.equals(grab.code)) {
                result.result = false;
                result.msg = new String("ERROR: The video with code " + code + " already exists!!!");
                return result;
            }
        }
        //save
        result = fileIO.saveNewTrackFromWebsite(grab);

        //Need to check for client side errors.
        //check track doesnt already exist
        //send track to fileIO to save. Think about how to sort sort by default (add to end).        
        return result;        
    }    
}
