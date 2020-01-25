<%-- 
    Document   : index
    Created on : 03/06/2019, 2:48:05 PM
    Author     : dmiller
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.daletunes.Entry"%>
<%@page import="com.daletunes.DB"%>
<%
Entry entry = new Entry();
DB.Tracks tracks = entry.getTracks(request);
%>
<!DOCTYPE html>
<html>
    <head>
<title>DaleTunes.com : Simple Streaming Music Video</title>
<meta name="description" content="Your fav music videos at DaleTunes.com!">
<meta name="keywords" content="rap, music, tunes, aussie, free, channel, mp3, mp4">
<meta name="author" content="Mr Dale A Miller">
<meta charset="UTF-8">
<meta name="viewport" content="width=320, initial-scale=1.0">
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='pragma' content='no-cache'>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script src="js/mediaelement/mediaelement-and-player.min.js"></script>
<link rel="stylesheet" href="js/mediaelement/mediaelementplayer.css" />        
<link rel="icon" type="image/png" href="images/favicon.png" />
<meta property="og:url" content="http://daletunes.com/index.html" />
<meta property="og:title" content="DaleTunes.com - Music Videos" />
<meta property="og:image" content="http://daletunes.com/images/f.jpg" />
    </head>
    <body style="margin:0;padding:0;background-color: black" onresize="resize()">


<!--START FullScreenPanel-->
<div style="height:100vh;background-color: black; position:relative;" id="backgroundScreen">
<!--START Video Player-->
<div style="z-index:1;background-color: black; width:100%;position:absolute;top:0px;bottom:0px;left:0px" id="innerEmbed" ><video id="player1"><source type="video/youtube" src="https://www.youtube.com/watch?v=W9nZ6u15yis" /></video></div>
<!--END Video Player-->
<!--START Control Panel-->
<div style="z-index:8;width:100%;height:100%;position:absolute;top:0px;left:0px;background-color:transparent;opacity:0" id="controlPanel" onmousedown="resetControlFadeOut();">
<!--START Controls-->
<div style="z-index:8;background-color: #8A0000;position:absolute;top:0px;left:0;height:54px;width:100%">
<table cellpadding="0" cellspacing="0" width="100%" style="font-size:12pt;color:white">
<td align="left"><a href="javascript:{}" style="color:white" onmouseover="btnUp('btnMenu');" onmouseout="btnNormal('btnMenu');" onmousedown="" onmouseup="btnUp('btnMenu');"><img src="images/buttons/btnMenu_n.jpg" border="0" width="54" height="54" id="btnMenu"></a></td>
<td align="center" style="color:white"><a href="javascript:{}" style="color:white" onmouseover="btnUp('btnRefr');" onmouseout="btnNormal('btnRefr');" onmousedown="btnDown('btnRefr');refreshVid();" onmouseup="btnUp('btnRefr');"><img src="images/buttons/btnRefr_n.jpg" border="0" id="btnRefr" width="60" height="54"></a></td>
<td align="center" style="color:white"><a href="javascript:{}" style="color:white"  onmousedown="toggleRnd();"><img src="images/buttons/btnRnd_off.jpg" border="0" id="btnRnd"></a></td>
<td align="center" style="color:white"><a href="javascript:{}" style="color:white" onmousedown="toggleMax();"><img src="images/buttons/btnMax_off.jpg" border="0" id="btnMax"></a></td>
<td align="right" style="color:white"><a href="javascript:{}" style="color:white" onmouseover="btnUp('btnProf');" onmouseout="btnNormal('btnProf');" onmousedown="" onmouseup="btnUp('btnProf');"><img src="images/buttons/btnProf_n.jpg" border="0" id="btnProf" width="54" height="54"></a></td></table>
</div>
<!--END Controls-->
<!--START Header Title-->
<div style="z-index:8;background-color: #500200; width:100%;position:absolute;top:54px;left:0px;height:40px;font-size:18pt;color:white;text-align:center;vertical-align:middle;line-height:40px;white-space: nowrap; cursor: pointer" id="innerOne_word" onclick="openCloseTrackListing();">OZRAP</div>
<!--END Header Title-->
<!--START Big Controls-->
<div style="z-index:8;background-color: transparent;position:relative;top:94px;left:0;height:100%;width:100%">
<!--START Over Player Controls-->
<div style="z-index:8;background-color: transparent; width:100%;height:calc(100% - 164px);position:absolute;top:0px;bottom:0px;left:0px" id="overPlayerControls" >
    <table cellpadding="0" cellspacing="0" width="100%" style="font-size:12pt;color:white;width:100%;height:100%">
        <td width="35%" height="100%" style="text-align:center;vertical-align:middle;width:35%;height:100%;cursor: pointer;" onclick="prev('btnPrev');" id="btnPrev"><img src="images/buttons/btnBack_seeThru.png" style="border:0;height:120px" id="backBtn" /></td>
        <td width="30%" height="100%" style="text-align:center;vertical-align:middle;width:30%;height:100%;cursor: pointer;" onclick="playPause('btnPlayPause');"><img src="images/buttons/btnPause_seeThru.png" style="border:0;height:120px" id="playPauseBtn"/></td>
        <td width="35%" height="100%" style="text-align:center;vertical-align:middle;width:35%;height:100%;cursor: pointer;" onclick="next('btnNext');" id="btnNext"><img src="images/buttons/btnNext_seeThru.png" style="border:0;height:120px" id="nextBtn" /></td>
    </table>
    </div>
<!--END Over Player Controls-->
<!--START Track Listing-->
<div style="z-index:8;background-color: transparent;position:absolute;top:-3000px;left:0;height:calc(100% - 124px);width:100%;font-size:24pt" id="divTrackListing">
<div style="background-color: transparent;position:absolute;top:0;left:0;height:100%;width:100%;font-size:24pt;overflow-y: auto;color:white" id="divTrackListingInner">
<table cellpadding="0" cellspacing="0" width="100%" style="color:black;width:100%;font-family:monospace;font-size:18pt;">
<td width="100%" height="40px" style="text-align:left;vertical-align:middle;width:100%;height:40px;cursor: pointer;background-color:white" onclick="skipToTrack(3)" id="trackSelect_1">1 : Coolio - Gangsta's Paradise (feat. L.V.)</td>
</table>        
</div>
</div>    
<!--END Track Listing-->
<!--END Big Controls-->
  <div style="z-index:9;cursor: ew-resize;background-color: #FFFFFF;position:absolute;bottom:84px;height:80px;width:100%" id="outsideProgressBar">
    <div style="background-color: #8A0000;position:absolute;left:0px;height:100%;width:50%;transition:width 1s linear;" id="insideProgressBar"></div>
    <div style="z-index:9;background-color:transparent;position:absolute;right:0px;height:80px;width:150px;margin:auto;text-align: center;vertical-align: middle;line-height: 60px"><font id="trackLength" style="curser: ew-resize;color:#000;font-family: monospace;font-size:20pt;font-weight:bolder;text-align: center;vertical-align: middle;line-height: 60px">2:34</font></div>
    <div style="z-index:9;width:100%;margin:0 auto;background-color:transparent;position:absolute;height:80px;text-align: center;vertical-align: middle;line-height: 60px"><font id="trackCurrent" style="cursor: ew-resize;color:#000;font-family: monospace;font-size:40pt;font-weight:bolder;text-align: center;vertical-align: middle;line-height: 60px">2:34</font></div>
  </div>
</div>
<!--END Big Controls-->
</div>
<!--END Control Panel-->
<!--START Clear Overlay-->
<div style="z-index:9;width:100%;height:100%;position:absolute;top:0px;left:0px;background-color:transparent" id="clearOverlay" onclick="clickClearOverlay()">
    <div style="z-index:9;position:absolute;top:0px;left:0px;background-color:transparent;color:white;" id="bounceIcon"><img src="images/overlay/002.png" style="border:0;" id="bounceIconImg" /></div>
</div>
<!--END Clear Overlay-->
<!--START Initial Popup-->
<div style="z-index:10; width:100%;height:100%;position:absolute;top:0px;left:0px;background-color: black" id="innerPop"><div id="outerPop" style="margin: auto;width:100%;height:100%;color:black;background-color:black;position:relative"><img src="images/back2.jpg" border="0" width="400" height="400" style="position:absolute;border:2px solid;border-radius:25px;left:0;right:0;top:40px;margin:auto" onclick="hidePop()" /></div>
</div>
<div style="z-index:10; width:100%;height:100%;position:absolute;top:0px;left:0px;background-color: black" id="innerPopFadeMe"><div id="outerPopFadeMe" style="margin: auto;width:100%;height:100%;color:black;background-color:black;position:relative"><img src="images/back2Fade.jpg" border="0" width="400" height="400" style="position:absolute;border:2px solid;border-radius:25px;left:0;right:0;top:40px;margin:auto" onclick="hidePopFadeMeNow()" /></div>
</div>
<!--END Initial Popup-->
</div>
<!--END FullScreenPanel-->
<div id="video_data" name="video_data" style="display:none;visibility:hidden">
<%
Iterator it = tracks.data.entrySet().iterator();
Map.Entry pair;
String key = new String();
DB.Track track = new DB.Track();
while (it.hasNext()) {
    pair = (Map.Entry)it.next();
    key = (String)pair.getKey();
    track = (DB.Track)pair.getValue();
%>|000020|v001|<%=track.title%>|<%=track.startAt%>|<%=track.playLength%>|20|<br />blah|blah|//www.youtube.com/embed/<%=track.code%>|
<%}%>
|********|
</div>
<script type="text/javascript">
//Track Data Holders
var keys = new Array();
var data_versions = new Array();
var one_words = new Array();
var start_point = new Array();
var lengths = new Array();
var ad_lengths = new Array();
var titles = new Array();
var descs = new Array();
var embeds = new Array();
var order = new Array();

var maxVideos = 6000;
var maxHTMLSnipLength = 10000;
var totalVideos = 0;
var startPopLength = 2000;
var lagButtonLength = 7000;
var isNextButtonRunning = false;
var date;
var rawData = '';
var start = -1;
var end = -1;
var charPoint = 0;	//<skip carrage return>
var currentVideoIndex = 0;
var nextButtonLagTimer = 0;
var autoToggleOnOff = true;
var maxToggleOnOff = false;
var rndToggleOnOff = false;
var videoQuality = 0;   //0 = high, 1 = low, 2 = audio
var player;
var waitVideoQuality = true;   //true = wait
var playing = true;
var vTNextTime;
var vTThread;
var vTNextCheck = 3000;
var vTNextLag = 5000;
var vTStartNextFlicker = 10000;
var vTIsFLickerRunning = false;
var vTFLickOnOff = false;
var timeoutValueForControlPanelInFuture = Date.now();
var controlPanelShowTime = 8000;
var controlPanelRunning = false;
var controlPanelShowing = false;
var backButtonSmallerTrigger = 250;
var isTrackListingOpen = false;
var hideFloatDivLag = 10000;
var nextHideFloatDivLag = 0;
var progressPtc = 0;
var countTrackListingOpenCount = 0;

//THREADS
var playThread; //Press Play thread
var skipToStartThread;    //Skip ahead on start
var moveDivThread;  //ControlsOff Clear Overlay Floating Image
var pBThread;   //Progress Bar

//VIDEO CONTROL FUNCTIONS
function loadCurrentVideo(n) {    
    //kill non zero threads
    clearTimeout(playThread);
    clearTimeout(skipToStartThread);    
    player.setSrc(embeds[order[currentVideoIndex]]);
    if (start_point[order[currentVideoIndex]] != 0) {
        playThread = setTimeout("player.play();", 2000);
        skipToStartThread = setTimeout("player.setCurrentTime(" + start_point[order[currentVideoIndex]] + ");", 3000);        
    } else {
        playThread = setTimeout("player.play();", 2000);        
    }
    document.getElementById('innerOne_word').innerHTML = one_words[order[currentVideoIndex]];
    vTIsFLickerRunning = false;
    if (n != 'none') {
  	btnDown(n);
      nextButtonLagTimer = new Date().getTime() + lagButtonLength;
      setTimeout('btnCheckLag("' + n + '");', lagButtonLength);
    }
    vTResetTimer();
    //resize incase not rendored correctly
    setTimeout('resizeVideo();', 5000);
    resetProgressBar();
    var minutes = Math.floor(lengths[order[currentVideoIndex]] / 60);
    var seconds = lengths[order[currentVideoIndex]] - (minutes * 60);
    if (seconds <= 9) {
        document.getElementById('trackLength').innerHTML = minutes + ':0' + seconds;
    } else {
        document.getElementById('trackLength').innerHTML = minutes + ':' + seconds;        
    }
    //set pause button
    if (playing == false) {
        playPause();      
    }
    //redraw track listing
    fillTrackListing();
}
function refreshVid(n) {
  loadCurrentVideo('btnRefr');
}
function next(n) {
  currentVideoIndex++;
  if (currentVideoIndex == totalVideos) {
    currentVideoIndex = 0;
  }
  loadCurrentVideo(n);
  btnDown(n);
  nextButtonLagTimer = new Date().getTime() + lagButtonLength;
  setTimeout('btnCheckLag("' + n + '");', lagButtonLength);
  vTResetTimer();
  vTIsFLickerRunning = false;
  //play button
  if (playing == false) {
      playPause();      
  }
}
function autoNext(n) {
    next('btnNext');
}
function prev(n) {
  currentVideoIndex--;
  if (currentVideoIndex == -1) {
    currentVideoIndex = totalVideos-1;
  }
  loadCurrentVideo(n);
  btnDown(n);
  nextButtonLagTimer = new Date().getTime() + lagButtonLength;
  setTimeout('btnCheckLag("' + n + '");', lagButtonLength);
  vTResetTimer();
  vTIsFLickerRunning = false;
  //play button
  if (playing == false) {
      playPause();      
  }
}
function playPause() {  
  var btn = document.getElementById('playPauseBtn');
  if (playing) {
    playing = false;
    btn.src = "images/buttons/btnPlay_seeThru.png";
    pause();
  } else {
    playing = true;
    btn.src = "images/buttons/btnPause_seeThru.png";
    play();
  }
}
function pause() {
    player.pause();
    pauseTimer();
}
function pauseTimer() {
    if (playing == false) {
        vTNextTime = vTNextTime + 300;
        setTimeout("pauseTimer()", 300);
    }
}
function play() {
    player.play();
}
function skipToTrack(trackIndex) {
  currentVideoIndex = trackIndex;
  loadCurrentVideo('none');
  btnDown('none');
  vTResetTimer();
  //play button
  if (playing == false) {
      playPause();      
  }
  //close track listing
  openCloseTrackListing();
}
function toggleAuto() {
  if (autoToggleOnOff) {
    autoToggleOnOff = false;
    document.getElementById('btnAuto').src = "images/buttons/btnAuto_off.jpg";
  } else {
    autoToggleOnOff = true;
    document.getElementById('btnAuto').src = "images/buttons/btnAuto_on.jpg";
  }
}
function toggleMax() {
  if (maxToggleOnOff) {
    maxToggleOnOff = false;
    document.getElementById('btnMax').src = "images/buttons/btnMax_off.jpg";
    minFullScreen();
  } else {
    maxToggleOnOff = true;
    document.getElementById('btnMax').src = "images/buttons/btnMax_on.jpg";
    goFullScreen();  
  }
}
function toggleRnd() {
  if (rndToggleOnOff) {
    rndToggleOnOff = false;
    document.getElementById('btnRnd').src = "images/buttons/btnRnd_off.jpg";
    for (x = 0 ; x < totalVideos ; x++) {
        order[x] = x;
    }
  } else {
    rndToggleOnOff = true;
    document.getElementById('btnRnd').src = "images/buttons/btnRnd_on.jpg";
    order.sort(function(a, b){return 0.5 - Math.random()});
  }
  refreshVid();
  btnNormal('btnRefr');
}
function createPlayer() {
  document.getElementById('innerEmbed').innerHTML = '<video width="100%" height="100%" id="player1"><source type="video/youtube" src="'+ embeds[order[currentVideoIndex]] + '" /></video>';
  $('#player1').mediaelementplayer({stretching: 'none', plugins: ['flash', 'silverlight'],
    success: function(mediaElement, domObject) {
      player = mediaElement;
      $('#bt1').on('click', function() {
        mediaElement.play();
      });
      if (mediaElement.pluginType == 'flash') {
        mediaElement.addEventListener('canplay', function() {}, false);
      }
    },
    error: function() {}});
}
function recreatePlayer() {  
  player.setSrc('');
  player.remove();    
  setTimeout('recreatePlayerStage2();', 1000);
}
function recreatePlayerStage2() {
      document.getElementById('innerEmbed').innerHTML = '<video width="100%" height="100%" id="player1" controls><source type="video/youtube" src="'+ embeds[order[currentVideoIndex]] + '" /></video>';  
  setTimeout('recreatePlayerStage3();', 200);
}
function recreatePlayerStage3() {
  $('#player1').mediaelementplayer({stretching: 'responsive', plugins: ['flash', 'silverlight'], success: function(mediaElement, domObject) {player = mediaElement;$('#bt1').on('click', function() {player.play();});if (mediaElement.pluginType == 'flash') {mediaElement.addEventListener('canplay', function() {}, false);}},error: function() {alert('ewww')}});        
  setTimeout('recreatePlayerStage4();', 200);
   
}
function recreatePlayerStage4() {
    refreshVid();
}
function goFullScreen() {
    var elem = document.getElementById("backgroundScreen");
    if (elem.requestFullscreen) {
      elem.requestFullscreen();
    } else if (elem.msRequestFullscreen) {
      elem.msRequestFullscreen();
    } else if (elem.mozRequestFullScreen) {
      elem.mozRequestFullScreen();
    } else if (elem.webkitRequestFullscreen) {
      elem.webkitRequestFullscreen();
    }
}
function minFullScreen() {
    var elem = document.getElementById("backgroundScreen");
    if (elem.exitFullscreen) {
        elem.exitFullscreen();
    } else if (elem.webkitExitFullscreen) {
        elem.webkitExitFullscreen();
    } else if (elem.mozCancelFullScreen) {
        elem.mozCancelFullScreen();
    } else if (elem.msExitFullscreen) {
        elem.msExitFullscreen();
    }
    if (document.exitFullscreen) {
        document.exitFullscreen();
    } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
    } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    } else if (document.msExitFullscreen) {
        document.msExitFullscreen();
    }
}
function clickClearOverlay() {    
    resetControlFadeOut();
}
function resetProgressBar() {
    ///vTNextTime
    var bar = document.getElementById('insideProgressBar');
    bar.style.width = "0%";
    progressPtc = 0;
    clearTimeout(pBThread);
    progressBar();
}
function progressBar() {
    var popme = (vTNextTime - Date.now() - vTNextLag) / 1000;
    var progressSec = lengths[order[currentVideoIndex]] - popme;
    progressPtc = (progressSec / lengths[order[currentVideoIndex]]) * 100;
    var bar = document.getElementById('insideProgressBar');
    bar.style.width = progressPtc + "%";    
    pBThread = setTimeout('progressBar()', 1000);
    var minutes = Math.floor(progressSec / 60);
    var seconds = Math.floor(progressSec - (minutes * 60));
    if (seconds <= 9) {
        document.getElementById('trackCurrent').innerHTML = minutes + ':0' + seconds;
    } else {
        document.getElementById('trackCurrent').innerHTML = minutes + ':' + seconds;        
    }
    //see if we should move flaoting div
    var isTime = Math.floor(Math.random() * 6) + 1;
    if (isTime == 1) {
        if (nextHideFloatDivLag < Date.now() || nextHideFloatDivLag == 0) {
            nextHideFloatDivLag = Date.now() + hideFloatDivLag;
            clearTimeout(moveDivThread);
            moveDiv();            
        }
    }
}
function seekPosition(e) {
    var barLength = $('#outsideProgressBar').width();
    var xclick = e.clientX;
    if (start_point[order[currentVideoIndex]] != 0) {
        var ptc = xclick / barLength;
        var clickedTime = lengths[order[currentVideoIndex]] * ptc;
        //set new player time
        var newClickedTime = 0;
        newClickedTime = eval(Math.floor(clickedTime)) + eval(start_point[order[currentVideoIndex]]);
        player.setCurrentTime(newClickedTime);
        //set new virtual timer
        vTNextTime = (new Date().getTime() + (lengths[order[currentVideoIndex]] * 1000) + vTNextLag) - (clickedTime * 1000);                
    } else {
        var ptc = xclick / barLength;
        var clickedTime = lengths[order[currentVideoIndex]] * ptc;
        //set new player time
        player.setCurrentTime(clickedTime);
        //set new virtual timer
        vTNextTime = (new Date().getTime() + (lengths[order[currentVideoIndex]] * 1000) + vTNextLag) - (clickedTime * 1000);        
    }

}
function openCloseTrackListing() {
    var $span2 = $("#divTrackListing");    
    var $span3 = $("#overPlayerControls");    
    //reset the timer that holds open the track listing
    countTrackListingOpenCount = 0;
    if (isTrackListingOpen) {
        isTrackListingOpen = false;
        $span2.css('top', -1000);
        $span2.css('width', "0px");
        $span3.css('top', '0px');        
        $span3.css('width', "100%");
    } else {
        isTrackListingOpen = true;
        $span2.css('top', '0px');
        $span2.css('width', "100%");
        $span3.css('top', -1000);
        $span3.css('width', "0px");
        //reset delay fade timer
        countTrackListingOpenCount = 0;
    }    
}
function fillTrackListing() {
    var newInner = '<table cellpadding="0" cellspacing="0" width="100%" style="color:white;width:100%;font-family:monospace;font-size:18pt;" id="trackListingTable">';
    var xx = 0;
    var selColor = '';
    var selSize = '';
    var selWeight = '';
    var selPlaying = '';
    for (x = 0 ; x < totalVideos ; x++) {
        xx = x + 1;
        if (x != currentVideoIndex) {
            selColor='white';selSize='100%';selWeight='normal';selPlaying='';
        } else {
            selColor='#F56E70';selSize='130%';selWeight='bolder';selPlaying='--PLAYING-- ';  
        }
        newInner = newInner + '<tr><td width="100%" height="40px" style="font-size:' + selSize + ';text-align:left;vertical-align:middle;width:100%;height:40px;cursor: pointer;background-color:black;color:' + selColor + ';font-weight:' + selWeight + ';" onclick="skipToTrack(' + x + ')" id="trackSelect_' + xx + '">' + xx + ' : '+ selPlaying + '' + one_words[order[x]] + '</td></tr>';        
    }
    newInner = newInner + '</table> ';
    document.getElementById("divTrackListingInner").innerHTML = newInner;
}
function resize() {
    resizeVideo();
    resizeOverlayButtons();
    resizeTrackListing();
    resizeBounceIcon();
}
function resizeVideo() {
    var containerWidth = $('#innerEmbed').width();
    var containerHeight = $('#innerEmbed').height();
    player.setSize(containerWidth,containerHeight);
}
function resizeOverlayButtons() {
   var tdWidth = $('#btnPrev').width();
   if (tdWidth < backButtonSmallerTrigger) {
     document.getElementById('playPauseBtn').style.height = "50px";  
     document.getElementById('backBtn').style.height = "50px";  
     document.getElementById('nextBtn').style.height = "50px";
    } else {
     document.getElementById('playPauseBtn').style.height = "120px";          
     document.getElementById('backBtn').style.height = "120px";  
     document.getElementById('nextBtn').style.height = "120px";  
    }
}
function resizeTrackListing() {
   var tdWidth = $('#btnPrev').width();
   if (tdWidth < backButtonSmallerTrigger) {       
     document.getElementById('trackListingTable').style.fontSize = "12pt";  
    } else {
     document.getElementById('trackListingTable').style.fontSize = "18pt";  
    }
}
function resizeBounceIcon() {
   var tdWidth = $('#btnPrev').width();
   if (tdWidth < backButtonSmallerTrigger) {    
     document.getElementById('bounceIconImg').style.width = "50%";  
    } else {
     document.getElementById('bounceIconImg').style.width = "100%";  
    }    
}
function hidePopFadeMe() {
    $('#innerPopFadeMe').fadeTo(2000, 0);
    setTimeout('hidePopFadeMeHide();', 2000);    
}
function hidePopFadeMeNow() {
    hidePopFadeMeHide();
}
function hidePopFadeMeHide() {
    inner = document.getElementById('innerPopFadeMe');
    inner.style.visibility = 'hidden';
    inner.style.width='0';
    inner.style.height='0';    
    inner = document.getElementById('outerPopFadeMe');
    inner.style.visibility = 'hidden';
    inner.style.width='0';
    inner.style.height='0';    
}
function hidePop() {
  outer = document.getElementById('outerPop');
  outer.style.visibility = 'hidden';
  outer.style.width='0';
  outer.style.height='0';
  inner = document.getElementById('innerPop');
  inner.style.visibility = 'hidden';
  inner.style.width='0';
  inner.style.height='0';

        
loadCurrentVideo('none');
  startVT();
  //goFullScreen();
  //call floating div for first time
  moveDivFirst();
  //call first track listing fill
  fillTrackListing();
  //click random
  toggleRnd();
  setTimeout('resize();', 100);
  
  
}

//BUTTONS
function btnUp(n) {
  if (n == 'btnAuto') {
    if (autoToggleOnOff == false) {
	  document.getElementById(n).src = "images/buttons/btnAuto_off.jpg";
	} else {
	  document.getElementById(n).src = "images/buttons/btnAuto_on.jpg";
	}
  } else if (n == 'btnMax') {
    if (maxToggleOnOff == false) {
	  document.getElementById(n).src = "images/buttons/btnMax_off.jpg";
	} else {
	  document.getElementById(n).src = "images/buttons/btnMax_on.jpg";
	}
  } else if (n == 'btnQuality') {
    var tp = '';
    if (videoQuality == 0) {
        tp = 'High';
    } else if (videoQuality == 1) {
        tp = 'Low';
    } else if (videoQuality == 2) {
        tp = 'Aud';
    }
    document.getElementById(n).src = "images/buttons/btnSet" + tp + "_u.jpg";    
  }  else {
    document.getElementById(n).src = "images/buttons/" + n + "_u.jpg";
  }
}
function btnDown(n) {
  if (n == 'btnAuto') {
    if (autoToggleOnOff == false) {
	  document.getElementById(n).src = "images/buttons/btnAuto_off.jpg";
	} else {
	  document.getElementById(n).src = "images/buttons/btnAuto_on.jpg";
	}
  } else if (n == 'btnmax') {
    if (maxToggleOnOff == false) {
	  document.getElementById(n).src = "images/buttons/btnMax_off.jpg";
	} else {
	  document.getElementById(n).src = "images/buttons/btnMax_on.jpg";
	}
  } else if (n == 'btnQuality') {
    var tp = '';
    if (videoQuality == 0) {
        tp = 'High';
    } else if (videoQuality == 1) {
        tp = 'Low';
    } else if (videoQuality == 2) {
        tp = 'Aud';
    }
    document.getElementById(n).src = "images/buttons/btnSet" + tp + "_n.jpg";    
  } else {
    //document.getElementById(n).src = "images/buttons/" + n + "_n.jpg";
  }
}
function btnNormal(n) {
  if (n == 'btnAuto') {
    if (autoToggleOnOff == false) {
	  document.getElementById(n).src = "images/buttons/btnAuto_off.jpg";
	} else {
	  document.getElementById(n).src = "images/buttons/btnAuto_on.jpg";
	}
  } else if (n == 'btnMax') {
    if (maxToggleOnOff == false) {
	  document.getElementById(n).src = "images/buttons/btnMax_off.jpg";
	} else {
	  document.getElementById(n).src = "images/buttons/btnMax_on.jpg";
	}
  } else if (n == 'btnQuality') {
    var tp = '';
    if (videoQuality == 0) {
        tp = 'High';
    } else if (videoQuality == 1) {
        tp = 'Low';
    } else if (videoQuality == 2) {
        tp = 'Aud';
    }
    document.getElementById(n).src = "images/buttons/btnSet" + tp + "_n.jpg";    
  } else {
    //document.getElementById(n).src = "images/buttons/" + n + "_n.jpg";
  }
}
function btnCheckLag(n) {
  if (nextButtonLagTimer > new Date().getTime()) {
    //not time, check again later
    setTimeout('btnCheckLag("' + n + '");', lagButtonLength + 100);
  } else {
    btnNormal(n);
  }

}

/****VIDEO TIMER START****/
function vTLoadNextVideo() {
  now = new Date().getTime();
  if (vTIsFLickerRunning == false) {
	//check to see if its time to do the flicker
    if (now > (vTNextTime - vTStartNextFlicker)) {
      if (autoToggleOnOff) {
	    vTIsFLickerRunning = true;
	    vTFlickNext();
	  } else {
            //do nothing
	  }
	}
  }
  if (vTNextTime < now) {
    //next
    if (autoToggleOnOff) {
      autoNext();
    } else {
      vTThread = setTimeout('vTLoadNextVideo()', vTNextCheck);
    }
    //reset timer
  } else {
    //not time yet
    vTThread = setTimeout('vTLoadNextVideo()', vTNextCheck);
  }
}
function vTResetTimer() {
  vTNextTime = new Date().getTime() + (lengths[order[currentVideoIndex]] * 1000) + vTNextLag;
  clearTimeout(vTThread);
  vTLoadNextVideo();
}
function startVT() {
  //we do the same as vTResetTImer but without the clearTimeout
  vTNextTime = new Date().getTime() + (lengths[order[currentVideoIndex]] * 1000) + vTNextLag;
  vTLoadNextVideo();
}
function vTFlickNext() {
  if (autoToggleOnOff) {
    if (vTIsFLickerRunning == true) {
      if (vTFLickOnOff) {
        document.getElementById('btnNext').src = "images/buttons/btnNext_d.jpg";
	    vTFLickOnOff = false;
      } else {
        document.getElementById('btnNext').src = "images/buttons/btnNext_n.jpg";
	    vTFLickOnOff = true;
      }
	  setTimeout('vTFlickNext();', 350);
    } else {
	    document.getElementById('btnNext').src = "images/buttons/btnNext_n.jpg";
    }
  } else {
    document.getElementById('btnNext').src = "images/buttons/btnNext_n.jpg";
  }
}

//VIDEO DATA
function parseData() {
  rawData = document.getElementById('video_data').innerHTML;
  if (rawData == null) {
    return;
  }
  if (rawData.length < 10) {
    return;
  }
  getFirstCharPoint();
  for (y = 0 ; y < maxVideos ; y++) {
	if (rawData.substring(charPoint +1, charPoint + 4) == '***') {
		y = maxVideos;
	} else {
	  if (rawData.charAt(charPoint) == '|') {
            /**START PARSE HERE**/
            keys[totalVideos] = getChunk('first');
            data_versions[totalVideos] = getChunk('next');
            one_words[totalVideos] = getChunk('next');
            start_point[totalVideos] = getChunk('next');
            lengths[totalVideos] = getChunk('next');
            ad_lengths[totalVideos] = getChunk('next');
            titles[totalVideos] = getChunk('next');
            descs[totalVideos] = getChunk('next');
            embeds[totalVideos] = getChunk('next');
            embeds[totalVideos] = convFrame(embeds[totalVideos]);
            getNextCharPoint();
            /**END PARSE HERE**/	
            totalVideos++;
	  } else {
        charPoint++;
        }
      }
  }
  var elem = document.getElementById("video_data");
  elem.parentNode.removeChild;
  order = new Array(totalVideos);
  for (x = 0 ; x < totalVideos ; x++) {
      order[x] = x;
  }
  //Enable when random is on first load is on
  //order.sort(function(a, b){return 0.5 - Math.random()});
}
function getChunk(type) {
  if (type == 'first'){
    start = charPoint;  
  } else {
    start = end;
  }
  end = start + 1;
  for (x = 0 ; x < maxHTMLSnipLength ; x++) {
    if (rawData.charAt(end) == '|') {
      x = maxHTMLSnipLength;
    } else {
      end++;
    }
  }
  return rawData.substring(start + 1, end);
}
function convFrame(snip) {
  out = '';
  if (snip.substring(0, 5) == "//www") {
    out = 'http://www' + snip.substring(5, snip.length);
  }
return out;
}

function getFirstCharPoint() {
  if (rawData.charAt(charPoint) != '|') {
    charPoint++;
  }
}
function getNextCharPoint() {
  charPoint = end + 1;
  for (x = 0 ; x < 1000 ; x++){
    if (rawData.charAt(charPoint) != '|') {
      charPoint++;
    } else {
	  x = 1000;
    }
  } 
}

//SCREEN MOVING AND CONTROL
function resetControlFadeOut() {
    //set timer to later
    timeoutValueForControlPanelInFuture = Date.now() + controlPanelShowTime;
    if (controlPanelRunning) {
        //controls are already showing, timer started already            
    } else {
        //resize clear overlay
        var clearOverlay = document.getElementById('clearOverlay');
        clearOverlay.style.width = "0px";
        clearOverlay.style.height = "0px";
        clearOverlay.style.top = "-1000px";
        clearOverlay.style.left = "-1000px";
        //set control panel to visible
        //var controlPanel = document.getElementById('controlPanel');    
        //controlPanel.style.opacity = "0.8";
        $('#controlPanel').fadeTo(300, 0.8);
        //no timer running, start it
        controlPanelRunning = true;
        controlPanelFadeTimer();
    }
}
function controlPanelFadeTimer() {
    var rightNow = Date.now();
    if (rightNow > timeoutValueForControlPanelInFuture) {
        //time to fade
        fadeOutControlPanelAndLock();
    } else {
        //not time, wait and call again
        setTimeout('controlPanelFadeTimer()', 300);
    }
}
function fadeOutControlPanelAndLock() {
    var isOkToFade = false;
    if (isTrackListingOpen) {
        if (countTrackListingOpenCount >= 2) {
            countTrackListingOpenCount = 0;
            isOkToFade = true;
        } else {
            countTrackListingOpenCount++;
        }
    } else {
        isOkToFade = true;
    }
    if (isOkToFade) {
        var clearOverlay = document.getElementById('clearOverlay');
        clearOverlay.style.width = "100%";
        clearOverlay.style.height = "100%";
        clearOverlay.style.top = "0px";
        clearOverlay.style.left = "0px";
            //set control panel to visible
        $('#controlPanel').fadeTo(1000, 0.0);
        controlPanelRunning = false;
        ////check if track listign is showing
        if (isTrackListingOpen) {
            setTimeout('openCloseTrackListing();', 1100);
        }        
    } else {
        //restart
        resetControlFadeOut();
        controlPanelFadeTimer();
    }
}
function moveDivFirst() {
  var $span = $("#bounceIcon");
  $span.fadeOut(0);
  moveDiv();
}
function moveDiv() {
  var $span = $("#bounceIcon");
  $span.fadeTo(1000, 0.0);
  moveDivThread = setTimeout('moveDiv2();', 1000);
}
function moveDiv2() {
    var $span = $("#bounceIcon");    
    var maxLeft = $(window).width() - $span.width();
    var maxTop = $(window).height() - $span.height();
    var leftPos = Math.floor(Math.random() * (maxLeft + 1));
    var topPos = Math.floor(Math.random() * (maxTop + 1));
    $span.css({ left: leftPos, top: topPos });
    $span.fadeTo(1000, 0.8);    
}

//ONLOAD EVENT CATCHERS
function setEventListeners() {
    //yellowContainer.addEventListener("click", getClickPosition, false);
    document.getElementById('outsideProgressBar').addEventListener("click", seekPosition, false);
}
window.onload = function() {
  createPlayer();
  parseData();
  setTimeout('hidePopFadeMe();', 5000);
  setTimeout('waitVideoQuality = false;', 6500);
  setEventListeners();
};
</script>
</body>
</html>
