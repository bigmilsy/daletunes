/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.daletunes;

import com.google.gson.Gson;
/**
 *
 * @author dmiller
 */
public class Library {
    public static String buildJSONResponse(DB.Result result) {
/*
{"result":false,
 "msg":"ERROR: The video with key _CL6n0FJZpk already exists!!!",
 "data":{}}
*/
        Gson gson = new Gson();
        return gson.toJson(result);        
    }
}
