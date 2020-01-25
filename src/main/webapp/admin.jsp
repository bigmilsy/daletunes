<%-- 
    Document   : admin
    Created on : 28/10/2018, 3:07:58 PM
    Author     : dmiller
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DaleTunes.com: Admin Page</title>
    </head>
    <body>
<table cellpadding="0" cellspacing="0" style="font-size:12pt">
    <tr><td align="center"><a href="#" onclick="showSearch()">SEARCH</a>&nbsp;&nbsp;<a href="#" onclick="showVideos()">VIDEOS</a></td></tr>
<tr><td align="left"><tr><h1>DaleTunes : Admin Page</h1></tr>
<tr><h3 id="alertText">WARNING: Authorized Users Only</h3></tr></td></tr>
<tr><td align="left" id="topRow"></td></tr>
<tr><td align="left" id="txtResults">----</td></tr>
</table>
<form action="adminAJAX.jsp" method="post" id="form1" target="">
<input id="command" name="command" type="hidden" value="" />  
<input id="title" name="title" type="hidden" value="" />  
<input id="code" name="code" type="hidden" value="" />  
<input id="mins" name="mins" type="hidden" value="" />  
<input id="secs" name="secs" type="hidden" value="" />  
<input id="startAt" name="startAt" type="hidden" value="" />  
<div id="form1R" style=""><!-- For server results --></div>
</form>
<script type="text/javascript">
var glbTracks;
var glbKeys;
function checkAndAddNew() {

  $("#form1").submit(function(event){
    event.preventDefault(); //prevent default action 
    var post_url = $(this).attr("action"); //get form action url
    var form_data = $(this).serialize(); //Encode form elements for submission	
    $.post( post_url, form_data, function( response ) {
      $("#form1R").html( response );
    });
  });
  //document.getElementById("form1").submit();
  $('form#form1').submit();
}
function search01() {
    var qry = document.getElementById('txtSearch').value;
    if (qry.length <= 1) {
        alert('Please use more than 1 character');
        return;
    }
    var url = "http://www.whateverorigin.org/get?url=http://www.youtube.com/results?search_query=" + qry + "&callback=?";
    document.getElementById('btnGo').disabled = true;
    document.getElementById('btnGo').value = 'SEARCHING...';
    $.getJSON('http://www.whateverorigin.org/get?url=' + encodeURIComponent('https://www.youtube.com/results?search_query=' + qry) + '&callback=?', function(data){
        search02(data.contents);
        
//        console.log();
    });
}
var vidIds = new Array();
var vidTitles = new Array();
var vidTimes = new Array();    
function search02(htmlOutput) {
//<div class="yt-lockup-content"><h3 class="yt-lockup-title "><a href="/watch?v=_CL6n0FJZpk" class="yt-uix-tile-link yt-ui-ellipsis yt-ui-ellipsis-2 yt-uix-sessionlink      spf-link " data-sessionlink="itct=CG4Q3DAYACITCLPbhb-nqN4CFYfJwQodII4BKFIGZHIrZHJl"  title="Dr. Dre - Still D.R.E. ft. Snoop Dogg" rel="spf-prefetch" aria-describedby="description-id-3930" dir="ltr">Dr. Dre - Still D.R.E. ft. Snoop Dogg</a><span class="accessible-description" id="description-id-3930"> - Duration: 4:52.</span></h3><div class="yt-lockup-byline "><a href="/user/DrDreVEVO" class="yt-uix-sessionlink       spf-link " data-sessionlink="itct=CG4Q3DAYACITCLPbhb-nqN4CFYfJwQodII4BKA" >DrDreVEVO</a>&nbsp;<span title="Verified" class="yt-uix-tooltip yt-channel-title-icon-verified yt-sprite"></span></div>    

//5wBTdfAkqGU&amp;start_radio=1\" class=\"yt-uix-tile-link yt-ui-ellipsis yt-ui-ellipsis-2 yt-uix-sessionlink      spf-link \" data-sessionlink=\"itct=CEYQuzcYAyITCOKM38SA698CFTDRwQodueUKQCj0JDIGc2VhcmNo\"  title=\"Mix - 2pac feat Dr.Dre - California Love HD\" aria-describedby=\"description-id-602671\" dir=\"ltr\">Mix - 2pac feat Dr.Dre - California Love HD</a><span class=\"

//  (/(?<=**left**).*?(?=**right**)/gs);
//  special chars [ \ ^ $ . | ? * + ( )
    var count = 0;
    var tempStr = '';
    var vidDivs = htmlOutput.match((/(?<=<div class="yt-lockup-content">).*?(?=<\/div>)/gs));
    $.each(vidDivs, function(x, el){
      //alert(vidDivs[x]);
      //qualified-channel-title-badge
      if (vidDivs[x] == null) {
          //skip
      } else {
        tempStr = vidDivs[x].toString();
        //alert(tempStr);
        if (tempStr.includes("qualified-channel-title-badge")) {
          //dont add  
        } else {          
          vidIds[count] = vidDivs[x].match(/(?<=watch\?v=).*?(?=")/gs);
          //alert(vidIds[count]);
          if (vidIds[count] == null) {
              //skip
          } else {
            tempStr = vidIds[count].toString();
            if (tempStr.includes("list")) {
                //dont add
            } else {
              //vidTitles[count] = vidDivs[x].match(/(?<=dir="ltr">).*?(?=<)/gs);  
              vidTitles[count] = vidDivs[x].match(/(?<=span aria-label=\").*?(?= by)/gs);  
              //  (/(?<=**left**).*?(?=**right**)/gs);
                        //              span aria-label=\"          
              tempStr = vidTitles[count].toString();
              //alert(vidTitles[count]);
              if (tempStr.startsWith("Mix -")) {
                  //dont add
              } else {
                vidTimes[count] = vidDivs[x].match(/(?<= - Duration: ).*?(?=\.<)/gs);              
                count++;
              }
            }                                  
          }

        }          
      }
    });

/*    
    var vidIds = htmlOutput.match(/(?<=data-video-ids=").*?(?=")/gs);
    var hold = new Array();
    $.each(vidIds, function(i, el){
        if($.inArray(el, hold) === -1) hold.push(el);
    });
    vidIds = hold;

    //<span class="video-time" aria-hidden="true">7:37</span>
    var vidTimes = htmlOutput.match((/(?<=<span class="video-time" aria-hidden="true">).*?(?=<)/gs));
    hold = new Array();
    $.each(vidTimes, function(i, el){
        if($.inArray(el, hold) === -1) hold.push(el);
    });
    vidTimes = hold;    
    
    //dir="ltr">Dr. Dre - I Need A Doctor (Explicit) ft. Eminem, Skylar Grey</a><span class="accessible-description


    var vidTitles = htmlOutput.match((/(?<=<div class="yt-lockup-content">).*?(?=<\/div>)/gs));
    hold = new Array();
    $.each(vidTitles, function(i, el){
        if($.inArray(el, hold) === -1) hold.push(el);
    });
    vidTitles = hold;    

    //do again as in pieces
    //dir="ltr">Dr. Dre - I Need A Doctor (Explicit) ft. Eminem, Skylar Grey</a>    
    var vidTitles2 = new Array();
    $.each(vidTitles, function(i, el){
      vidTitles2[i] = vidTitles[i].match(/(?<=dir="ltr">).*?(?=<)/gs);    
    });
    vidTitles = vidTitles2;*/
    var flipBack = false;
    var tdBackColor = '';
    var minSec = new Array();
    var htmlOut = '<table cellpadding="4" cellspacing="1" style="font-size:12pt">';
    var tempStr = '';
    for (x = 0 ; x < vidIds.length ; x++) {
        tempStr = vidTimes[x].toString();
        minSec[0] = tempStr.split(':')[0];
        minSec[1] = tempStr.split(':')[1];
//htmlOut = htmlOut + vidIds[x] + " - " + vidTimes[x] + " - " + vidTitles[x] + " <a href='https://www.youtube.com/watch?v=" + vidIds[x] + "' target='_blank'>click</a><br>";
        //htmlOut = htmlOut + vidIds[x] + " - " + vidTimes[x] + " - " + vidTitles[x] + " <a href='https://www.youtube.com/watch?v=" + vidIds[x] + "' target='_blank'>click</a><br>";
        if (flipBack) {tdBackColor = '#CCCCCC';flipBack=false;} else {tdBackColor = '#DDDDDD';flipBack=true;        }
        htmlOut = htmlOut + '<tr><td align="right" style="background-color:' + tdBackColor + ';">Title:<input type="text" style="width:400px" id="txtTitle_' + x + '" value="' + vidTitles[x] + '" /><br />PLAY LENGTH: <input type="text" style="width:20px" id="txtMins_' + x + '" value="' + minSec[0] + '" />Mins&nbsp;&nbsp;<input type="text" style="width:20px" id="txtSecs_' + x + '" value="' + minSec[1] + '" />Secs&nbsp;&nbsp;<a href="https://www.youtube.com/watch?v=' + vidIds[x] + '" target="_blank">VIEW</a><br />Code: <input type="text" style="width:130px" id="txtCode_' + x + '" value="' + vidIds[x] + '" />&nbsp;StartAt&nbsp;<input type="text" style="width:30px" id="txtStartAt_' + x + '" value="0" />secs&nbsp;&nbsp;<input type="button" value="ADD >" onclick="checkAndAdd(' + x + ')" id="btnAdd_' + x + '" /></td></tr>';
        
    }
    htmlOut = htmlOut + '</table>';
    document.getElementById('txtResults').innerHTML = htmlOut;
    document.getElementById('btnGo').disabled = false;
    document.getElementById('btnGo').value = 'SEARCH >';
}
function showSearch() {
    //
    document.getElementById('topRow').innerHTML = '<input type="text" id="txtSearch" style="width:400px" value="" />&nbsp;&nbsp;<input type="button" value="SEARCH" onclick="search01()" id="btnGo" />';
    $("#txtSearch").on('keyup', function (e) {
      if (e.keyCode == 13) {
        search01();
      }
    });
    document.getElementById('txtResults').innerHTML = '';
}
function showVideos() {
  $.post( "adminAJAX.jsp", { command: "getTracks"})
    .done(function( data ) {
      var json = JSON.parse(data);
      glbTracks = json.data.data;
      if (json.result == false) {
          alertError(json.msg);
          return;
      }
      var htmlOut = '<table border="1" cellpadding="4" cellspacing="1" style="font-size:12pt;background-color:white;border: 1 solid #000">';
      htmlOut = htmlOut + '<tr>';
      htmlOut = htmlOut + '<td align="center" style="font-weight:bold">EDIT</td><td align="center" style="font-weight:bold">CODE</td><td align="center" style="font-weight:bold">TITLE</td><td align="center" style="font-weight:bold">LENGTH</td><td align="center" style="font-weight:bold">START AT</td><td align="center" style="font-weight:bold">DELETE</td></tr>';
      var keys = Object.keys(json.data.data);
      glbKeys = keys;
      for (x = 0 ; x < keys.length ; x++) {
        htmlOut = htmlOut + '<tr><td align="center" id="td1' + keys[x] + '"><input type="button" value="EDIT" onclick="editTrack(\'' + keys[x] + '\')" /></td><td align="center" id="td2' + keys[x] + '">' + json.data.data[keys[x]].code + '</td><td align="center" id="td3' + keys[x] + '">' +json.data.data[keys[x]].title + '</td><td align="center" id="td4' + keys[x] + '">' + toMinsSecs(json.data.data[keys[x]].playLength) + '</td><td align="center" id="td5' + keys[x] + '">' + toMinsSecs(json.data.data[keys[x]].startAt) + '</td><td align="center" id="td6' + keys[x] + '"><input type="button" value="DELETE" onclick="deleteTrack(\'' + keys[x] + '\')" /></td></tr>';
      }
      htmlOut = htmlOut + '</tr>';
      htmlOut = htmlOut + '</table>';
      document.getElementById('topRow').innerHTML = htmlOut;
      document.getElementById('txtResults').innerHTML = '';  
  });  
}
function toMinsSecs(secs) {
    var minutes = Math.floor(secs / 60);
    var seconds = secs - minutes * 60;
    return minutes + "m : " + seconds + "s";
}
function toMins(secs) {
    var minutes = Math.floor(secs / 60);
    return minutes;
}
function toSecs(secs) {
    var minutes = Math.floor(secs / 60);
    var seconds = secs - minutes * 60;
    return seconds;
}
function viewNewVid() {
    var code = document.getElementById('txtCode').value;
    document.getElementById('lnkView').href = 'https://www.youtube.com/watch?v=' + code;
    document.getElementById('lnkView').click();
}
function checkAndAdd(indexValue) {

    /*<input id="command" name="command" type="hidden" value="" />  
<input id="title" name="title" type="hidden" value="" />  
<input id="code" name="code" type="hidden" value="" />  
<input id="mins" name="mins" type="hidden" value="" />  
<input id="secs" name="secs" type="hidden" value="" />  
<input id="startAt" name="startAt" type="hidden" value="" />      */
  document.getElementById('command').value = 'addTrackFromSearch';
  document.getElementById('title').value = document.getElementById('txtTitle_' + indexValue).value;
  document.getElementById('code').value = vidIds[indexValue].toString();  
  document.getElementById('mins').value = document.getElementById('txtMins_' + indexValue).value;          
  document.getElementById('secs').value = document.getElementById('txtSecs_' + indexValue).value;                  
  document.getElementById('startAt').value = document.getElementById('txtStartAt_' + indexValue).value;                  

  $.post( "adminAJAX.jsp", { command: "addTrackFromSearch", title: document.getElementById('txtTitle_' + indexValue).value,
                             code: document.getElementById('txtCode_' + indexValue).value,
                             mins: document.getElementById('txtMins_' + indexValue).value,
                             secs: document.getElementById('txtSecs_' + indexValue).value,
                             startAt: document.getElementById('txtStartAt_' + indexValue).value})
    .done(function( data ) {
      var json = JSON.parse(data);
      if (json.result == false) {
          alertError(json.msg);
      } else {
          alertOk(json.msg);
      }
  });  
}
function alertError(msg) {
  $('#alertText').text(msg);
  $('#alertText').css("color","red");
}
function alertOk(msg) {
  $('#alertText').text(msg);
  $('#alertText').css("color","green");
}
function deleteTrack(id) {
  $.post( "adminAJAX.jsp", { command: "deleteTrack", code: id})
    .done(function( data ) {
      var json = JSON.parse(data);
      if (json.result == false) {
          alertError(json.msg);
      } else {
          alertOk(json.msg);
          showVideos();
      }
  });  
}
function editTrack(pk) {  
  document.getElementById('td1' + pk).style.backgroundColor = '#DCDCDC';
  document.getElementById('td1' + pk).innerHTML = '<input type="button" value="SAVE" onclick="editTrack2(\'' + pk + '\')" />';
  document.getElementById('td2' + pk).style.backgroundColor = '#DCDCDC';
  document.getElementById('td2' + pk).innerHTML = '<input type="text" id="txtCode'+ pk + '" value="' + glbTracks[pk].code + '" style="width:100px" />';
  document.getElementById('td3' + pk).style.backgroundColor = '#DCDCDC';
  document.getElementById('td3' + pk).innerHTML = '<input type="text" id="txtTitle'+ pk + '" value="' + glbTracks[pk].title + '" style="width:450px" />';
  document.getElementById('td4' + pk).style.backgroundColor = '#DCDCDC';
  document.getElementById('td4' + pk).innerHTML = '<input type="text" id="txtMinsPL'+ pk + '" value="' + toMins(glbTracks[pk].playLength) + '" style="width:20px" />m&nbsp;<input type="text" id="txtSecsPL'+ pk + '" value="' + toSecs(glbTracks[pk].playLength) + '" style="width:20px" />s';        
  document.getElementById('td5' + pk).style.backgroundColor = '#DCDCDC';
  document.getElementById('td5' + pk).innerHTML = '<input type="text" id="txtMinsSA'+ pk + '" value="' + toMins(glbTracks[pk].startAt) + '" style="width:20px" />m&nbsp;<input type="text" id="txtSecsSA'+ pk + '" value="' + toSecs(glbTracks[pk].startAt) + '" style="width:20px" />s';
  document.getElementById('td6' + pk).style.backgroundColor = '#DCDCDC';  
  document.getElementById('td6' + pk).innerHTML = '<input type="button" value="RESET" onclick="resetTrack(\'' + pk + '\')" />';
}
function editTrack2(pk) {
  $.post( "adminAJAX.jsp", {command: "editTrack", key: pk,
                             title: document.getElementById('txtTitle'+ pk).value,
                             code: document.getElementById('txtCode' + pk).value,
                             minsPL: document.getElementById('txtMinsPL' + pk).value,
                             secsPL: document.getElementById('txtSecsPL' + pk).value,
                             minsSA: document.getElementById('txtMinsSA' + pk).value,
                             secsSA: document.getElementById('txtSecsSA' + pk).value})
    .done(function( data ) {
      var json = JSON.parse(data);
      if (json.result == false) {
          alertError(json.msg);
      } else {
          glbTracks = json.data.data;
          glbKeys = Object.keys(json.data.data);
          resetTrack(pk);
          alertOk(json.msg);
      }
  });      
} 
function resetTrack(pk) {
  document.getElementById('td1' + pk).style.backgroundColor = '#FFFFFF';
  document.getElementById('td1' + pk).innerHTML = '<input type="button" value="EDIT" onclick="editTrack(\'' + pk + '\')" />';
  document.getElementById('td2' + pk).style.backgroundColor = '#FFFFFF';
  document.getElementById('td2' + pk).innerHTML = glbTracks[pk].code;
  document.getElementById('td3' + pk).style.backgroundColor = '#FFFFFF';
  document.getElementById('td3' + pk).innerHTML = glbTracks[pk].title;
  document.getElementById('td4' + pk).style.backgroundColor = '#FFFFFF';
  document.getElementById('td4' + pk).innerHTML = toMinsSecs(glbTracks[pk].playLength);        
  document.getElementById('td5' + pk).style.backgroundColor = '#FFFFFF';
  document.getElementById('td5' + pk).innerHTML = toMinsSecs(glbTracks[pk].startAt);;
  document.getElementById('td6' + pk).style.backgroundColor = '#FFFFFF';  
  document.getElementById('td6' + pk).innerHTML = '<input type="button" value="DELETE" onclick="deleteTrack(\'' + pk + '\')" />';    
}
window.onload = function() {
  $("#txtSearch").on('keyup', function (e) {
    if (e.keyCode == 13) {
      search01();
    }
  });
}
</script>    
</body>
</html>
