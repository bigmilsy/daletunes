/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daletunes;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author dmiller
 */
public class DB {  
  public static class Track implements Serializable {
    public String pk;
    public String code;
    public String title;
    public int playLength;  //seconds
    public int startAt;
    public Track() {
        pk = new String();
        code = new String();
        title = new String();
        playLength = -1;
        startAt = -1;
    }
  }
  public static class Tracks implements Serializable {
      public HashMap<String, Track> data;
      public Tracks() {
          this.data = new HashMap<>();
      }
  }
  public static class TrackV2 implements Serializable {
    public String pk;
    public String code;
    public String title;
    public int playLength;  //seconds
    public int startAt;
    public TrackV2() {
        pk = new String();
        code = new String();
        title = new String();
        playLength = -1;
        startAt = -1;
    }
  }
  public static class TracksV2 implements Serializable {
      public HashMap<String, Track> data;
      public TracksV2(Tracks oldTracks) {
          this.data = new HashMap<>();
      }
  }
  public static class Result {
      public boolean result;
      public String msg;
      public Object data;
      public Result() {
          this.result = false;
          this.msg = new String();
          this.data = new Object();
      }
  }
}
