
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>San Antonio Metropolitan Health District</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<LINK REL="StyleSheet" HREF="_master.css" type="text/css">
		<script language="javascript">
			var keyTime, keyStr = '', allOpts, lastElement;
var agt = navigator.userAgent.toLowerCase();
//var is_ie = ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1));
var is_gecko = (agt.indexOf("gecko") != -1);
function populate(srcEvent)
{
  var element = (srcEvent)? ((srcEvent.target)? srcEvent.target : srcEvent.srcElement) : window.event.srcElement;
  element = (!element)?event.srcElement:element;
  if(lastElement != element)
  {
    allOpts = new Array();
    for(var i = 0; i < element.options.length; i++)
      allOpts[i] = element.options[i].text.toLowerCase();
    lastElement = element;
  }
}
function setSelection(srcEvent)
{
	var myEvent = (srcEvent)? srcEvent : ((window.event)?window.event:event);
  var element = (myEvent.target)? myEvent.target : myEvent.srcElement;
  var keyCode = myEvent.keyCode;
  keyCode = (!keyCode)?event.keyCode:keyCode;
  element = (!element)?event.srcElement:element;
  
  // messy JS keycodes force me to preprocess. Note: I use a US keyboard, other keyboards may vary?
  if((keyCode > 47 && keyCode < 58) || (keyCode > 64 && keyCode < 91 || keyCode == 32)) ; // space or alphanumerical characters, leave them alone
  else if(keyCode > 95 && keyCode < 106) keyCode -= 48; // keypad numbers
  else if(keyCode > 105 && keyCode < 112) keyCode -= 64; // keypad '+', '-', '/', '*', '.'
  else if(keyCode > 187 && keyCode < 192) keyCode -= 144; // '/', '.', ',', '-'
  else if(keyCode > 218 && keyCode < 222) keyCode -= 128; // '\', '[', ']'
  else
  {
    switch(keyCode)
    {
      case 187: keyCode = 61; break; // '='
      case 222: keyCode = 39; break; // '''
      case 192: keyCode = 96; break; // '`'
      case 186: keyCode = 59; break; // ';'
      default: return; // do not process non printable characters (unfortunately backspace cannot be supported because browsers like IE interpret backspace as go back a page in history)
    }
  }
  var currentKey = String.fromCharCode(keyCode).toLowerCase();
  var idx, currentSIdx = element.selectedIndex, useOld = false;
  var newTime = new Date().getTime();
  if(keyTime != null && newTime - keyTime < 500) // do type-ahead if two keys were pressed within 500 milliseconds (0.5 second, one can change this value for customization)
  {
    keyStr += currentKey;
    idx = findIdx();
	if(idx == -1) return; // not found, keep current selection then (leave the incorrect keyStr alone)
  }
  else // unfortunately we seem to have to handle default browser behavior too
  {
    keyStr = currentKey;
    // behavior should be: if next option is available and begins with the same character, select the next option
    // when there is either no more option, or no more option that begins with the same character as the current option,
    // then select the first option that starts with the currentKey
    idx = currentSIdx + 1;
    if(idx >= allOpts.length || allOpts[idx].length == 0 || allOpts[idx].charAt(0) != keyStr) {
      idx = findIdx();
	}
  }
  if(idx >= 0) // if keyStr is found in an option, select the option
  {
	  
    element.options[currentSIdx].selected = false;
    // gecko-based browsers have a very strange bug that strikes when user presses
    // the same character multiple times (like 'AAA', 'BBBB'), which could be "fixed"
    // in a strange way too (actually the idx > 0 test is not even necessary!)
    // first make a pattern to check if it's same character multiple times
    var pattern = new RegExp('^' + keyStr.charAt(0) + '+$', "i");
    

	element.options[idx].selected = true;	
	/*
	if(is_gecko && pattern.test(keyStr) && idx > 0) {
		element.options[idx-1].selected = true;
	} else {
		element.options[idx].selected = true;
	}
	*/
  }
  keyTime = newTime;
}

function findIdx() {
	// full scan to find the smallest idx that match string keyStr (case-insensitive)
	var len = keyStr.length;

	//alert(allOpts[1].length >= 1 && allOpts[1].substring(0, 1) == 'j');

	for(var i = 0; i < allOpts.length; i++) {
		//alert(allOpts.length)
		//document.getElementById('debug2').innerHTML += document.getElementById('debug2').innerHTML + '<br>' + allOpts[i];
		
		if(allOpts[i].length >= len && allOpts[i].substring(0, len) == keyStr) {
			return i;
		} 
	}

	return -1;

}

function jm_frameBuster() { //v1.0 | Frame Buster Script
	// Call With: setTimeout ("jm_frameBuster()", 1000);
	if (self.parent.frames.length != 0){
		self.parent.location=document.location;
	}
}

function jm_popWin(pWin,args){ //v1.0 | Popup Window
	// usage: jm_popWin('page.html','width=300,height=200')
	popWin=window.open(pWin,'popWin',args)
	popWin.focus()
}

function jm_popWinU(pWin,popName,args){ //v1.0 | Popup Window - Unique Name
	// usage: jm_popWinU('page.html','thisWinName','width=300,height=200')
	popWin=window.open(pWin,popName,args)
	popWin.focus()
}

function jm_goPrint_Frame(frame){ //v1.0 | Print Function (Frames)
	window.frame.focus();
	window.print();
}
function jm_goPrint(){ //v1.0 | Print Page Function (No-Frames)
	window.print();
}

function jm_alert(alertText){ //v1.0 | Alert Window Function
	alert(""+alertText+"");
}
function jm_closeWin(){ //v1.0 | Close Window
	window.close();
}

function jm_refreshOpener(){ //v1.0 | Reloads the Opening Page
	window.opener.document.location.reload();
}

function jm_refreshOpenerCloseSelf(){ //v1.0 | Refreshes the Opening Page and Closes Self
	window.opener.document.location.reload();
	window.self.close();
}


function jm_showStatus(thisText){ //v1.0 | StatusBar Text
	status=thisText;
	document.returnValue = true;
}

function jm_goBack_Frame(frame){ //v1.0 | Back Function (Frames)
	parent.frame.document.location.href=history.go(-1);
}
function jm_goBack(){ //v1.0 | Back Function (No-Frames)
	history.go(-1);
}

function jm_goNext_Frame(frame){ //v1.0 | Next Function (Frames)
	parent.frame.document.location.href=history.go(1);
}
function jm_goNext(){ //v1.0 | Next Function (No-Frames)
	history.go(1);
}

function jm_reLoad_Frame(frame){ //v1.0 | Reload Function (Frames)
	parent.frame.document.location.reload()
}
function jm_reLoad(){ //v1.0 | Reload Function (No-Frames)
	document.location.reload()
}

function jm_navig8_Frame(here,frame){ //v1.0 | Relocate Function (Frames)
	parent.frame.document.location.href=''+here;
}
function jm_navig8(here){ //v1.0 | Relocate Function (No-Frames)
	document.location.href=''+here;
}

function jm_addBookmark(){ //v1.0 | Bookmark Function
  if (window.external)
    external.AddFavorite(location.href)
  else
    alert("Your browser doesn't support this feature.");
}

function jm_viewSource(){
	window.location = "view-source:" + window.location.href;
}

function jm_valid8GPS(thisObj){ //v1.0 | GPS Validation
	if(/([0-9]{1,11})\.([0-9]{1,7})/.test(thisObj.value) || thisObj.value == ""){
		return true;
	}else{
		alert("Invalid GPS value!\nA valid GPS value is formatted with a decimal and up to 7 decimal places.\nPlease re-enter your GPS value.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		thisObj.select();
		return false;		
	}
}

function jm_valid8IP(thisObj){ //v1.0 | Check IP Address (First 2 Stacks)
	if(/([0-2][0-9][0-9]\.)+[0-2][0-9][0-9]/.test(thisObj.value) || thisObj.value == ""){
		return true;
	}else{
		alert("Invalid IP Address! Please re-enter.");
		return false;
		setTimeout(function(){
			thisObj.focus();
		}, 2);
	}
}

function jm_valid8Url(thisObj){ //v1.0 | Check URL (http://text.text)
	if(/[^http:\/\/]+([a-zA-Z]|[0-9])+([\.]+[a-zA-Z])/.test(thisObj.value) || thisObj.value == ""){
		return true;
	}else{
		alert("Invalid URL! Please re-enter.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}
}

function jm_valid8Len(thisObj,formObj,maxLen){ //v1.0 | Limits the Number of Characters in a Field
	if(thisObj.value.length<=maxLen || thisObj.value == ""){
		return true;
	}else{
		alert("This field is limited to "+maxLen+" characters.\nYou entered "+thisObj.value.length+" characters.");
		jm_highLightField(thisObj,formObj);
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}
}

function jm_valid8Email(thisObj){ //v1.6 | Email Validation
	if(/^[_a-zA-Z0-9-']+(\.[_a-zA-Z0-9-']+)*@[a-zA-Z0-9-']+(\.[a-z0-9-']+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$/.test(thisObj.value.toLowerCase())  || thisObj.value == ""){
		return true;
	}else{
		alert("Invalid E-mail Address! Please re-enter.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}
}

function jm_valid8SSN(thisObj){ //v1.0 | SSN Validation
	if(/^(\d{3})-?\d{2}-?\d{4}$/.test(thisObj.value) || thisObj.value == ""){
		return true;
	}else{
		alert("Invalid SSN. Must be 9 digits or in the form 000-00-0000.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}
}

function jm_valid8CCNum(thisObj){ //v1.0 | CCNum Validation.
	var error=0;
	var white_space=" -";
	var creditcard_string="";
	var check_char;
	var checkdigit = 0;
	var tempdigit;
	var doubledigit="";
	var i="";
	for (i = 0; i < thisObj.value.length; i++){
		check_char = white_space.indexOf(thisObj.value.charAt(i))
		if (check_char < 0){
			if(isNaN(thisObj.value.substring(i,(i+1)))){//Added by JM
				error=1;
				break;
			}
			creditcard_string += thisObj.value.substring(i, (i + 1));
		}
	}
    if (creditcard_string.length == 0){
        error=1;
	}
	if (creditcard_string.charAt(0) == "+"){
        error=1;
	}
	doubledigit = creditcard_string.length % 2 == 1 ? false : true;
	for (i = 0; i < creditcard_string.length; i++){
		tempdigit = eval(creditcard_string.charAt(i))
		if (doubledigit){
			tempdigit *= 2;
			checkdigit += (tempdigit % 10);

			if ((tempdigit / 10) >= 1.0){
				checkdigit++;
			}
			doubledigit = false;
		}
		else{
			checkdigit += tempdigit;
			doubledigit = true;
		}
	}
	if((checkdigit % 10)!=0){
		error=1;
	}
	if(error>0){
		alert("Invalid CC Number, please check your entry and try again.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}else{
		return true;
	}
}

function jm_valid8CCExpDate(thisObj) { //v1.0 | CCExp Date Validation
	if ((thisObj.value.indexOf('/') || thisObj.value.indexOf('-')) && thisObj.value.length>=4){
		var today= new Date;
		var error=0;
		if(thisObj.value.indexOf('/')>0){
			var dateParts=thisObj.value.split('/');
		}else if(thisObj.value.indexOf('-')>0){
			var dateParts=thisObj.value.split('-');
		}else{
			error=2;
		}
		if(dateParts && dateParts.length>2){
			var mm=dateParts[0];
			var dd=dateParts[1];
			var yy=dateParts[2];
		}else{
			var mm=dateParts[0];
			var dd=01;
			var yy=dateParts[1];
		}

		if(isNaN(parseFloat(mm)) || isNaN(parseFloat(dd)) || isNaN(parseFloat(yy))){
			error=1;
		}

		if(yy.length==3){error=1;}
		if(yy.length==2){yy="20"+yy;}
		if(mm.length==1){mm="0"+mm;}
		if(dd.length==1){dd="0"+dd;}
		if((yy==today.getFullYear() && mm<today.getMonth()) || (yy==today.getFullYear() && mm==today.getMonth() && dd<today.getDay()) || yy<today.getFullYear()){
			error=1;
		}else{
			return true;
		}
	}else{
		error=2;
	}
	if(error==2){
		alert("Invalid Date Format!\nDate Must Contain '/' or '-' to separate values.\nPlease re-enter.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}else if(error==1){
		alert("This card appears to be expired!\nPlease re-enter the expiration date or try another card.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}else{
		return true;
	}
}

// issue 123688. new credit card exp date validation function entered since jm_valid8CCExpDate doesnt quite work right and allows - or /.  This function only allows /
function js_valid8CCExp(thisObj) { 
  if (!/^\d{1,2}\/\d{4}$/.test(thisObj.value)) {
  	alert("Please enter a valid date in the format mm/yyyy");
  	setTimeout(function(){
		thisObj.focus();
	}, 2);
  	return false;
  }; 
  var parts = thisObj.value.split('/'); 
  var today = new Date(); today.setHours(0,0,0,0); //normalise 
  var yyyy = parseInt(parts[1],10); 
  var mm = parseInt(parts[0],10); 
  var expDate = new Date(yyyy,mm-1,today.getDate(),0,0,0,0); 
  
  if (expDate.getFullYear() != yyyy || expDate.getMonth() != (mm-1) || parts[0].length != 2) {
  	alert("Please enter a valid date in the format mm/yyyy");
  	setTimeout(function(){
		thisObj.focus();
	}, 2);
  	return false;
  }
  // older than today - maybe even test it is not in the too near future 
  if (expDate.getTime()<today.getTime()) {
  	alert("This card appears to be expired!\nPlease re-enter the expiration date or try another card.");
  	setTimeout(function(){
		thisObj.focus();
	}, 2);
  	return false; 
  } 
  // not a likely date
  if (expDate.getFullYear()-today.getFullYear()>10) {
  	alert("Please check the date because it is more than 10 years old.");
  	setTimeout(function(){
		thisObj.focus();
	}, 2);
  	return false; 
  }     
  return true;
} 


function jm_valid8Date(thisObj){ //v2.2 | Date Validation
	var thisdate = thisObj.value;

	if(thisdate.length > 10){
		thisdate = thisdate.substr(0,10);
	}
	
	if(/^(\d{2})\/\d{2}\/\d{4}$/.test(thisdate)){
		// Perform Actual Date Validation
		var y,m,d;
		var maxdays=31;
		var dateParts=thisObj.value.split('/');
		m=parseFloat(dateParts[0]);
		d=dateParts[1];
		y=dateParts[2].split(" ")[0];

		if(m==4 || m==6 || m==9 || m==11){
			maxdays=30;
		}else if((m==2) && (y%4==0) && ((!(y%100==0)) || (y%400==0))){
			maxdays=29;
		}else if(m==2){
			maxdays=28;
		}else{
			maxdays=31;
		}

		if( (m<1 || m > 12) || (d > maxdays)  || (y <= 1900)){
			alert("Invalid Date. Please check the date you entered.");
			if(thisObj.type.toLowerCase() != "hidden"){
				setTimeout(function(){
					thisObj.focus();
				}, 2);
			}
			return false;
		}else{
			return true;
		}
	}else if(/^\d{2}\d{2}\d{2}$/.test(thisObj.value)){
		// Perform Actual Date Validation
		var y,m,d;
		var dec;
		var now=new Date();
		var maxdays=31;
		var dateParts=thisdate;
		m=parseFloat(dateParts.substring(0,2));
		d=dateParts.substring(2,4);
		dec=now.getFullYear();
		y=dec.toString().substring(0,2) + dateParts.substring(4,6);

		if(m==4 || m==6 || m==9 || m==11){
			maxdays=30;
		}else if((m==2) && (y%4==0) && ((!(y%100==0)) || (y%400==0)) ){
			maxdays=29;
		}else if(m==2){
			maxdays=28;
		}else{
			maxdays=31;
		}

		if( (m<1 || m > 12) || (d > maxdays) || (y <= 1900)){
			alert("Invalid Date. Please check the date you entered.");
			if(thisObj.type.toLowerCase() != "hidden"){
				setTimeout(function(){
					thisObj.focus();
				}, 2);
			}
			return false;
		}else{
			return true;
		}
	}else if(thisObj.value != ""){
		alert("Invalid Date. Must be in the form mm/dd/yyyy " + thisObj.name);
		if(thisObj.type.toLowerCase() != "hidden"){
			setTimeout(function(){
				thisObj.focus();
			}, 2);
		}
		return false;
	}
}

function jm_valid8Num(thisObj){ //v1.0 | Positive Number Validation
	if (thisObj.value != ""){
	//alert(parseFloat(thisObj.value));
	//alert(isNaN(thisObj.value));
		if(isNaN(thisObj.value) || thisObj.value.indexOf(" ") > -1){
			alert("You must enter a number.");
			setTimeout(function(){
				thisObj.focus();
			}, 8);
			return false;
		}else{
			return true;
		}
	}
	//return true;
}

function jm_valid8Zip(thisObj){ //v2.0 | Zipcode Validation
//alert(/(^\d{5}$)|(^\d{5}-\d{4}$)/.test(thisObj.value));
	if(/(^\d{5}$)|(^\d{5}-\d{4}$)/.test(thisObj.value) || thisObj.value == ""){
		return true;
	}else{
		alert("Invalid Zipcode!\nA valid Zipcode is formatted: 000000 or 00000-0000.\nPlease re-enter your zipcode.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}
}

function jm_valid8Pass(thisObj,formObj){ //v1.0 | Re-Enter Password Verification
	var error=0;
	var i="";
	for(i=0;i<formObj.length;i++){
		var evalObj=formObj.elements[i];

		if(evalObj.name.toLowerCase().indexOf('password2')>0){
			if(evalObj.value==thisObj.value && thisObj.value!=''){
				error=0;
			}else{
				error=1;
			}
		}
	}
	if(error>0){
		alert("Your passwords do not match. Please re-enter your passwords.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}else{
		return true;
	}
}

function jm_valid8Chars(thisObj){ //v1.0 | Disallow Special Characters
	if(/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\<\>\?\,\.]/.test(thisObj.value)){
		alert("You can not enter punctuation of any kind into this field.\nPlease remove all punctuation.");
		setTimeout(function(){
			thisObj.focus();
		}, 2);
		return false;
	}else{
		return true;
	}
}

function jm_valid8USPhone(thisObj){ //v1.2 | US Phone Validation
	var objLen=thisObj.value.length;
	var testObj=thisObj.value;
	var extStart="";
	if(thisObj.value.toLowerCase().indexOf('ext')>0){ //Test for EXT
		extStart=thisObj.value.toLowerCase().indexOf('ext')-1;
		testObj=thisObj.value.toLowerCase().substring(0,extStart);
	}

	if(/^\(?\d{3}\)?(\-|\s)\d{3}(\-|\s)\d{4}$/.test(testObj) || testObj == ""){
		return true;
	}else{
		alert("Invalid Phone Number. Must be 10 digits or in the format:\n000-000-0000 or (000) 000-0000 ext. 000");
		if(thisObj.type != "hidden"){
			setTimeout(function(){
				thisObj.focus();
			}, 2);
		}
		return false;
	}

}

function jm_valid8Form(formObj){ //v2.3 | Complete Form Validation Script
	
	// Optional boolean 2nd argument that will validate the form in the background but not alert the user - SG 05/07/2008
	var bSuppressAlerts = (arguments.length > 1)?arguments[1]:false;

	var error=0;
	var i="";j="";
	for(i=0;i<formObj.length;i++){
		// Set Object Variables
		var thisObj=formObj.elements[i];
		var objTagName = thisObj.tagName.toLowerCase();

		// Bypass Form Validation if Element is a FieldSet Object
		// And bypass validation if element is hidden by display="none" in a tr or tbody 3/15/2012 - CG
		try {
			if(thisObj.parentNode.parentNode.style.display.toLowerCase()=="none" || thisObj.parentNode.parentNode.parentNode.style.display.toLowerCase()=="none") {
			var passThrough="no"; 
			}
			else {
			var passThrough="yes";
			}
		}
		catch(err) {
			var passThrough="yes";
		}
		if(objTagName != "fieldset" && objTagName != "embed" && passThrough.toLowerCase() == "yes"){
			var objName=thisObj.name.toLowerCase();
			var objType=thisObj.type.toLowerCase();
			var objLen=thisObj.name.length;

			// Set Validation Arrays.
			var v=new Array;
			var f=new Array;
			v[0]="email";
			f[0]="!jm_valid8Email(thisObj)";
			v[1]="ssn_";
			f[1]="!jm_valid8SSN(thisObj)";
			v[2]="posint";
			f[2]="!jm_valid8Num(thisObj)";
			v[3]="ccexp_";
			f[3]="!jm_valid8CCExpDate(thisObj)";
			v[4]="date";
			f[4]="!jm_valid8Date(thisObj)";
			v[5]="ccnum";
			f[5]="!jm_valid8CCNum(thisObj)";
			v[6]="zipcode";
			f[6]="!jm_valid8Zip(thisObj)";
			v[7]="password";
			f[7]="!jm_valid8Pass(thisObj,formObj)";
			v[8]="spchars";
			f[8]="!jm_valid8Chars(thisObj)";
			v[9]="vphone";
			f[9]="!jm_valid8USPhone(thisObj)";
			v[10]="nohtml";
			f[10]="!jm_stripHTML(thisObj)";
			v[11]="basichtml";
			f[11]="!jm_basicHTML(thisObj)";
			v[12]="vfax";
			f[12]="!jm_valid8USPhone(thisObj)";
			v[13]="url";
			f[13]="!jm_valid8Url(thisObj)";
			v[14]="ipaddress";
			f[14]="!jm_valid8IP(thisObj)";
			v[15]="_ssn";
			f[15]="!jm_valid8SSN(thisObj)";

			// Validate without Require Functionality
			var required="n";
			var validate="n";
			var objName="";
			if(thisObj && (thisObj.name.toLowerCase().substring(0,9)=="required_")){
				objName=""+thisObj.name.toLowerCase().substring(9,objLen);
				required="y";validate="y";
			}else if(thisObj && (thisObj.name.toLowerCase().substring(0,7)=="valid8_")){
				objName=""+thisObj.name.toLowerCase().substring(7,objLen);
				validate="y";
			}

			// Field-Test Routine
			if(required=="y" || validate=="y"){

				// Begin NULL and CONTENT Validation
				if((objType=="text" || objType=="textarea" || objType=="hidden")&& (thisObj.name.toLowerCase().indexOf('_other') == -1)){

					// Validation Routine
					for(j=0;j<v.length;j++){
						if((v[j] == "date" && (objName.indexOf('_month') > -1 || objName.indexOf('_day') > -1 || objName.indexOf('_year') > -1) || objName.indexOf('_mess') > -1)){
						}else if((objName.indexOf(''+v[j]+'')>=0)){
								if(required=="y"){// Require & Validate
									if(eval(f[j])){// Validate
										if(v[j] == "date" && thisObj.value.substr(0,10) == "01/01/1900"){
											error=1;
											break;
										}else{
											error=2;
											break;
										}
									}
								}else if(validate=="y" && required=="n" && thisObj.value!=""){// Validate Only
									if(eval(f[j])){// Validate
										if(v[j] == "date" && thisObj.value.substr(0,10) == "01/01/1900"){
											error=1;
											break;
										}else{
											error=2;
											break;
										}
									}
								}
						}else if(jm_trim(thisObj.value)=="" && required=="y"){// Require Only
							error=1;
							break;
						}
					}
				// Begin NULL validation on non-text fieldtypes.
				}else if((((objType=="select-one") && (thisObj.selectedIndex <= 0)) || ((objType=="select-multiple") && (thisObj.selectedIndex == -1)))){
						error=1;
				}else if((objType=="checkbox" || objType=="radio")){
					var tmpName="formObj."+thisObj.name;
					var tmpObj=eval(tmpName);
					for(j=0;j<tmpObj.length;j++){
						if(tmpObj[j].checked == false){
							error=1;
						}else{
							error=0;
							break;
						}
					}
				}
				// Error Output.
				if(error==1 && !bSuppressAlerts){
					var messName="formObj."+thisObj.name+"_mess"; // No case conversion
					var messNameL="formObj."+objName+"_mess"; // All lowercase

					//alert(messName);

					if(eval(messName)){
						alert(eval(messName).value);// Custom Error Message
					}else if(eval(messNameL)){
						alert(eval(messNameL).value);// Custom Error Message
					}else{
						alert("You must fill out the "+objName.toUpperCase()+" field.");// Default Error Message
					}
					jm_highLightField(thisObj,formObj);
					return false;
					break;
				}else if(error==2 && !bSuppressAlerts){
					jm_highLightField(thisObj,formObj);
					return false;
					break;
				}
				else if((error==1 || error==2) && bSuppressAlerts){
					return false;
					break;
				}
			}
		}
	}
	return true;
}

// this function calls jm_valid8Form(), but it also disables all elements that are passed in to the function
// example: cn_valid8Form(this,document.getElementById('submit1'),document.getElementById('submit2'));
// note: be careful not to disable any form elements that your submit page is going to rely on
function cn_valid8Form(formObj) {
	if(jm_valid8Form(formObj)) {
		for(i=1;i<arguments.length;i++) {
			arguments[i].disabled=true
		}
		return true;
		//formObj.submit();
	}
	else {
		return false;
	}
}

function jm_compareDrop(formObj){ //v1.0 | Compares select boxes for the same value. Alert on match.
	var err="n";
	var thisArray=new Array();
	for(i=0;i<formObj.elements.length;i++){
		objSelect=formObj.elements[i];
		if(objSelect.type.toLowerCase() == "select-one" || objSelect.type.toLowerCase() == "select-multiple"){
			thisArray[i]=objSelect.options[objSelect.selectedIndex].value;
		}
	}
	for(i=0;i<thisArray.length;i++){
		for(j=0;j<thisArray.length;j++){
			if(thisArray[i]==thisArray[j] && i!=j){
				var err="y";
			}
		}
	}
	if(err=="y"){
		alert("You selected the same value twice.");
	}
}

function jm_compareFields(formObjA,formObjB,mess){//v1.0 | Compares text fields for the same value. Alert on Different.
	if(eval(formObjA).value!=eval(formObjB).value){
		alert(""+mess+"");
	}
}

function jm_cookieDetect(form,frame){ //v1.0 | Cookie Detection Function
	document.cookie = 'killme' + escape('nothing')
	if (document.cookie == ""){
		document.form.frame.value ="Disabled";
	} else {
		document.form.frame.value ="Enabled";
	}
}

function jm_jsDetect(form,field){ //v1.0 | JavaScript Detection Function
	document.form.field.value ="Enabled";
}

function jm_getStats(){ //v1.0 | Screen Properties Function
	colorDepth=screen.colorDepth;
	screenWidth=screen.width;
	screenHeight=screen.height;
}


function jm_highLightField(thisObj,formObj){ //v1.1 | FormField Highlight on Validation Error
	var i=0;
	var agt=navigator.userAgent.toLowerCase();
	if(agt.toLowerCase().indexOf('msie') != -1 ||
	   agt.toLowerCase().indexOf('gecko') != -1 ||
	   agt.toLowerCase().indexOf('icab') != -1){

		// Loop and remove display for everything but thisObj
		for(i=0;i<formObj.length;i++){
			var tmpObj=formObj.elements[i];
			if(tmpObj!=thisObj && tmpObj.style){
				tmpObj.style.backgroundColor='';
				tmpObj.title="";
			}
		}
		if(thisObj.type.toLowerCase()!="hidden"){
			thisObj.style.backgroundColor='ffffee';
			thisObj.title="Form Entries Invalid!";
			if(thisObj.type.toLowerCase()!="hidden"){
				setTimeout(function(){
					thisObj.focus();
				}, 2);
			}else{
				setTimeout(function(){
					formObj.elements[formObj.elements[thisObj]-1].focus();
				}, 2);	
			}
		}
		return false;
	}else{
		return false;
	}
}

function jm_jumpForm(thisObj){ //v1.0 | Select Navigation
	document.location.href=thisObj.options[thisObj.selectedIndex].value;
}

function jm_confirmSubmit(mess){ //v1.0 | Confirm Delete
var agree=confirm(mess);
	if(agree){
		return true ;
	}else{
		return false ;
	}
}

function jm_onlyValidChars(string,valid) { //v1.0 | Only Allow Valid Characters
    for (var i=0, output=''; i<string.length; i++)
       if (valid.indexOf(string.charAt(i)) != -1)
          output += string.charAt(i)
    return output;
}

function jm_checkBoxes(formObj) { //v1.1 | Checks ALL Form Boxes in a form.
	// v1.1 Added Uncheck Function
	if (document.all || document.getElementById()) {
		for (i = 0; i < formObj.length; i++) {
			var tempobj = formObj.elements[i];
			if (tempobj.type.toLowerCase() == "checkbox"){
				if(tempobj.checked == true){
					tempobj.checked = false;
				}else{
					tempobj.checked = true;
				}
			}
		}
		return true;
		}
	else {
	return false;
	}
}

function jm_escapeChars(thisObj){ //v1.0 | Encode Special Characters
	if (/[$\\@\\\#%\^\&\*\(\)\[\]\+\_\{\}\`\~\=\|\<\>\?\,\.]/.test(thisObj.value)){
		thisObj.value=escape(thisObj.value);
		return true;
	}
}

function jm_basicHTML(thisObj){ //v1.1 | Allows Basic HTML Only (b,i,u,p,br,hr)
	if (/(<[\/]?([bpua])|(br|hr)|([i$])[\/]?>)/.test(thisObj.value)){
		return true;
	}else{
		alert("Only <b>, <i>, <u>, <br>, <hr> and <p> tags are allowed in this field.");
		return false;
	}
}

function jm_stripHTML(thisObj){ //v1.0 | Strip HTML
	if (/[<[0-9a-z^a-z=.,"\/#%*@!:]+>|&[a-z]+]/.test(thisObj.value)){
		alert("No HTML is allowed in this field.");
		return false;
	}else{
		return true;
	}
}

function jm_guiButtonHover(formObj,brdr,brdrcolor){ //v1.0 | Button Hover
	formObj.style.border=brdr;
	formObj.style.borderColor=brdrcolor;
}

function jm_trim(string){ //v1.0 | TRIM whitespace function.
	try{
		string = string.replace(/^[\s]+/g,"");
		string = string.replace(/[\s]+$/g,"");
	}
	catch(e){
	}
	return string;
}

function js_trimField(fld){
	var str = fld.value;
	fld.value = jm_trim(str);
}

function sf_export2Excel(a,b){ //v1.0 | Drives the "Export to Excel" function in DHD
	if (b > 1){
		var p = 0;
		if (parseInt(b) < parseInt(a)){
			var tmpa=b-1;
		}else{
			var tmpa=a-1;
		}

		for (var i=0;i<=tmpa;i++){
			if((document.myform.excel[i].checked) == true){
				p=1;
				break;
			}
		}

		if (p == 0){
			alert('You must select at least 1 record in order to export data to Excel.');
		}else{
			document.myform.submit();
		}

	}else{
		document.myform.excel.checked = true;
		document.myform.submit();
	}
}

function jm_export2Excel(u,n,f){
	/*
	 ******************************
	 * u = URL
	 * n = Key Name
	 * f = FormObject
	 * p = Path (Non-required argument)
	 * jm_export2Excel('key','table',myform,'server','domainID');
	 ******************************
	 */

	var len = f.elements.length;
	var i=0;
	var k="0";
	var p="";
	if(arguments.length > 3){
		p = arguments[3];
	}
	
	for(i=0;i<len;i++) {
		if(f.elements[i].name.toLowerCase()==n.toLowerCase()){
			if(f.elements[i].checked==1){
				k=k + "," + f.elements[i].value;
			}
		}
	}
	
	
	if(k.length > 1){
		jm_popWinU(p+'activereport.cfm?mime=application/x-msexcel&cdoc=' +u+ '~sysact=1~step=export~k=' +k+ '','Export2Excel','width=300,height=200,scrollbars=1,resizable=1,menubar=1');
	} else {
		alert("You must select at least 1 record in order to export data to Excel.");
	}
}

function cn_export2Excel(u,n,f) {
	var elementsChecked=0;
	var p = "";
	if(arguments.length > 3){
		p = arguments[3];
	}
	for(var i=0;i < f.elements.length;i++){
		if(f.elements[i].name.toLowerCase() == n.toLowerCase()){
			if(f.elements[i].checked){
				elementsChecked++;
				break;
			}
		}
	}
	if(elementsChecked == 0){
		alert("You must select at least 1 record in order to export data to Excel.");
		return false;	
	}
	
	var prevTarget = f.target;
	var prevAction = f.action;
	
	window.open('','Export2Excel','width=300,height=200,scrollbars=1,resizable=1,menubar=1');
	f.target="Export2Excel";
	f.action=p+"activereport.cfm?mime=application/x-msexcel&cdoc="+u+"~sysact=1~step=export&pk="+n;
	f.submit();
	
	f.target = prevTarget;
	f.action = prevAction;
}

function jm_export2Mailinglabel(u,n,f){
	/*******************************
	* u = URL
	* n = Key Name
	* f = FormObject
	* jm_export2Mailinglabel('key','table',myform);
	*******************************/
	var len = f.elements.length;
	var i=0;
	var k="0";
	for(i=0;i<len;i++) {
		if(f.elements[i].name.toLowerCase()==n.toLowerCase()){
			if(f.elements[i].checked==1){
				k=k + "," + f.elements[i].value;
			}
		}
	}
	if(k.length > 1){
		window.open(u+'?k='+k+'&n='+n,'Export2Mailing','left=20,top=20,width=700,height=450,toolbar=1,resizable=1,scrollbars=1');
	}else{
		alert("You must select at least 1 record in order to export to mailing label.");
	}
}

function disableEnter(e){
	 /*
	 ******************************
	 * Disables the enter key from submitting a form
	 * onkeypress="return disableEnter(event);"
	 ******************************
	 */
    var c = document.all? event.keyCode : e.which;
    
	//excluded textarea from returning false so you can still press Enter within the textarea 
	if(c == 13 && window.event.srcElement.tagName.toLowerCase() != "textarea") return false;
    // issue 28893.  Comment out return true since we are only concerned with this function returning false.  Also fixes bug on type aheads in state of colorado firm manager (tool_sco_firms.cfm)
    //return true;
}

function SetChecked(obj,b) {
	len= document.myform.elements.length;
	var i=0;
	for(i=0;i<len;i++){
		if(document.myform.elements[i].name==b) {
			document.myform.elements[i].checked = obj.checked;
			if(obj.checked == 0){
				obj.title="Check All";
			}else{
				obj.title="Clear All";
			}
		}
	}
}

function jm_searchBox(obj){
	if(obj.value == ""){
		obj.value = "[keyword]";
	}else if(obj.value == "[keyword]"){
		obj.value = "";
	}
}

function jm_viewFilter(){
	var len = jm_viewFilter.arguments.length;
	var urlstring = "?";
	for(i=0;i<len;i++){
		if(i>0){urlstring = urlstring + "&";}
		try{
			//issue 99476.  bug fix on multi-select filters
			if(jm_viewFilter.arguments[i].type == 'select-multiple') {
				t = new Array();
				for(j=0;j<jm_viewFilter.arguments[i].length;j++) {
					
					if(jm_viewFilter.arguments[i].options[j].selected) {
						t.push(jm_viewFilter.arguments[i].options[j].value);
					}
				}
				t = t.toString();
			}
			else {
				t = new String(jm_viewFilter.arguments[i].value);
			}
			
			
			t = t.replace(/&/g,"%26");
			urlstring = urlstring + "" + jm_viewFilter.arguments[i].name + "=" + t + "";
			urlstring = urlstring + "&setpref=1";
		}
		catch(e){
			//Error Thrown
		}
	}

	try{
		// if the searchForm doesn't exist, don't bomb out.  If so then pass the current values of the search options through when using drill downs.
		if(!document.searchForm.strSearch || document.searchForm.strSearch.value == '' || document.searchForm.strSearch.value == "[keyword]"){
			var temp=0;
		}else{
			if(urlstring != "?"){
				urlstring += "&";
			}
			urlstring = urlstring + "strSearch=" + document.searchForm.strSearch.value.replace(/&/g,"%26");
		}
		if(!document.searchForm.relevance){
			var temp=0;
		}
		else if(document.searchForm.relevance.selectedIndex == 0){
			if(urlstring != "?"){
				urlstring += "&";
			}
			urlstring = urlstring + "relevance=ANY";
		}
		else{
			if(urlstring != "?"){
				urlstring += "&";
			}
			urlstring = urlstring + "relevance=" + document.searchForm.relevance.options[document.searchForm.relevance.selectedIndex].value;
		}
	}
	catch(f){
		//Error Thrown
	}
	jm_navig8(urlstring);
}

function jm_relatedData(thisObj){
	page = thisObj.options[thisObj.selectedIndex].value;
	jm_navig8(page);
}

function jm_clickDelete(){
	if(!jm_confirmSubmit('Are you sure you want to delete these records?\nThis operation can not be undone.')){
		return false;
	}else{
		document.myform.tdelete.value=1;
		document.myform.submit();
		return true;
	}
}

function jm_collapse(a){
	if(document.getElementById(""+a).style.display == "block"){
		document.getElementById(""+a).style.display = "none";
	}else{
		document.getElementById(""+a).style.display = "block";
	}
}

function as_panelRemoveRecord(url,item){
	if (!item){
		item='Record';
		}
	if (confirm('Delete this '+ item + '?')==true){
		this.location=url;
		}else{
	return;
	}
}

function jm_relatedData(thisObj){
	page = thisObj.options[thisObj.selectedIndex].value;
	jm_navig8(page);
}

function jm_jumpToForm(pgval,fobj){
	document.myform.tmppg.value = pgval.options[pgval.selectedIndex].value;
	fobj.submit();
}

function jb_formatNumber(expr, decimals) {
	var str = "" + Math.round( eval(expr) * Math.pow(10,decimals))
	while (str.length <= decimals) { str = "0" + str } // maybe add some leading zeros
	var decpoint = str.length - decimals // find location of decimal point
	var result = str.substring(0,decpoint);
	if (decimals) result += "." + str.substring(decpoint,str.length);
	return result;
}

function lengthFocus(thisObj,thisLength,nextObj) {
	if (thisObj.value.length == thisLength) {
		setTimeout(function(){
			nextObj.focus();
		}, 2);
	}
}


/*
* Left
* Arguments:
	* str: String to use
	* cnt: Number of characters to get
* Description: Gets a specified number of characters on
			   The left side of a string
*/

function left(str,cnt){
	var len = str.length;
	var thisStr = str.toString();
	var thisCnt = cnt;
	thisStr = thisStr.substr(0,thisCnt);
	return thisStr;
}

/*
* Right
* Arguments:
	* str: String to use
	* cnt: Number of characters to get
* Description: Gets a specified number of characters on
			   The right side of a string
*/

function right(str,cnt){
	var thisLen = str.toString().length;
	var thisStr = str.toString();
	var thisCnt = thisLen - cnt;
	thisStr = thisStr.substr(thisCnt,thisLen);
	return thisStr;
}

/*
* Adds an option to a drop down
* Example Call: addSelect('One',1,myform.testField,0);
* ------ Changes -----
	03/21/2007 - Added argument 'd':
					Set this to true in order for the
					addSelect method not to add a duplicate
					value
				Added argument 's':
					After adding the new option it will select
					it in the drop down
*/

function addSelect(t,v,f,p,d,s,c) {// t = text, v = value, f = field, p = position (0-length of options), d = duplicates, s = selected, c = css styles to apply using JSON array (i.e. [{'propery':'color','value':'#990000'},{'property':'fontSize','value':'11px;'}])
	duplicateFound = false;
	selectIt = false;
	var CSS = [];
	if(arguments.length > 3){
		p = (isNaN(arguments[3]))?0:arguments[3]; // the higher the position number, the farther down on the drop down it is
		removeDups = (arguments.length > 4)?arguments[4]:false;
		selectIt = (arguments.length > 5)?arguments[5]:false;
		CSS = (arguments.length > 6)?arguments[6]:CSS;
	}
	else{
		p = 0;
		removeDups = false;
	}
	if(removeDups){
		for(i=0;i<f.options.length;i++){
			if(v==f.options[i].value){
				duplicateFound = true;
			}
		}
	}
	if(!duplicateFound){
		newSelect = new Option();
		newSelect.text = t;
		newSelect.value = v;
		
		// Apply CSS styles now
		if(CSS.length > 0){
			for(var i=0;i < CSS.length;i++){
				eval("newSelect.style." + CSS[i].property + " = '" + CSS[i].value + "'");
			}
		}
		
		f.add(newSelect, p);
		if(selectIt){
			f.options[p].selected = true;
		}
	}
}

/*
* Wipes out all options from a drop down
* Example Call: clearSelect(myform.testField);
*/

function clearSelect(f) {
	f.options.length = null;
}

/***********************************************
* Remove Select
* Arguments:
	* fld: Field/dropdown to use
	* idx: Index of item to delete
	* numItems: Number of items to delete from the
				index foward (optional - defaults to 1)
* Description: Deletes an option out of a drop-down
				menu based upon an index and updates
				the rest of the options dynamically
	------------ Change Log ------------
	03/21/2007 - Added argument:
					*removeVal: This is a boolean value
								that when set to true the
								value passed to the idx argument
								will be used to remove an option
								with that value instead of an
								option with that index
***********************************************/
function removeSelect(fld,idx,removeVal,numItems){
	// Check to see if the removal is value based not index based
	val2Remove = (arguments.length>2)?arguments[2]:false;
	// Check to see if number of items argument was passed
	rmv = (arguments.length>3)?arguments[3]:1;
	removeIndex = (arguments.length>2)?((arguments[2]==true)?-1:idx):idx;
	// set up two arrays for text and value of the drop down
	// this will be used to re-populate the dropdown later
	valueArray = new Array;
	textArray = new Array;
	// populate the above arrays with dropdown options
	for(i=0;i<fld.options.length;i++){
		valueArray[i] = fld.options[i].value;
		textArray[i] = fld.options[i].text;
		if(val2Remove && idx == valueArray[i]){
			removeIndex = i;
		}
	}
	// check to see if an option is supposed to be removed
	// remove the specified option (value and text) from the array
	if(removeIndex!=-1){
		valueArray.splice(removeIndex,rmv);
		textArray.splice(removeIndex,rmv);
	}
	// wipe out the drop down
	clearSelect(fld);
	// start rebuilding the dropdown
	for(i=0;i<valueArray.length;i++){
		addSelect(textArray[i],valueArray[i],fld,i);
	}
}

/***********************************************
* Below are list manipulating functions just like in ColdFusion
	NOTE:
	The functions work like ColdFusion in terms
	of indexes - The first item in the list has
	an index of 1
		Examples:
			myList = 'A,B,C';
			listGetAt(myList,1) = 'A';
			newList = listDeleteAt(myList,1);
			newList = 'B,C';
***********************************************/

/***********************************************
* List Append
* Arguments:
	* l: List to append to
	* v: Value to append
	* d: Delimeter (defaults to comma)
* Description: Adds a value to the end of a list
***********************************************/

function js_listAppend(l,v,d){
	var LA_thisList = '';
	try{
		if(arguments.length > 2){
			if(arguments[2] == ''){
				var LA_delim = ',';
			}
			else{
				var LA_delim = d;
			}
		}
		else{
			var LA_delim = ',';
		}
		if(l != ""){
			LA_thisList += l.toString() + LA_delim.toString() + v.toString();
		}
		else{
			// Since the first check to this function checks against an empty string, the first
			// element must NOT be empty
			if(v==""){
				v=" ";
			}
			LA_thisList += v.toString();
		}
	}
	catch(e){
		LA_thisList = l;
	}
	return LA_thisList;
}

/***********************************************
* List Prepend
* Arguments:
	* l: List to prepend to
	* v: Value to prepend
	* d: Delimeter (defaults to comma)
* Description: Adds a value to the beginning of a list
***********************************************/

function js_listPrepend(l,v,d){
	var LP_thisList = '';
	if(arguments.length > 2){
		if(arguments[2] == ''){
			var LP_delim = ',';
		}
		else{
			var LP_delim = d;
		}
	}
	else{
		var LP_delim = ',';
	}
	if(l != ""){
		LP_thisList += v.toString() + LP_delim.toString() + l.toString();
	}
	else{
		// Since the first check to this function checks against an empty string, the first
		// element must NOT be empty
		if(v==""){
			v=" ";
		}
		LP_thisList += v.toString();
	}
	return LP_thisList;
}

/***********************************************
* List Length
* Arguments:
	* l: List to get the length of
	* d: Delimeter (defaults to comma)
* Description: Get the length of a list
***********************************************/

function js_listLen(l,d){
	var LL_thisList = '';
	if(arguments.length > 1){
		if(arguments[1] == ''){
			var LL_delim = ',';
		}
		else{
			var LL_delim = d;
		}
	}
	else{
		var LL_delim = ',';
	}
	LL_thisList = l.split(LL_delim);
	var LL_listLen = LL_thisList.length;

	return LL_listLen;
}

/***********************************************
* List Get At
* Arguments:
	* l: List to use
	* p: Position to get at (first element has index of 1)
	* d: Delimeter (defaults to comma)
* Description: Get an element in a list at a given position
***********************************************/

function js_listGetAt(l,p,d){
	if(arguments.length > 2){
		if(arguments[2] == ''){
			var LGA_delim = ',';
		}
		else{
			var LGA_delim = d;
		}
	}
	else{
		var LGA_delim = ',';
	}
	var LGA_pos = p - 1;
	var LGA_thisList = l.split(LGA_delim);
	var LGA_thisItem = LGA_thisList[LGA_pos];

	return LGA_thisItem;
}

/***********************************************
* List Delete At
* Arguments:
	* l: List to use
	* p: Position to delete at (first element has index of 1)
	* d: Delimeter (defaults to comma)
* Description: Delete an element in a list at a given position
***********************************************/

function js_listDeleteAt(l,p,d){
	if(arguments.length > 2){
		if(arguments[2] == ''){
			var LDA_delim = ',';
		}
		else{
			var LDA_delim = d;
		}
	}
	else{
		var LDA_delim = ',';
	}
	var LDA_pos = p - 1;
	var LDA_thisList = l.split(LDA_delim);
	var LDA_newList = "";
	var LDA_thisLen = LDA_thisList.length;
	for(i=0;i<LDA_thisLen;i++){
		if(LDA_thisList[i] != LDA_thisList[LDA_pos]){
			LDA_newList = js_listAppend(LDA_newList,LDA_thisList[i],LDA_delim);
		}
	}
	return LDA_newList;
}

/***********************************************
* List Qualify
* Arguments:
	* l: List to use
	* q: Qualifyer
	* d: Delimeter (defaults to comma)
* Description: Surrounds each value of a list with
			   What is passed in as the qualifyer
***********************************************/

function js_listQualify(l,q,d){
	if(arguments.length > 2){
		if(arguments[2] == ''){
			var LQ_delim = ',';
		}
		else{
			var LQ_delim = d;
		}
	}
	else{
		var LQ_delim = ',';
	}
	var newQualifier = q.toString();
	var LQ_thisList = l.split(LQ_delim);
	var LQ_newList = "";
	var LQ_thisLen = LQ_thisList.length;
	var newVal="";
	for(i=0;i<LQ_thisLen;i++){
		newVal = newQualifier + LQ_thisList[i] + newQualifier;
		LQ_newList = js_listAppend(LQ_newList,newVal,LQ_delim);
	}
	return LQ_newList;
}

/***********************************************
* List Find No Case
* Arguments:
	* l: List to use
	* v: Value to find
	* d: Delimeter (defaults to comma)
* Description: Searches for a value in a list (non-case sensative)
***********************************************/

function js_listFindNoCase(l,v,d){
	if(arguments.length > 2){
		if(arguments[2] == ''){
			var LFN_delim = ',';
		}
		else{
			var LFN_delim = d;
		}
	}
	else{
		var LFN_delim = ',';
	}
	var LFN_thisList = l;
	var LFN_foundIt = 0;

	try{
		for(LFN_i=0;LFN_i<js_listLen(LFN_thisList,LFN_delim);LFN_i++){
			var LFN_pos = LFN_i + 1;
			if(js_listGetAt(LFN_thisList,LFN_pos,LFN_delim).toString().toLowerCase() == v.toString().toLowerCase()){
				LFN_foundIt = LFN_pos;
			}
		}
	}
	catch(e){
		//alert(e.description + "\n" + l + "\n" + v);
	}
	return LFN_foundIt;
}

/***********************************************
* Array to List
* Arguments:
	* a: Array to convert
	* d: Delimeter (defaults to comma)
	* o: This extra option gives the capability to only append
		selected/checked options from the form field into the list.
		To append only checked items from a checkbox: js_arrayToList(myform.box,",","checked");
		To append only selected items in a dropdown: js_arrayToList(myform.select,",","selected");
		js_arrayToList(myform.box) will pull all values in the collection as will
		js_arrayToList(myform.select) will pull all options in the dropdown
* Description: Converts a Javascript array to a list
***********************************************/

function js_arrayToList(a,d,o){
	try{
		if(arguments.length > 1){
			if(arguments[1] == ''){
				var A_delim = ',';
			}
			else{
				var A_delim = d;
			}
			var A_extra = "";
			if(arguments.length > 2){
				if(arguments[2].toString().toLowerCase()=="checked"||arguments[2].toString().toLowerCase()=="selected"){
					A_extra = o.toString().toLowerCase();
				}
			}
		}
		else{
			var A_extra = "";
			var A_delim = ",";
		}
		var A_thisList = "";
		if(a.length == undefined){
			if( a.toString().toLowerCase().indexOf("object") > -1 ){
				if(A_extra == ""){
					A_thisList = js_listAppend(A_thisList,a.value,A_delim);
				}
				else if(eval("a." + A_extra)){
					A_thisList = js_listAppend(A_thisList,a.value,A_delim)
				}
			}
			else{
				A_thisList = js_listAppend(A_thisList,a,A_delim);
			}
		}
		else{
			for(A=0;A < a.length;A++){
				// Validate against to find an object so a collection of checkboxes or dropdown
				// can be passed in as well as a traditional array
				if( a.toString().toLowerCase().indexOf("object") > -1 ){
					if(A_extra==""){
						A_thisList = js_listAppend(A_thisList,a[A].value,A_delim);
					}
					else if(eval("a["+A+"]."+A_extra)){
						A_thisList = js_listAppend(A_thisList,a[A].value,A_delim)
					}
				}
				else{
					A_thisList = js_listAppend(A_thisList,a[A],A_delim);
				}
			}
		}
		return A_thisList;
	}
	catch(e){}
}

/***********************************************
* List to Array
* Arguments:
	* l: List to convert
	* d: Delimeter (defaults to comma)
* Description: Converts a list array to a Javascript Array
***********************************************/

function js_listToArray(l,d){
	if(arguments.length > 1){
		if(arguments[1] == ''){
			var LTA_delim = ',';
		}
		else{
			var LTA_delim = d;
		}
	}
	else{
		var LTA_delim = ',';
	}
	var LTA_thisList = l;
	var LTA_thisArray = new Array;
	for(LTA=0;LTA<js_listLen(LTA_thisList,LTA_delim);LTA++){
		var LTA_pos = LTA + 1;
		LTA_thisArray[LTA] = js_listGetAt(LTA_thisList,LTA_pos,LTA_delim);
	}
	return LTA_thisArray;
}

/***********************************************
* List to Array
* Arguments:
	* l: List to search
	* o: String to find occurance of
	* d: Delimeter (defaults to comma)
* Description: Finds how out how many times a value
				is listed in a list - the search is
				case insensative
***********************************************/

function js_listOccurance(l,o,d){
	if(arguments.length > 2){
		if(arguments[2] == ''){
			var LO_delim = ',';
		}
		else{
			var LO_delim = d;
		}
	}
	else{
		var LO_delim = ',';
	}
	var LO_thisList = l;
	var LO_find = o.toString().toLowerCase();
	var LO_occurance = 0;
	for(LO=1;LO<=js_listLen(LO_thisList,LO_delim);LO++){
		if(js_listGetAt(LO_thisList,LO,LO_delim).toString().toLowerCase()==LO_find){
			LO_occurance++;
		}
	}
	return LO_occurance;
}

/***********************************************
* Array Sort
* Arguments:
	* a: Array
	* s: Sort direction
* Description: Sorts an array 1-Z
				(i.e. a[0]=1,a[1]=5,a[2]=E,a[3]=J)
***********************************************/

function js_arraySort(a,s){
	var AS_returnArray=new Array;
	var AS_sort=(arguments.length > 1)?((arguments[1].toLowerCase().indexOf("a")>-1)?"ASC":"DESC"):"ASC";
	var AS_innerObj={
		AS_innerFunc: function(a,b){
			var A = a.toLowerCase();
			var B = b.toLowerCase();
			var C = (AS_sort=="ASC")?-1:1;
			var D = (AS_sort=="ASC")?1:-1;
			// Sort numerically
			if((A - B).toString()!="NaN") return (C==-1)?A-B:B-A;
			// Sort alphabetically
			if (A < B) return C;
			if (A > B) return D;
			return 0;
		}
	};
	AS_returnArray = a.sort(AS_innerObj.AS_innerFunc);
	return AS_returnArray;
}

/***********************************************
* List Sort
* Arguments:
	* l: List to sort
	* s: Sort direction
	* d: Delimeter (defaults to comma)
* Description: Sorts a list 1-Z
				(i.e. "1,5,E,J")
***********************************************/

function js_listSort(l,s,d){
	var LS_sort=(arguments.length > 1)?((arguments[1].toLowerCase().indexOf("a")>-1)?"ASC":"DESC"):"ASC";
	var LS_delim=(arguments.length > 2)?((arguments[2]=="")?",":arguments[2]):",";
	var LS_arr=js_arraySort(js_listToArray(l,LS_delim),LS_sort);
	return js_arrayToList(LS_arr,LS_delim);
}


/***********************************************
* Date Compare
* Arguments:
	* d1: Date 1
	* d2: Date 2
	* dF: Date Format:
		Excepts Most Formats:
			'd' - Compares just days
			'm' - Compares just months
			'y' - Compares just years
			'mm/dd' - Compares just the month and days
			'mm/yy' - Compares just the month and year
			'dd/yy' - Compares just the days and year
			'mm/dd/yyyy' - Full date comparison
			* NOTE:
				All date formats are case insensative
				and can be as many or as little characters
				as desired (e.g. 'mm/dd' == 'm/d')
* Description: Returns 1 if d1 > d2, 0 if d1 == d2,
			   -1 if d1 < d2
***********************************************/
function js_dateDiff(d1,d2,dF){	
	/* Declare date variables based on the arguments passed in */
	dateOne = d1;
	dateTwo = d2;
	/* Set Default Format */
	dateFormat = (dF==null)?('m/d/y'):dF.toLowerCase();
	/* Set Defaults */
	m1 = 0;
	m2 = 0;
	d1 = 1;
	d2 = 1;
	y1 = 1970;
	y2 = 1970;
	/* Loop over potential formatting and over-ride above values if formatting matches */
	for(i=1;i<=js_listLen(dateFormat,'/');i++){
		/* Check to see if the current posistion in the format is a month */
		m1 = (js_listGetAt(dateFormat,i,'/').indexOf('m')>-1)?(parseInt(js_listGetAt(dateOne,i,'/'),10)):(m1);
		m2 = (js_listGetAt(dateFormat,i,'/').indexOf('m')>-1)?(parseInt(js_listGetAt(dateTwo,i,'/'),10)):(m2);
		/* Check to see if the current posistion in the format is a day */
		d1 = (js_listGetAt(dateFormat,i,'/').indexOf('d')>-1)?(parseInt(js_listGetAt(dateOne,i,'/'),10)):(d1);
		d2 = (js_listGetAt(dateFormat,i,'/').indexOf('d')>-1)?(parseInt(js_listGetAt(dateTwo,i,'/'),10)):(d2);
		/* Check to see if the current posistion in the format is a year */
		y1 = (js_listGetAt(dateFormat,i,'/').indexOf('y')>-1)?(parseInt(js_listGetAt(dateOne,i,'/'),10)):(y1);
		y2 = (js_listGetAt(dateFormat,i,'/').indexOf('y')>-1)?(parseInt(js_listGetAt(dateTwo,i,'/'),10)):(y2);
	}
	/* Build Dates */
	one_day=1000*60*60*24;
	
	dateOne = new Date(y1,m1,d1).getTime();
	dateTwo = new Date(y2,m2,d2).getTime();
	/* calculate -- this is being compared down to the millisecond */
	days =  Math.ceil((dateOne-dateTwo)/(one_day));	
	return days;
}

/***********************************************
* Date Compare
* Arguments:
	* d1: Date 1
	* d2: Date 2
	* dF: Date Format:
		Excepts Most Formats:
			'd' - Compares just days
			'm' - Compares just months
			'y' - Compares just years
			'mm/dd' - Compares just the month and days
			'mm/yy' - Compares just the month and year
			'dd/yy' - Compares just the days and year
			'mm/dd/yyyy' - Full date comparison
			* NOTE:
				All date formats are case insensative
				and can be as many or as little characters
				as desired (e.g. 'mm/dd' == 'm/d')
* Description: Returns 1 if d1 > d2, 0 if d1 == d2,
			   -1 if d1 < d2
***********************************************/
function js_dateCompare(d1,d2,dF){
	/* Declare date variables based on the arguments passed in */
	dateOne = d1;
	dateTwo = d2;
	/* Set Default Format */
	dateFormat = (dF==null)?('m/d/y'):dF.toLowerCase();
	/* Set Defaults */
	m1 = 0;
	m2 = 0;
	d1 = 1;
	d2 = 1;
	y1 = 1970;
	y2 = 1970;

	/* Loop over potential formatting and over-ride above values if formatting matches */
	for(i=1;i<=js_listLen(dateFormat,'/');i++){
		/* Check to see if the current posistion in the format is a month */
		m1 = (js_listGetAt(dateFormat,i,'/').indexOf('m')>-1)?(parseInt(js_listGetAt(dateOne,i,'/'),10)):(m1);
		m2 = (js_listGetAt(dateFormat,i,'/').indexOf('m')>-1)?(parseInt(js_listGetAt(dateTwo,i,'/'),10)):(m2);
		/* Check to see if the current posistion in the format is a day */
		d1 = (js_listGetAt(dateFormat,i,'/').indexOf('d')>-1)?(parseInt(js_listGetAt(dateOne,i,'/'),10)):(d1);
		d2 = (js_listGetAt(dateFormat,i,'/').indexOf('d')>-1)?(parseInt(js_listGetAt(dateTwo,i,'/'),10)):(d2);
		/* Check to see if the current posistion in the format is a year */
		y1 = (js_listGetAt(dateFormat,i,'/').indexOf('y')>-1)?(parseInt(js_listGetAt(dateOne,i,'/'),10)):(y1);
		y2 = (js_listGetAt(dateFormat,i,'/').indexOf('y')>-1)?(parseInt(js_listGetAt(dateTwo,i,'/'),10)):(y2);
	}
	/* Build Dates */
	
	dateOne = new Date(m1 + "/" + d1 + "/" + y1).getTime();
	dateTwo = new Date(m2 + "/" + d2 + "/" + y2).getTime();

	/* Compare -- this is being compared down to the millisecond */
	dateToReturn = (dateOne==dateTwo)?(0):((dateOne>dateTwo)?(1):(-1));
	/* Return our answer (1,0,-1) */
	return dateToReturn;
}

/***********************************************
* Time Compare
* Arguments:
	* t1: Time 1
	* t2: Time 2
* Description: Returns 1 if t1 > t2, 0 if t1 == t2,
			   -1 if t1 < t2
			   Accepted time formats are:
			      1:00
				  1:00 PM
				  13:00
				  1:00:00
				  1:00:00 PM
				  13:00:00
***********************************************/
function js_timeCompare(t1,t2){
	/* Declare time variables based on the arguments passed in */
	timeOne = t1.toLowerCase();
	timeTwo = t2.toLowerCase();
	/* Set Defaults */
	mo1 = 0;
	mo2 = 0;
	da1 = 1;
	da2 = 1;
	ye1 = 1970;
	ye2 = 1970;
	/* Check to see if AM/PM was passed in -- if not, default to AM */
	a1 = (js_listLen(timeOne,' ')>1)?(js_listGetAt(timeOne,2,' ')):('am');
	a2 = (js_listLen(timeTwo,' ')>1)?(js_listGetAt(timeTwo,2,' ')):('am');
	/* Set Default Hours */
	h1 = parseInt(js_listGetAt(js_listGetAt(timeOne,1,' '),1,':'),10);
	h2 = parseInt(js_listGetAt(js_listGetAt(timeTwo,1,' '),1,':'),10);
	/*
		Lengthy if statement to see if it's PM:
			If true check to see if the hours less than 12:
				If true add 12
				If false default it to the passed in hours
			If false default it to the passed in hours
	*/
	h1 = (a1=='pm')?((h1<12)?(h1+parseInt(12,10)):(h1)):(h1);
	h2 = (a2=='pm')?((h2<12)?(h2+parseInt(12,10)):(h2)):(h2);
	h1 = (a1=='am')?((h1==12)?(0):(h1)):(h1);
	h2 = (a2=='am')?((h2==12)?(0):(h2)):(h2);
	/* Set the value of the minutes */
	m1 = parseInt(js_listGetAt(js_listGetAt(timeOne,1,' '),2,':'),10);
	m2 = parseInt(js_listGetAt(js_listGetAt(timeTwo,1,' '),2,':'),10);
	/* Check to see if seconds was passed in -- if not, default to 0 */
	s1 = (js_listLen(timeOne,':')>2)?(parseInt(js_listGetAt(js_listGetAt(timeOne,1,' '),3,':'),10)):(0);
	s2 = (js_listLen(timeTwo,':')>2)?(parseInt(js_listGetAt(js_listGetAt(timeTwo,1,' '),3,':'),10)):(0);
	/* Build Dates */
	timeOne = new Date(ye1,mo1,da1,h1,m1,s1).getTime();
	timeTwo = new Date(ye2,mo2,da2,h2,m2,s2).getTime();
	/* Compare -- this is being compared down to the millisecond */
	timeToReturn = (timeOne==timeTwo)?(0):((timeOne>timeTwo)?(1):(-1));
	/* Return our answer (1,0,-1) */
	return timeToReturn;
}

/***********************************************
* Name: lib_togglePanel
* Arguments:
	* a: panel to toggle
	* b: name of the image to flip
	* c: alternate location/name of the icon
	* d: image path
* Description: This function toggles a panel and changes the icon
***********************************************/
function lib_togglePanel(a,b,c,d) {
	if (!c)
		c = '';
	if (!d)
		d = '';
	if(document.getElementById(""+a).style.display == "none"){
		document.getElementById(""+a).style.display = "block";
		if (b.length > 0) {
			if (c.length > 0) {
				document.getElementById(""+b).src = c;
			} else {
				document.getElementById(""+b).src = d + "../_icons/arrows/arrow_top_white_nobg.gif";
			}
		}
	} else {
		document.getElementById(""+a).style.display = "none";
		if (b.length > 0) {
			if (c.length > 0) {
				document.getElementById(""+b).src = c;
			} else {
				document.getElementById(""+b).src = d + "../_icons/arrows/arrow_bottom_white_nobg.gif";
			}
		}
	}
}
/***********************************************
* Name: lib_no_future_valid8Date
* Arguments:
* thisObj field name
* Description: Check to see if a value is greater than this moment.
***********************************************/
function lib_no_future_valid8Date(thisObj){
	var ProposedDate = new Date(thisObj.value);
	var Now = new Date();
	if (ProposedDate.valueOf() > Now.valueOf()){
		return false;
	} else {
		return true;
	}
}

/***********************************************
* Name: lib_highlight_row
* Description: highlight alternating rows on mouse over
***********************************************/
function lib_highlight_row(tablerow, back_color, hi_color){
	if (document.getElementById(""+tablerow).style.backgroundColor == hi_color) {
		document.getElementById(""+tablerow).style.backgroundColor = back_color;
	} else {
		document.getElementById(""+tablerow).style.backgroundColor = hi_color;
	}
}
/***********************************************
* Unrequire
* Arguments:
	* bool: Boolean statement of when true unrequires the field
	* f: field to change (pass in string value for ID)
	* lbl: ID of element to change the text color of (the label)
	* rqClass: Class to change the above element to if it's required
	* defClass: Class to change the above element to if it's NOT required
* Description: Sets a field to either required or unrequired
* Example
	<input type="checkbox" name="test"
		onClick="unRequire(this.checked,'testField','row_testField','required','body')">
	<select name="test"
		onChange="unRequire(this.value=='Yes','testField','row_testField','required','body')">

***********************************************/
function unRequire(bool,f,lbl,rqClass,defClass){
	label = (arguments.length>2)?arguments[2]:"";
	requiredClass = (arguments.length>3)?arguments[3]:"required";
	defaultClass = (arguments.length>4)?arguments[4]:"body";
	
	if(bool){
		document.getElementById(f).name = document.getElementById(f).name.toString().replace(/required_/,"");
		if(label!=""){
			document.getElementById(label).className = defaultClass;
		}
	}
	else{
		//if(f.name.toString().indexOf("required_")<0){
		if(document.getElementById(f).name.toString().indexOf("required_")<0){
			document.getElementById(f).name = "required_"+document.getElementById(f).name.toString();
			if(label!=""){
				document.getElementById(label).className = requiredClass;
			}
		}
	}
	
}


/***********************************************
* Name: lib_checkbox2list
* Arguments: checkbox_list - name of a collection of checkboxes
* Description: Returns a comma delimited list of values from a list of checkboxes.
***********************************************/
function lib_checkbox2list(checkbox_list){
	var i = 0;
	var thelist = "";
	if (checkbox_list) {
		try {
			if (checkbox_list.length > 1) {
				for(i=0;i<checkbox_list.length;i++) {
					if(checkbox_list[i].checked == true){
						thelist=js_listAppend(thelist,checkbox_list[i].value);
					}
				}
			}
		}
		catch(e) {
			if(checkbox_list.checked == true){
				thelist = checkbox_list.value;
			}
		}
	}
	return thelist;
}
/***********************************************
* Name: js_hide
* Arguments: el - element to hide
			This can be either an object name
			or a comma delimited list of string value for IDs
			2nd argument (optional) - This allows you to differentiate display types, so you might want hidden instead of none. Default is none
* Description: Hides an element on screen
***********************************************/
function js_hide(el){
	var disp = (arguments.length > 1)?arguments[1]:"none";
	try{
		if( el.toString().toLowerCase().indexOf("object") > -1 ){
			document.getElementById(el.id).style.display=disp;
		}
		else{
			var els = el.toString().split(",");
			for(var i=0;i<els.length;i++){
				try{
					document.getElementById(els[i]).style.display=disp;
				}
				catch(e){}
			}
		}
	}
	catch(e){}
}

/***********************************************
* Name: js_show
* Arguments: el - element to show
			This can be either an object name
			or a comma delimited list of string values for IDs
			2nd argument (optional) - This allows you to differentiate display types, so you might want block instead of inline. Default is inline
* Description: Shows an element on screen
***********************************************/
function js_show(el){
	try{
		if(el.toString().toLowerCase().indexOf("object") > -1){
			document.getElementById(el.id).style.display=uiCSS.getShowHide($(el.id)).show;
		}
		else{
			var els = el.toString().split(",");
			for(var i=0;i<els.length;i++){
				try{
					document.getElementById(els[i]).style.display=uiCSS.getShowHide($(els[i])).show;
				}
				catch(e){}
			}
		}
	}
	catch(e){}
}

/***********************************************
* Name: js_repeatString
* Arguments: str - String to repeat
			cnt - Number of times to repeat
* Description: Repeats a string a give number of times
***********************************************/
function js_repeatString(str,cnt){
	(isNaN(cnt))?(cnt=0):((cnt<0)?(cnt=0):"");// dummy checks
	newString = "";
	addString = str.toString();
	if(cnt>0){
		for(i=0;i<cnt;i++){
			newString+=addString;
		}
	}
	return newString;
}

/***********************************************
* Name: js_isDefined
* Arguments: obj - object or variable to check for
					existence
* Description: Returns boolean value of whether or
				not an elements exists
* Examples:
		test=0;
		function test2(){}
		js_isDefined("test"); // return true
		js_isDefined("test2"); // return true
		js_isDefined("test3"); // return false
***********************************************/
function js_isDefined(obj){
	try{
		var test=eval(obj).toString();
		if(test.toString()=="undefined"){
			return false;
		}
		return true;
	}
	catch(e){
		return false;
	}
}
/***********************************************
* Name: js_val
* Arguments: a - object value, variable or string
* Description: Returns 0 for all non-numeric values,
				Or the numerical value for
				numeric characters

* Examples:
		var a=1;
		var b="one";
		js_val(a); // returns 1
		js_val(b); // returns 0
***********************************************/
function js_val(a){
	if(isNaN(a)||jm_trim(a)==""){
		a=0;
	}
	return parseFloat(a);
}

/***********************************************
* Name: Delay
* Arguments: S - number of seconds for delay (int or float)
* Description: Delays processing of whatever comes after it
				Do to unknown quirky bugs in Javascript, this
				is occasionally necessary to patch bugs
* Examples:
		Delay(.2); // This would run for 200 milleseconds
***********************************************/
function Delay(S){
	var delayAmt = js_val(S)*1000;
	var delayNow = new Date().getTime()+delayAmt;
	while(delayNow>(new Date().getTime())){
		// Do nothing...
	}
}

/***********************************************
* Name: js_Ajax_Execute_Script
* Arguments: ajax_cont - Content returned from an AJAX/SJAX call
* Description: Parses through content returned from an Ajax call
				and looks for the existence of <SCRIPT> and
				<\/SCRIPT> tags then executes any scripts contained
				between these two tags (the search is not case sensative).
* Examples:
		Returned from Ajax Call
			<div>
				My DIV
				<script>
					alert("Hello");
				<\/script>
			<div>
		Ajax function to execute scripts
			var aCont = lib_sjax_post_request(ajax_filename,ajax_string);
			js_Ajax_Script_Execute(aCont); // alerts "Hello"

	* See http://kb.core.gegov.com/?articleID=52 for further detail
***********************************************/
function js_Ajax_Execute_Script(ajax_cont){
	// Set a global variable that can be called
	// in case this function throws an error
	js_Ajax_Execute_Script_Global_Error_Variable = "";
	// Store results in global variable for possible debugging later
	js_Ajax_Execute_Script_Global_Return_Variable = ajax_cont;
	// Store script(s) that get executed in a global variable for further debugging
	js_Ajax_Execute_Script_Global_Scripts_Variable = "";
	// Declare local variables
	var lcl_tags = "";
	var lcl_script = "";
	// Unique counter name
	var js_Ajax_Execute_Script_i = 0;
	try{
		// Handle the fact that some script tags may contain extra attributes
		ajax_cont = ajax_cont.replace(/type=\"text\/javascript\"/ig,"");
		ajax_cont = ajax_cont.replace(/type=text\/javascript/ig,"");
		ajax_cont = ajax_cont.replace(/language=\"javascript\"/ig,"");
		ajax_cont = ajax_cont.replace(/language=javascript/ig,"");
		// trim out spaces
		ajax_cont = ajax_cont.replace(/<script[\s]+/ig,"<script");
		// make tag search case in-sensative
		ajax_cont = ajax_cont.replace(/<script/ig,"<script");
		ajax_cont = ajax_cont.replace(/script>/ig,"script>");

		// Overwrite global variable with the most updated/recent results
		js_Ajax_Execute_Script_Global_Return_Variable = ajax_cont;
		if(ajax_cont.indexOf("<script>") > -1){
			lcl_tags = ajax_cont.split("<script>");
			if(lcl_tags.length > 0){
				for(var js_Ajax_Execute_Script_i = 0;js_Ajax_Execute_Script_i < lcl_tags.length;js_Ajax_Execute_Script_i++){
					if(lcl_tags[js_Ajax_Execute_Script_i].indexOf("<\/script>") > -1){
						lcl_script = lcl_tags[js_Ajax_Execute_Script_i].split("<\/script>")[0];
						// In some instances, javascript tags contain HTML comments
						lcl_script = lcl_script.replace(/<!--/ig,"//");
						lcl_script = lcl_script.replace(/-->/ig,"//");
						// Save each script that gets executed
						js_Ajax_Execute_Script_Global_Scripts_Variable = js_listAppend(js_Ajax_Execute_Script_Global_Scripts_Variable,lcl_script,"||");						
						try{
							eval(lcl_script.replace(/var /ig,"").toString());
						}
						catch(e){
						}
						// If there's functions being created in the returned content
						// build those now
						try{
							js_Ajax_Create_Script(lcl_script);
						}
						catch(e){}
					}
				}
			}
		}
	}
	catch(e){
		js_Ajax_Execute_Script_Global_Error_Variable=e.description;
	}
}

/***********************************************
* Name: js_Ajax_Create_Script
* Arguments: a - Content passed from js_Ajax_Execute_Script
* Description: An extension of js_Ajax_Execute_Script, which only EXECUTES scripts
				contained in SCRIPT tags.  This function will CREATE functions that
				are defined in an AJAX return.  This method should not be called
				directly, rather call js_Ajax_Execute_Script to invoke this
				method.
* Examples:
		Returned from Ajax Call
			<div>
				My DIV
				<script>
					alert("Hello");
					function foo(){
						alert("Test");
					}
				<\/script>
			<div>
		Ajax function to execute scripts
			var aCont = lib_sjax_post_request(ajax_filename,ajax_string);
			js_Ajax_Script_Execute(aCont); // alerts "Hello" and foo() is now a function available to the page
***********************************************/
function js_Ajax_Create_Script(a){
	// Define global variables for debugging
	js_Ajax_Create_Script_Global_Content=a;
	js_Ajax_Create_Script_Global_Error_Variable="";
	var functionName="";
	var commentedOut=false;
	// Unique counter name
	var js_Ajax_Create_Script_i = 0;
	if(a.indexOf("function") > -1){
		for(js_Ajax_Create_Script_i=0;js_Ajax_Create_Script_i < a.split("function").length;js_Ajax_Create_Script_i++){
			// Make sure the function isn't commented out
			if(right(jm_trim(a.split("function")[js_Ajax_Create_Script_i]),2) == "//"){
				commentedOut=true;
			}
			if(js_listLen(a.split("function")[js_Ajax_Create_Script_i],"/*") > js_listLen(a.split("function")[js_Ajax_Create_Script_i],"*/")){
				commentedOut=true;
			}
			if(!commentedOut){
				try{
					functionName = jm_trim(a.split("function")[js_Ajax_Create_Script_i+1].split("(")[0]);
					if(functionName.indexOf("Calendar") == -1){
						if(jm_trim(functionName) != ""){
							eval(functionName + " = function" + ( "function "+ jm_trim(a.split("function")[js_Ajax_Create_Script_i+1])).replace(/\/\//ig,"\n//").replace(new RegExp("function{1,} "+functionName),""));
						}
						else{
							functionName = jm_trim(a.split("function")[js_Ajax_Create_Script_i].split("(")[0]);
							if(jm_trim(functionName) != ""){
								eval(functionName + " = function" + (" "+ jm_trim(a.split("function")[js_Ajax_Create_Script_i + 1])).replace(/\/\//ig,"\n//").replace(new RegExp("function{1,} "+functionName),""));
							}
						}
					}
				}
				catch(e){
					js_Ajax_Create_Script_Global_Error_Variable=e.description;
				}
			}
		}
	}
}
/*
functionName = jm_trim(a.split("function")[i+1].split("(")[0]);
					if(jm_trim(functionName) != ""){
						eval(functionName+"=function"+("function "+ jm_trim(a.split("function")[i+1])).replace(/\/\//ig,"\n//").replace(new RegExp("function{1,} "+functionName),""));
					}
					//else{
						//functionName = jm_trim(a.split("function")[i].split("(")[0]);
						//alert(functionName);
						//if(jm_trim(functionName) != ""){
						//	//eval(functionName+"function"+(" "+ jm_trim(a.split("function")[i + 1])).replace(/\/\//ig,"\n//").replace(new RegExp("function{1,} "+functionName),""));
						//}
					//}

*/

/***********************************************
* Name: ByID
* Arguments: e - Element that you want to obtain using it's object ID
* Description: This is a short hand way of writing the document.getElementById
				syntax.
* Examples:
**********************************************/
function ByID(e){
	return document.getElementById(e);	
}
function byid(e){
	return ByID(e);	
}

/*
	NOTE: $() is by default built-in to all browsers for grabbing elements by ID, however in IE sometimes in local environment it doesn't get generated.
		Use this failover
*/
try{
	if(!js_isDefined("$")){
		function $(){
			var elements = new Array();
			for (var i = 0; i < arguments.length; i++){
				var element = arguments[i];
				if (typeof element == 'string'){
					if (document.getElementById){
						element = document.getElementById(element);
					}
					else if (document.all){
						element = document.all[element];
					}
				}
				if (arguments.length == 1){
					return element;
				}
				elements.push(element);
			}
			return elements;
		}
	}
}
catch(e){}

/*
	NOTE: $$ is basically $ v2.  It adds more robust methods to the element for short cut development (similar to jQuery).
*/
function $$(){
	var obj,element;
	
	if(!window.handlers){
		window.handlers = {};
	};
	
	if(typeof(arguments[0]) != "string"){
		element = arguments[0];
	}
	else if (document.getElementById){
		element = document.getElementById(arguments[0]);
	}
	else if (document.all){
		element = document.all[arguments[0]];
	}
	
	obj = {};
	obj.$ = element;
	obj.id = element.id;
	obj.innerHTML = function(str){
		obj.$.innerHTML = str;
	};
	obj.ajax = function(args){
		var ajaxFile = (args.ajaxFile)?args.ajaxFile:"ajax.cfm";
		var frmObj = (args.frmObj)?args.frmObj:"";
			frmObj += ((frmObj == "")?"":"&") + "objID=" + encodeURIComponent(obj.id);
			
		lib_ajaxRequest(ajaxFile,frmObj,function(args){
			var obj = $$(args.objID);
			
			obj.innerHTML(args.responseText);
			
			obj.handler(args);
		});
	};
	
	obj.setHandler = function(f){
		obj.handler = f;
		window.handlers[obj.id] = obj.handler;
	};
	
	obj.setHandler((window.handlers[obj.id])?window.handlers[obj.id]:function(){});
	
	return obj;
}

/***********************************************
* Name: js_EvalHandlers
* Arguments: frm - Form element on page
			* Note: Optional 2nd and 3rd arguments:
				* 2nd argument is specific form fields to include or exclude.  Pass in comma delimited list of
				string values of the form fields name.  The default to this argument is to execute all form fields.
				* 3rd argument specifies whether or not to include fields pass to 2nd argument or to exclude
				those fields.  Pass in either "ex" or "in".  The default is "ex" for exclude.
* Description: This will loop through a form and fire off all event handlers set on any form field.
				Note that this grabs the elements name property, not the ID so it must have name="..."
				set in order to work.
* Examples: js_EvalHandlers(myform);
**********************************************/
function js_EvalHandlers(frm){
	var _handlers="onclick,onblur,onfocus,onchange,onmousedown,onmouseup,ondblclick".split(",");
	var _actions="click(),NA,focus(),onchange(),onmousedown(),onmouseup(),ondblclick()".split(",");
	var _uniqueList=(arguments.length > 1)?arguments[1]:"";
	var _IncExc=(arguments.length > 2)?arguments[2].toLowerCase():"ex";
	var _exec=true;
	var excludeFocus = (arguments.length > 3)?arguments[3]:false;
	js_EvalHandlers_Global_Error_Variable="";
	try{
		var _Els=frm.elements;
		for(var o=0;o < _Els.length;o++){
			for(var h=0;h < _handlers.length;h++){
				if(js_isDefined(frm.name+"."+_Els[o].name+"."+_handlers[h])){
					// Try catch at the local level so if only one loop repetition breaks, the whole thing doesn't break
					try{
						_exec=(jm_trim(_uniqueList) == "")?true:false;
						if(!_exec && js_listFindNoCase(_uniqueList,_Els[o].name) > 0 && _IncExc=="in"){
							_exec=true;
						}
						else if(!_exec && js_listFindNoCase(_uniqueList,_Els[o].name) < 1 && _IncExc=="ex"){
							_exec=true;	
						}
						if(_exec){
							if(_actions[h] == "NA"){
								if(!excludeFocus){
									frm[_Els[o].name].focus();
									frm[_Els[o].name].blur();
								}
							}
							else{
								if((!excludeFocus && _actions[h] == "focus()") || _actions[h] != "focus()"){
									eval(frm[_Els[o].name] + "." + _actions[h]);
									// If it's a checkbox, that means we just unclicked it.  Reclick it
									if(_Els[o].type == "checkbox" && _actions[h] == "click()"){
										eval(frm[_Els[o].name] + "." + _actions[h]);	
									}
									// Make sure the focus is not an any particular field when the page loads - this could cause bugs
									try{
										frm[_Els[o].name].blur();
									}
									catch(blurErr){}
								}
							}
						}
					}
					catch(einner){
						js_EvalHandlers_Global_Error_Variable=einner.description;
					}
				}
			}
		}
	}
	catch(eouter){
		js_EvalHandlers_Global_Error_Variable=eouter.description;
	}
}

/***********************************************
* Name: js_isBetween
* Arguments: low - Lowest number in the range to compare
			high - Highest number in the range to compare
			num - Number used in the comparison
* Description: Returns boolean value of wether or not a given number is between two sets of numbers
* Examples: js_isBetween(1,100,75); // Returns true
**********************************************/

function js_isBetween(low,high,num){
	return (js_val(num) >= js_val(low) && js_val(num) <= js_val(high));	
}


/***********************************************
* Name: lib_resizeTextArea
* Arguments:	a = control name
				b = amount to increase by
				c = not sure
* Description: resizes a text area
* Examples: lib_resizeTextArea('foo',34,0); 
**********************************************/
function lib_resizeTextArea(a,b,c){
	if(parseInt(c)==0){
		// Textarea Height Resized
		if(parseInt(document.getElementById("" + a).style.height) + parseInt(b) > 0){
			document.getElementById("" + a).style.height = parseInt(document.getElementById("" + a).style.height) + parseInt(b);
		}
	}else{
		// Textarea Height Specified
		document.getElementById("" + a).style.height = parseInt(b);
	}
}

/***********************************************
* Name: lib_resizeTextArea
* Arguments:	thisObj
				thisValue
				rowID
* Description: toggles a row
* Examples: lib_toggleBySelect(this,'Yes','row_followUpDate'); 
* 8/25/2014 - changed 'block' for 'table-row' to get correct layout.
**********************************************/
function lib_toggleBySelect(thisObj,thisValue,rowID,type) {
	if (!type) {type = ""};

	if (type == "") {
		if (thisObj.value == thisValue) {
			document.getElementById(rowID).style.display="table-row";
		}
		else {
			document.getElementById(rowID).style.display="none";
		}
	}
	if (type == "checkbox") {
		if (thisObj.checked) {
			document.getElementById(rowID).style.display="table-row";
		}
		else {
			document.getElementById(rowID).style.display="none";
		}
	}
}
/***********************************************
   "search"
  select Element Type-Ahead for IE/Windows by Danny Goodman (www.dannyg.com)
  A bonus recipe for readers of O'Reilly's
    "JavaScript & DHTML Cookbook"
  This recipe first published at O'Reilly Network (www.oreillynet.com)
  For full implementation notes, read the article.
  
  RAR 3/19/09 - NOTE: Testing out this function in state of colorado since call to
  setSelection() function does not seem to work in all address blocks
  Do not want to make a global change to call this function onkeydown of tag_dropdown 
  until I'm sure this always works 
**********************************************/
   
// global storage object for type-ahead info, including reset() method
var typeAheadInfo = {last:0, 
                     accumString:"", 
                     delay:500,
                     timeout:null, 
                     reset:function() {this.last=0; this.accumString=""}
                    };
// function invoked by select element's onkeydown event handler
/* issue 28893. This function was added to be used in state of colorado (tool_sco_firms.cfm) since the type ahead doesnt work properly in IE 6.  
This function may be able to work system-wide in tag_dropdown but just using it in sco for now */ 
function lib_typeAhead() {
   // limit processing to IE event model supporter; don't trap Ctrl+keys
   if (window.event && !window.event.ctrlKey) {
      // timer for current event
      var now = new Date();
      // process for an empty accumString or an event within [delay] ms of last
      if (typeAheadInfo.accumString == "" || now - typeAheadInfo.last < typeAheadInfo.delay) {
         // make shortcut event object reference
         var evt = window.event;
         // get reference to the select element
         var selectElem = evt.srcElement;
         // get typed character ASCII value
         var charCode = evt.keyCode;
         // get the actual character, converted to uppercase
         var newChar =  String.fromCharCode(charCode).toUpperCase();
         // append new character to accumString storage
         typeAheadInfo.accumString += newChar;
         // grab all select element option objects as an array
         var selectOptions = selectElem.options;
         // prepare local variables for use inside loop
         var txt, nearest;
         // look through all options for a match starting with accumString
         for (var i = 0; i < selectOptions.length; i++) {
            // convert each item's text to uppercase to facilitate comparison
            // (use value property if you want match to be for hidden option value)
            txt = selectOptions[i].text.toUpperCase();
            // record nearest lowest index, if applicable
            nearest = (typeAheadInfo.accumString > txt.substr(0, typeAheadInfo.accumString.length)) ? i : nearest;
            // process if accumString is at start of option text
            if (txt.indexOf(typeAheadInfo.accumString) == 0) {
               // stop any previous timeout timer
               clearTimeout(typeAheadInfo.timeout);
               // store current event's time in object 
               typeAheadInfo.last = now;
               // reset typeAhead properties in [delay] ms unless cleared beforehand
               typeAheadInfo.timeout = setTimeout("typeAheadInfo.reset()", typeAheadInfo.delay);
               // visibly select the matching item
               selectElem.selectedIndex = i;
               // prevent default event actions and propagation
               evt.cancelBubble = true;
               evt.returnValue = false;
               // exit function
               return false;   
            }            
         }
         // if a next lowest match exists, select it
         if (nearest != null) {
            selectElem.selectedIndex = nearest;
         }
      } else {
         // not a desired event, so clear timeout
         clearTimeout(typeAheadInfo.timeout);
      }
      // reset global object
      typeAheadInfo.reset();
   }
   return true;
}

/***********************************************
* Name: escapeDegreeSymbol
* Arguments: str = string to escape
			useURLChar (optional) = appends "26" to the degree symbol for use in URL strings
* Description: replaces all instances of a degree symbol in a string with its ASCII equivilant
* Examples: var str = escapeDegreeSymbol(ByID("element").value);
**********************************************/
function escapeDegreeSymbol(str){
	var i=0;
	var escStr = "";
	var useURLChar = (arguments.length > 1)?arguments[1]:true;
	for(i=0;i < str.toString().length;i++){
		var thisChar = str.substr(i,1);
		escStr += (thisChar.charCodeAt(0) == 176)?"&" + ((useURLChar)?"26":"") + "deg;":thisChar;
	}
	return escStr;
}

/***********************************************
* Name: objEvents
	Methods: attach()
			* Arguments: obj = Object in which to attach the new event
						func = New function to append
			parse()
			* Arguments: func = Function in which to parse out string contents
* Description: Attaches a new function to the onchange or onblur handler methods on the fly
* Examples: // Assuming your object is called "testSelect"
			objEvents.attach($("testSelect"),function(){
				someCrazyFunction(this.value);
			});
			objEvents.attach($("testSelect"),function(){
				alert("Function number 2!");
			},"prepend");
**********************************************/

var objEvents = {
	attach: function(obj,func){
		if(obj){
			var appendOrPrepend = (arguments.length > 2)?arguments[2].toLowerCase():"append";
				
			// determine what handler to use.  then over write if one was passed in
			var strHandler = "";
			if(arguments.length > 3){
				strHandler = arguments[3];
			}
			
			if(jm_trim(strHandler) == "" || strHandler == "default"){
				strHandler = (obj.type == "select-one")?"onchange":"onblur";
				strHandler = (js_listFindNoCase("radio,checkbox,button,submit",obj.type) > 0)?"onclick":strHandler;
			}
			
			var currentHandler = obj[strHandler];
			
			var strCurrentFunction = (currentHandler)?objEvents.parse(currentHandler):"";
			
			var strNewFunction = objEvents.parse(func);
			
			if(appendOrPrepend == "append"){
				strCurrentFunction += "\r\n" + strNewFunction;
			}
			else{
				strCurrentFunction = strNewFunction + "\r\n" + strCurrentFunction;	
			}
			
			eval("obj." + strHandler + " = function(){" + strCurrentFunction + "};");
		}
	},
	parse: function(func){
		var isIE = (window.navigator.userAgent.indexOf("MSIE") > -1)?true:false;
			
		// NOTE: Changed to below for more complex objects and functions
		// var str = func.toString().split("{")[1];
		// str = str.split("}")[str.split("}").length - 2];
		
		var arr = func.toString().split("{");
		var str = "";
		for(var i=1;i < arr.length;i++){
			str += ((i > 1)?"{":"") + arr[i];
		}
		var arr = str.toString().split("}");
		var str = "";
		for(var i=0;i < arr.length - 1;i++){
			str += arr[i] + ((i < arr.length - 2)?"}":"");
		}
		
		return str;
	}
};

/***********************************************
* Name: formatPartialDateAddSlashes
* Description: Formats a numeric string of 10 characters to XX/XX/XXXX
* Examples: <input type="text" name="mydate" onBlur="formatPartialDateAddSlashes(this);">
**********************************************/

function formatPartialDateAddSlashes(obj){
	var str = obj.value;
	
	// make sure there are no slashes
	if( str != "" && str.indexOf("/") == -1){

		if(str.length != 8 || isNaN(str)){
			alert("Invalid Date. Must be 8 digits to format date; 2 digit month, 2 digit day, 4 digit year (Ex. 12012012)");
			return false;
		}
		
		var mo = str.substr(0,2); // month
		var da = str.substr(2,2); // day
		var yr = str.substr(4,4); // year
		
		obj.value = mo + "/" + da + "/" + yr;
		
		return true;
	}
}

/***********************************************
* Name: formatPartialDate
* Description: Formats a date string of either X/X/XX or XX/XX/XX to proper XX/XX/XXXX
* Examples: <input type="text" name="mydate" onBlur="formatPartialDate(this);">
**********************************************/

function formatPartialDate(obj){
	var str = obj.value;
	
	// issue 59912. make sure there are slashes in the entry
	if( str != "" && str.indexOf("/") == -1){
		if(obj.type.toLowerCase() != "hidden"){
			setTimeout(function(){
				obj.focus();
			}, 2);
		}
		return false;
	}
	// In the format of X/X/XX or XX/XX/XX
	if(/^(\d{1,2})\/\d{1,2}\/\d{2}$/.test(str) || /^(\d{1,2})\/\d{1,2}\/\d{4}$/.test(str)){
		// Build month
		var m = ((js_val(str.split("/")[0]) < 10)?"0":"") + js_val(str.split("/")[0]).toString();
		
		// Build date
		var d = ((js_val(str.split("/")[1]) < 10)?"0":"") + js_val(str.split("/")[1]).toString();
		
		// Build year
		var y = str.split("/")[2];
		
		// If greater than 50 and the current year is less than XX40, subtract 1 from the current century as the user is likely entering a past date
		if(str.split("/")[2].toString().length == 2){		
			y = ((js_val(y) > 50 && js_val(right(new Date().getFullYear().toString(),2)) <= 40)?(js_val(left(new Date().getFullYear().toString(),2)) - 1):left(new Date().getFullYear().toString(),2)) + y;
		}
		
		obj.value = m + "/" + d + "/" + y;
	}
}

/***********************************************
* Name: formatPartialPhone
* Description: Formats a phone number to the proper (000) 000-0000 ext. 000 format based upon any number passed in
* Examples: <input type="text" name="myphone" onBlur="formatPartialPhone(this);">
**********************************************/

function formatPartialPhone(obj){
	var str = obj.value.toString().replace(/\D/ig,""); // leave all but numbers
	
	if(jm_trim(str) == ""){
		obj.value = "";
		return;	
	}
	
	if(str.length < 10 || isNaN(str)){
		alert("Invalid Phone Number. Must be 10 digits or in the format:\n(000) 000-0000 ext. 000");
		return false;
	}
	
	var ac = str.substr(0,3); // area code
	var pr = str.substr(3,3); // prefix
	var ln = str.substr(6,4); // line number
	var ex = (str.length > 10)?str.substr(10,str.length - 10):""; // extension
	
	obj.value = "(" + ac + ") " + pr + "-" + ln + ((ex != "")?(" ext. " + ex):"");
	
	return true;
}

/***********************************************
* Name: formatTime
* Description: Formats any short handed time string to proper hh[,HH]:mm [tt]
* Examples: <input type="text" name="mytime" onBlur="formatTime({'obj':this[,'type':'[12|24]']});">
**********************************************/

function formatTime(args){
	// Localized variables and such things
	var timeStr = jm_trim(args.obj.value);
	var typ = (args.type)?args.type:"12";
	var hrs = "";
	var mns = "";
	var tt = "";
	
	// Ok, so it's blank...Probably in everyone's best interest to just not validate it
	if(timeStr == ""){
		return;	
	}
	
	// Number formatting method (it just prepends a zero on single digit numbers, woohoo)
	this.padZeros = function(str){
		var str = js_val(str);
		return (str > 9)?str.toString():("0" + str.toString());
	}
	
	// Test for 00:00 format
	if(!/^(\d{1,2}\:\d{1,2})/.test(timeStr)){
		alert("Invalid Date. Must be in the form 00:00" + ((typ != "24")?" AM/PM":""));
		//args.obj.focus();
		return false;
	}
	
	// Set time values.  You know, the hours and minutes
	hrs = js_val(timeStr.split(":")[0].replace(/\D/ig,""));
	mns = js_val(timeStr.split(":")[1].replace(/\D/ig,""));
	tt = (typ == "24")?"":((timeStr.toLowerCase().indexOf("p") != -1)?"PM":"AM");
	
	// Test for valid hours and minutes from the values set above.  If they're invalid it gets rejected!
	if((mns > 59 || mns < 0) || ((hrs > 12 || hrs < 1) && typ != "24") || ((hrs > 23 || hrs < 0) && typ == "24")){
		alert("Invalid time value");
		//args.obj.focus();
		return false;
	}
	
	// Success!  Now: join it, trim it, set it! (Yes, it was late when I wrote this.  Pardon the random comments)
	args.obj.value = jm_trim(this.padZeros(hrs) + ":" + this.padZeros(mns) + " " + tt);
}

// Function to convert time strings (09:15 PM) into an ISO 8601 compatible string (1899-12-30 22:26:00.0)
function timeToISO(time,target) {
	var h,m,hours,minutes,ampm,strTime;
	
	//alert(target)
	
	if(right(time,2).toLowerCase() == 'pm') {
		h = js_val(left(time,2)) + 12;
	} else {
		h = js_val(left(time,2));
	}
	
	m = time.substring(3,5);
	d = new Date(1899,12,30,h,m,0);
	
	hours = d.getHours();
	minutes = d.getMinutes();
	ampm = hours >= 12 ? 'pm' : 'am';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	minutes = minutes < 10 ? '0'+minutes : minutes;
	strTime = hours + ':' + minutes + ' ' + ampm;
	
	d = d.getMonth()+1 + "-" + d.getDate() + "-" + d.getFullYear() + " " + strTime;

	
	//either set a fields value or return the value.
	if(target){
		target.value = d;
	}else{
		return d;	
	}
}

function lib_toggleDisplayOnValue(source,srcVal,target,dspTrue,dspFalse){
	if(document.getElementById(source).value == srcVal){
		document.getElementById(target).style.display = dspTrue;
	}else{
		document.getElementById(target).style.display = dspFalse;
	}
}

/***********************************************
* Name: loading
* Description: Displays a full screen transparent DIV with text and icon over lay for loading or waiting messages
* Examples:
	To start: myMess = loading();
	To stop: myMess.close();
	Customized: myMess = loading({"path":"#request.relativeimagepath#../","mess":"Saving"});
**********************************************/

function loading(args){
	var args = (args)?args:{};
	var path = "../";
	var icon = ((args.icon)?args.icon:"_icons/animations/loading.gif");
	var mess = (args.mess)?args.mess:"Loading";
	var allowOverflow = (args.allowOverflow)?args.allowOverflow.toLowerCase():(js_isDefined("$('DHDToolBar')")?"no":"yes");
		
	try{
		if(document.location.href.toString().toLowerCase().indexOf("/webadmin/") != -1){
			path = path + js_repeatString("../",js_listLen(document.location.href,"/") - js_listFindNoCase(document.location.href,"webadmin","/")-1);
		}
	}
	catch(e){}
	
	path = (args.path)?args.path:path;
	
	var HTML = "<div class=\"small\" style=\"padding:2px;font-size:24px;cursor:progress;\" align=\"center\">";
		HTML += (jm_trim(icon) != "")?("<img src=\"" + path + icon + "\" align=\"absmiddle\">"):"";
		HTML += " <b>" + mess + "...</b></div>";
		
	return new popup.open({
		"height":"150"
		,"width":"350"
		,"draggable":"no"
		,"loadType":"html"
		,"htmlContent":HTML
		,"imgPath":path
		,"useFrame":"no"
		,"contentBorder":"none"
		,"contentBG":"transparent"
		,"useScreenLock":"yes"
		,"slideOpen":"no"
		,"allowOverflow":allowOverflow
		,"addToTray":"no"
	});
}

/***********************************************
* Name: js_valueList
* Arguments: q = JSON object
			c = Column to convert to list
			3rd = Custom delimiter
			4th = Only append unique values
* Description: Returns a comma delimited list of values from a JSON object
* Examples:
	var IDs = js_valueList(qData,'ID'[,delimiter][,unique]);
**********************************************/

function js_valueList(q,c){
	try{
		var str = "";
		var delim = (arguments.length > 2)?arguments[2]:",";
		var unique = (arguments.length > 3)?arguments[3]:false;
		var idx = q.INDEXES[c.toString().toUpperCase()];
		for(var i=0;i < q.RECORDCOUNT;i++){
			if(jm_trim(q.DATA[i][idx]) != "" && ((unique && ("," + str + ",").indexOf("," + q.DATA[i][idx] + ",") == -1) || !unique)){
				str = js_listAppend(str,q.DATA[i][idx],delim);
			}
		}
		return str;
	}
	catch(e){
		return "";	
	}
}

/***********************************************
* Name: getNewID
* Arguments: N/A
* Description: Returns a GUID from SQL Server
* Examples:
	var ID = getNewID();
**********************************************/
function getNewID(){
	eval("var obj = " + jm_trim(lib_sjax_post_request(popup.getRelativePath() + "ajax_dhd_system.cfm","action=newID&JSON=YES")));
	return obj.newID;	
}




//,elms,showVals,dispTypes,listPos_SH
universalShowHide = function(stp,obj) {
	try {
		//Loops over the dropdowns,checkboxes or radio buttons to add the listeners
		if(stp=='init') {
			shv1 = showHideVar.elementIDsShowHideValueDerivesFrom;
			shv2 = showHideVar.elementIDsToShowOrHide;
			shv3 = showHideVar.valuesToShowFor;
			shv4 = showHideVar.displayTypes;
			for(i_SH=0;i_SH < shv1.length; i_SH++) {
				
				this["rows"+i_SH] = shv2[i_SH].toString();
				this["shows"+i_SH] = shv3[i_SH].toString();
				this["displayTypes"+i_SH] = shv4[i_SH].toString();
				//alert(eval("rows"+eval(i_SH)))
				//alert(rows0);
				//alert("'"+eval("'"+rows+"'")+"'")
				if(document.getElementById(shv1[i_SH]).type.toString().toLowerCase()=="select-one" || document.getElementById(shv1[i_SH]).type.toString().toLowerCase()=="select") {
					//objEvents.attach(document.getElementById(shv1[i]),function(){universalShowHide('sh',this,rows,shows,displayTypes)},"append","onchange");
					objEvents.attach(document.getElementById(shv1[i_SH]),function(){universalShowHide('sh',this)},"append","onchange");
					//document.getElementById(shv1[i_SH]).onchange = function(){ universalShowHide('sh',this)};
					
					/*function setTrigger_SH(r_sh,s_sh,dt_sh) {
						this.r_sh=r_sh;
						this.s_sh=s_sh;
						this.dt_sh=dt_sh;
						alert("'"+eval("'"+this.r_sh+"'")+"'")
						document.getElementById(shv1[i]).onchange =  function(){universalShowHide('sh',this,eval("'"+this.r_sh+"'"),this.s_sh,this.dt_sh)};
					}
					
					new setTrigger_SH(rows,shows,displayTypes);*/
					
					//document.getElementById(shv1[i]).attachEvent("onchange","showHideCheck('sh',this,'" + rows + "','" + shows + "','" + displayTypes + "')");
				}
				else{
					//objEvents.attach(document.getElementById(shv1[i]),function(){universalShowHide('sh',this,rows,shows,displayTypes)},"append","onclick");
					objEvents.attach(document.getElementById(shv1[i_SH]),function(){universalShowHide('sh',this)},"append","onclick");
					//document.getElementById(shv1[i_SH]).onclick = function(){ universalShowHide('sh',this)};
					//document.getElementById(shv1[i]).attachEvent("onclick","showHideCheck('sh',this,'" + rows + "','" + shows + "','" + displayTypes + "')");
				}
				
				universalShowHide('sh',document.getElementById(shv1[i_SH]))
			}
		}
		//is called when dropdown,checkbox or radio button is changed or clicked
		else {
			for(i_SH2=0;i_SH2 < shv1.length; i_SH2++) {
				if(shv1[i_SH2]==obj.id) {
				var elms_array = showHideVar.elementIDsToShowOrHide[i_SH2].split(",");//elms.split(",");
				var showVals_array = showHideVar.valuesToShowFor[i_SH2].split(",");//showVals.split(",");
				var dispTypes_array = showHideVar.displayTypes[i_SH2].split(",");//dispTypes.split(",");
				}
			}
			
			for(var i2=0;i2<elms_array.length;i2++) {
				//initially hides the element
				document.getElementById(elms_array[i2]).style.display="none";
				for(var i3=0;i3<showVals_array.length;i3++) {
					//if value is equal to the show value given the element is unhidden.
					if(obj.type.toString().toLowerCase()=="select-one" || obj.type.toString().toLowerCase()=="select") {
				
						if(obj.value==showVals_array[i3]) {
							document.getElementById(elms_array[i2]).style.display=dispTypes_array[i2];
						}
					}
					else {
						if(obj.value==showVals_array[i3] && obj.checked) {
							document.getElementById(elms_array[i2]).style.display=dispTypes_array[i2];
						}
					}
				}
			}
		}
	
	
	}
	catch(err){/*alert(err);*/}
}

//document.attachEvent("onload",function() {setTimeout(200,function(){universalShowHide('init')})});
/*
try {
	document.attachEvent("onload","universalShowHide");
}
catch(err){document.onload += function() {universalShowHide('init')}}
document.onload = function() {universalShowHide('init')}
*/
objEvents.attach(window,function(){universalShowHide('init')},"append","onload");

		</script>
		<script src="scripts.js" language="javascript" type="text/javascript"></script>
	
<style>
	.textN{font-family:Arial;font-size:9pt;color:blue;text-decoration:none}
	.buttN{font-family:Arial;font-size:9pt;color:black;background-color:cccccc}
	
	.paginationFooter{
		/*margin-top:3px;*/
		clear:both;
		float:left;
		height:30px;
	}
	
	.paginationFooter UL{
		margin:0px;
		padding:0px;
	}
	
	.paginationFooter UL LI{
		list-style:none;
		display:inline;
		padding:3px;
		padding-left:6px;
		padding-right:6px;
		border:1px solid #CCCCCC;
		margin-right:2px;
		text-align:center;
		cursor:pointer;
		font-weight:bold;
	}
	
	.paginationFooter UL LI:hover{
		background-color:#CCCCCC;
		border-bottom:3px solid blue;
		color:blue;
	}
	
	.paginationFooter UL LI.thisPage{
		background-color:#CCCCCC;
		color:blue;
	}
	
</style>
</head>
	<body topmargin="10" leftmargin="0" rightmargin="0" bottommargin="0"
	onload="controlDateRange('dtRng');">
	<div style="width:100%;">
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
		<tr>
			<td valign="top" width="350">

	<H3>Reports</H3>
	
	<hr noshade="noshade" size="1" />
	
	
	
		<b>8140 Facilities matched </b>
		
		<br />
		
		
			Displaying results 1 &ndash; 10 of 8140
			<br />
			
			<a href="javascript:history.go(-1);">&laquo; Search Again</a>
			<hr noshade="noshade" size="1" />
			
			<br />
			
			
			
			
					<a href="estab.cfm?licenseID=764997"><b>#SNAX</b></a>
					
					
					<div style="margin-bottom:10px;">
					128  JEFFERSON ST       <br />
					San Antonio                   , TX 78205 
					</div>
				
					<a href="estab.cfm?licenseID=785167"><b>103 PLAZA LEVEL STAND</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=785168"><b>104 PLAZA LEVEL</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=785169"><b>105-106 PLAZA LEVEL STAND</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=785171"><b>107 PLAZA LEVEL STAND</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=785215"><b>107-108 PLAZA LEVEL</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=658179"><b>11 STARS EXPRESS</b></a>
					
					
					<div style="margin-bottom:10px;">
					7019  WESTFIELD DR            <br />
					San Antonio                   , TX 78227 
					</div>
				
					<a href="estab.cfm?licenseID=785172"><b>110-111 PLAZA LEVEL</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=785173"><b>113-114 PLAZA LEVEL</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
					<a href="estab.cfm?licenseID=785174"><b>116-117 PLAZA LEVEL</b></a>
					
					
					<div style="margin-bottom:10px;">
					100  MONTANA ST         <br />
					San Antonio                   , TX 78203 
					</div>
				
				<hr noshade="noshade" size="1" />
			 
		
					
					Result Pages: 
					
					
							<a href="search.cfm?start=1&" class="buttN" style="padding:1px;"><b style='color:red'>(1)</b></a>
							
							<a href="search.cfm?start=11&" class="buttN" style="padding:1px;">2</a>
							
							<a href="search.cfm?start=21&" class="buttN" style="padding:1px;">3</a>
							
							<a href="search.cfm?start=31&" class="buttN" style="padding:1px;">4</a>
							
							<a href="search.cfm?start=41&" class="buttN" style="padding:1px;">5</a>
							
							<a href="search.cfm?start=51&" class="buttN" style="padding:1px;">6</a>
							
							<a href="search.cfm?start=61&" class="buttN" style="padding:1px;">7</a>
							
							<a href="search.cfm?start=71&" class="buttN" style="padding:1px;">8</a>
							
							<a href="search.cfm?start=81&" class="buttN" style="padding:1px;">9</a>
							
							<a href="search.cfm?start=91&" class="buttN" style="padding:1px;">10</a>
							
							<a href="search.cfm?start=101&" class="buttN" style="padding:1px;">11</a>
							
							<a href="search.cfm?start=111&" class="buttN" style="padding:1px;">12</a>
							
							<a href="search.cfm?start=121&" class="buttN" style="padding:1px;">13</a>
							
							<a href="search.cfm?start=131&" class="buttN" style="padding:1px;">14</a>
							
							<a href="search.cfm?start=141&" class="buttN" style="padding:1px;">15</a>
							
							<a href="search.cfm?start=151&" class="buttN" style="padding:1px;">16</a>
							
							<a href="search.cfm?start=161&" class="buttN" style="padding:1px;">17</a>
							
							<a href="search.cfm?start=171&" class="buttN" style="padding:1px;">18</a>
							
							<a href="search.cfm?start=181&" class="buttN" style="padding:1px;">19</a>
							
							<a href="search.cfm?start=191&" class="buttN" style="padding:1px;">20</a>
							
							<a href="search.cfm?start=201&" class="buttN" style="padding:1px;">21</a>
							
							<a href="search.cfm?start=211&" class="buttN" style="padding:1px;">22</a>
							
							<a href="search.cfm?start=221&" class="buttN" style="padding:1px;">23</a>
							
							<a href="search.cfm?start=231&" class="buttN" style="padding:1px;">24</a>
							
							<a href="search.cfm?start=241&" class="buttN" style="padding:1px;">25</a>
							
							<a href="search.cfm?start=251&" class="buttN" style="padding:1px;">26</a>
							
							<a href="search.cfm?start=261&" class="buttN" style="padding:1px;">27</a>
							
							<a href="search.cfm?start=271&" class="buttN" style="padding:1px;">28</a>
							
							<a href="search.cfm?start=281&" class="buttN" style="padding:1px;">29</a>
							
							<a href="search.cfm?start=291&" class="buttN" style="padding:1px;">30</a>
							
							<a href="search.cfm?start=301&" class="buttN" style="padding:1px;">31</a>
							
							<a href="search.cfm?start=311&" class="buttN" style="padding:1px;">32</a>
							
							<a href="search.cfm?start=321&" class="buttN" style="padding:1px;">33</a>
							
							<a href="search.cfm?start=331&" class="buttN" style="padding:1px;">34</a>
							
							<a href="search.cfm?start=341&" class="buttN" style="padding:1px;">35</a>
							
							<a href="search.cfm?start=351&" class="buttN" style="padding:1px;">36</a>
							
							<a href="search.cfm?start=361&" class="buttN" style="padding:1px;">37</a>
							
							<a href="search.cfm?start=371&" class="buttN" style="padding:1px;">38</a>
							
							<a href="search.cfm?start=381&" class="buttN" style="padding:1px;">39</a>
							
							<a href="search.cfm?start=391&" class="buttN" style="padding:1px;">40</a>
							
							<a href="search.cfm?start=401&" class="buttN" style="padding:1px;">41</a>
							
							<a href="search.cfm?start=411&" class="buttN" style="padding:1px;">42</a>
							
							<a href="search.cfm?start=421&" class="buttN" style="padding:1px;">43</a>
							
							<a href="search.cfm?start=431&" class="buttN" style="padding:1px;">44</a>
							
							<a href="search.cfm?start=441&" class="buttN" style="padding:1px;">45</a>
							
							<a href="search.cfm?start=451&" class="buttN" style="padding:1px;">46</a>
							
							<a href="search.cfm?start=461&" class="buttN" style="padding:1px;">47</a>
							
							<a href="search.cfm?start=471&" class="buttN" style="padding:1px;">48</a>
							
							<a href="search.cfm?start=481&" class="buttN" style="padding:1px;">49</a>
							
							<a href="search.cfm?start=491&" class="buttN" style="padding:1px;">50</a>
							
							<a href="search.cfm?start=501&" class="buttN" style="padding:1px;">51</a>
							
							<a href="search.cfm?start=511&" class="buttN" style="padding:1px;">52</a>
							
							<a href="search.cfm?start=521&" class="buttN" style="padding:1px;">53</a>
							
							<a href="search.cfm?start=531&" class="buttN" style="padding:1px;">54</a>
							
							<a href="search.cfm?start=541&" class="buttN" style="padding:1px;">55</a>
							
							<a href="search.cfm?start=551&" class="buttN" style="padding:1px;">56</a>
							
							<a href="search.cfm?start=561&" class="buttN" style="padding:1px;">57</a>
							
							<a href="search.cfm?start=571&" class="buttN" style="padding:1px;">58</a>
							
							<a href="search.cfm?start=581&" class="buttN" style="padding:1px;">59</a>
							
							<a href="search.cfm?start=591&" class="buttN" style="padding:1px;">60</a>
							
							<a href="search.cfm?start=601&" class="buttN" style="padding:1px;">61</a>
							
							<a href="search.cfm?start=611&" class="buttN" style="padding:1px;">62</a>
							
							<a href="search.cfm?start=621&" class="buttN" style="padding:1px;">63</a>
							
							<a href="search.cfm?start=631&" class="buttN" style="padding:1px;">64</a>
							
							<a href="search.cfm?start=641&" class="buttN" style="padding:1px;">65</a>
							
							<a href="search.cfm?start=651&" class="buttN" style="padding:1px;">66</a>
							
							<a href="search.cfm?start=661&" class="buttN" style="padding:1px;">67</a>
							
							<a href="search.cfm?start=671&" class="buttN" style="padding:1px;">68</a>
							
							<a href="search.cfm?start=681&" class="buttN" style="padding:1px;">69</a>
							
							<a href="search.cfm?start=691&" class="buttN" style="padding:1px;">70</a>
							
							<a href="search.cfm?start=701&" class="buttN" style="padding:1px;">71</a>
							
							<a href="search.cfm?start=711&" class="buttN" style="padding:1px;">72</a>
							
							<a href="search.cfm?start=721&" class="buttN" style="padding:1px;">73</a>
							
							<a href="search.cfm?start=731&" class="buttN" style="padding:1px;">74</a>
							
							<a href="search.cfm?start=741&" class="buttN" style="padding:1px;">75</a>
							
							<a href="search.cfm?start=751&" class="buttN" style="padding:1px;">76</a>
							
							<a href="search.cfm?start=761&" class="buttN" style="padding:1px;">77</a>
							
							<a href="search.cfm?start=771&" class="buttN" style="padding:1px;">78</a>
							
							<a href="search.cfm?start=781&" class="buttN" style="padding:1px;">79</a>
							
							<a href="search.cfm?start=791&" class="buttN" style="padding:1px;">80</a>
							
							<a href="search.cfm?start=801&" class="buttN" style="padding:1px;">81</a>
							
							<a href="search.cfm?start=811&" class="buttN" style="padding:1px;">82</a>
							
							<a href="search.cfm?start=821&" class="buttN" style="padding:1px;">83</a>
							
							<a href="search.cfm?start=831&" class="buttN" style="padding:1px;">84</a>
							
							<a href="search.cfm?start=841&" class="buttN" style="padding:1px;">85</a>
							
							<a href="search.cfm?start=851&" class="buttN" style="padding:1px;">86</a>
							
							<a href="search.cfm?start=861&" class="buttN" style="padding:1px;">87</a>
							
							<a href="search.cfm?start=871&" class="buttN" style="padding:1px;">88</a>
							
							<a href="search.cfm?start=881&" class="buttN" style="padding:1px;">89</a>
							
							<a href="search.cfm?start=891&" class="buttN" style="padding:1px;">90</a>
							
							<a href="search.cfm?start=901&" class="buttN" style="padding:1px;">91</a>
							
							<a href="search.cfm?start=911&" class="buttN" style="padding:1px;">92</a>
							
							<a href="search.cfm?start=921&" class="buttN" style="padding:1px;">93</a>
							
							<a href="search.cfm?start=931&" class="buttN" style="padding:1px;">94</a>
							
							<a href="search.cfm?start=941&" class="buttN" style="padding:1px;">95</a>
							
							<a href="search.cfm?start=951&" class="buttN" style="padding:1px;">96</a>
							
							<a href="search.cfm?start=961&" class="buttN" style="padding:1px;">97</a>
							
							<a href="search.cfm?start=971&" class="buttN" style="padding:1px;">98</a>
							
							<a href="search.cfm?start=981&" class="buttN" style="padding:1px;">99</a>
							
							<a href="search.cfm?start=991&" class="buttN" style="padding:1px;">100</a>
							
							<a href="search.cfm?start=1001&" class="buttN" style="padding:1px;">101</a>
							
							<a href="search.cfm?start=1011&" class="buttN" style="padding:1px;">102</a>
							
							<a href="search.cfm?start=1021&" class="buttN" style="padding:1px;">103</a>
							
							<a href="search.cfm?start=1031&" class="buttN" style="padding:1px;">104</a>
							
							<a href="search.cfm?start=1041&" class="buttN" style="padding:1px;">105</a>
							
							<a href="search.cfm?start=1051&" class="buttN" style="padding:1px;">106</a>
							
							<a href="search.cfm?start=1061&" class="buttN" style="padding:1px;">107</a>
							
							<a href="search.cfm?start=1071&" class="buttN" style="padding:1px;">108</a>
							
							<a href="search.cfm?start=1081&" class="buttN" style="padding:1px;">109</a>
							
							<a href="search.cfm?start=1091&" class="buttN" style="padding:1px;">110</a>
							
							<a href="search.cfm?start=1101&" class="buttN" style="padding:1px;">111</a>
							
							<a href="search.cfm?start=1111&" class="buttN" style="padding:1px;">112</a>
							
							<a href="search.cfm?start=1121&" class="buttN" style="padding:1px;">113</a>
							
							<a href="search.cfm?start=1131&" class="buttN" style="padding:1px;">114</a>
							
							<a href="search.cfm?start=1141&" class="buttN" style="padding:1px;">115</a>
							
							<a href="search.cfm?start=1151&" class="buttN" style="padding:1px;">116</a>
							
							<a href="search.cfm?start=1161&" class="buttN" style="padding:1px;">117</a>
							
							<a href="search.cfm?start=1171&" class="buttN" style="padding:1px;">118</a>
							
							<a href="search.cfm?start=1181&" class="buttN" style="padding:1px;">119</a>
							
							<a href="search.cfm?start=1191&" class="buttN" style="padding:1px;">120</a>
							
							<a href="search.cfm?start=1201&" class="buttN" style="padding:1px;">121</a>
							
							<a href="search.cfm?start=1211&" class="buttN" style="padding:1px;">122</a>
							
							<a href="search.cfm?start=1221&" class="buttN" style="padding:1px;">123</a>
							
							<a href="search.cfm?start=1231&" class="buttN" style="padding:1px;">124</a>
							
							<a href="search.cfm?start=1241&" class="buttN" style="padding:1px;">125</a>
							
							<a href="search.cfm?start=1251&" class="buttN" style="padding:1px;">126</a>
							
							<a href="search.cfm?start=1261&" class="buttN" style="padding:1px;">127</a>
							
							<a href="search.cfm?start=1271&" class="buttN" style="padding:1px;">128</a>
							
							<a href="search.cfm?start=1281&" class="buttN" style="padding:1px;">129</a>
							
							<a href="search.cfm?start=1291&" class="buttN" style="padding:1px;">130</a>
							
							<a href="search.cfm?start=1301&" class="buttN" style="padding:1px;">131</a>
							
							<a href="search.cfm?start=1311&" class="buttN" style="padding:1px;">132</a>
							
							<a href="search.cfm?start=1321&" class="buttN" style="padding:1px;">133</a>
							
							<a href="search.cfm?start=1331&" class="buttN" style="padding:1px;">134</a>
							
							<a href="search.cfm?start=1341&" class="buttN" style="padding:1px;">135</a>
							
							<a href="search.cfm?start=1351&" class="buttN" style="padding:1px;">136</a>
							
							<a href="search.cfm?start=1361&" class="buttN" style="padding:1px;">137</a>
							
							<a href="search.cfm?start=1371&" class="buttN" style="padding:1px;">138</a>
							
							<a href="search.cfm?start=1381&" class="buttN" style="padding:1px;">139</a>
							
							<a href="search.cfm?start=1391&" class="buttN" style="padding:1px;">140</a>
							
							<a href="search.cfm?start=1401&" class="buttN" style="padding:1px;">141</a>
							
							<a href="search.cfm?start=1411&" class="buttN" style="padding:1px;">142</a>
							
							<a href="search.cfm?start=1421&" class="buttN" style="padding:1px;">143</a>
							
							<a href="search.cfm?start=1431&" class="buttN" style="padding:1px;">144</a>
							
							<a href="search.cfm?start=1441&" class="buttN" style="padding:1px;">145</a>
							
							<a href="search.cfm?start=1451&" class="buttN" style="padding:1px;">146</a>
							
							<a href="search.cfm?start=1461&" class="buttN" style="padding:1px;">147</a>
							
							<a href="search.cfm?start=1471&" class="buttN" style="padding:1px;">148</a>
							
							<a href="search.cfm?start=1481&" class="buttN" style="padding:1px;">149</a>
							
							<a href="search.cfm?start=1491&" class="buttN" style="padding:1px;">150</a>
							
							<a href="search.cfm?start=1501&" class="buttN" style="padding:1px;">151</a>
							
							<a href="search.cfm?start=1511&" class="buttN" style="padding:1px;">152</a>
							
							<a href="search.cfm?start=1521&" class="buttN" style="padding:1px;">153</a>
							
							<a href="search.cfm?start=1531&" class="buttN" style="padding:1px;">154</a>
							
							<a href="search.cfm?start=1541&" class="buttN" style="padding:1px;">155</a>
							
							<a href="search.cfm?start=1551&" class="buttN" style="padding:1px;">156</a>
							
							<a href="search.cfm?start=1561&" class="buttN" style="padding:1px;">157</a>
							
							<a href="search.cfm?start=1571&" class="buttN" style="padding:1px;">158</a>
							
							<a href="search.cfm?start=1581&" class="buttN" style="padding:1px;">159</a>
							
							<a href="search.cfm?start=1591&" class="buttN" style="padding:1px;">160</a>
							
							<a href="search.cfm?start=1601&" class="buttN" style="padding:1px;">161</a>
							
							<a href="search.cfm?start=1611&" class="buttN" style="padding:1px;">162</a>
							
							<a href="search.cfm?start=1621&" class="buttN" style="padding:1px;">163</a>
							
							<a href="search.cfm?start=1631&" class="buttN" style="padding:1px;">164</a>
							
							<a href="search.cfm?start=1641&" class="buttN" style="padding:1px;">165</a>
							
							<a href="search.cfm?start=1651&" class="buttN" style="padding:1px;">166</a>
							
							<a href="search.cfm?start=1661&" class="buttN" style="padding:1px;">167</a>
							
							<a href="search.cfm?start=1671&" class="buttN" style="padding:1px;">168</a>
							
							<a href="search.cfm?start=1681&" class="buttN" style="padding:1px;">169</a>
							
							<a href="search.cfm?start=1691&" class="buttN" style="padding:1px;">170</a>
							
							<a href="search.cfm?start=1701&" class="buttN" style="padding:1px;">171</a>
							
							<a href="search.cfm?start=1711&" class="buttN" style="padding:1px;">172</a>
							
							<a href="search.cfm?start=1721&" class="buttN" style="padding:1px;">173</a>
							
							<a href="search.cfm?start=1731&" class="buttN" style="padding:1px;">174</a>
							
							<a href="search.cfm?start=1741&" class="buttN" style="padding:1px;">175</a>
							
							<a href="search.cfm?start=1751&" class="buttN" style="padding:1px;">176</a>
							
							<a href="search.cfm?start=1761&" class="buttN" style="padding:1px;">177</a>
							
							<a href="search.cfm?start=1771&" class="buttN" style="padding:1px;">178</a>
							
							<a href="search.cfm?start=1781&" class="buttN" style="padding:1px;">179</a>
							
							<a href="search.cfm?start=1791&" class="buttN" style="padding:1px;">180</a>
							
							<a href="search.cfm?start=1801&" class="buttN" style="padding:1px;">181</a>
							
							<a href="search.cfm?start=1811&" class="buttN" style="padding:1px;">182</a>
							
							<a href="search.cfm?start=1821&" class="buttN" style="padding:1px;">183</a>
							
							<a href="search.cfm?start=1831&" class="buttN" style="padding:1px;">184</a>
							
							<a href="search.cfm?start=1841&" class="buttN" style="padding:1px;">185</a>
							
							<a href="search.cfm?start=1851&" class="buttN" style="padding:1px;">186</a>
							
							<a href="search.cfm?start=1861&" class="buttN" style="padding:1px;">187</a>
							
							<a href="search.cfm?start=1871&" class="buttN" style="padding:1px;">188</a>
							
							<a href="search.cfm?start=1881&" class="buttN" style="padding:1px;">189</a>
							
							<a href="search.cfm?start=1891&" class="buttN" style="padding:1px;">190</a>
							
							<a href="search.cfm?start=1901&" class="buttN" style="padding:1px;">191</a>
							
							<a href="search.cfm?start=1911&" class="buttN" style="padding:1px;">192</a>
							
							<a href="search.cfm?start=1921&" class="buttN" style="padding:1px;">193</a>
							
							<a href="search.cfm?start=1931&" class="buttN" style="padding:1px;">194</a>
							
							<a href="search.cfm?start=1941&" class="buttN" style="padding:1px;">195</a>
							
							<a href="search.cfm?start=1951&" class="buttN" style="padding:1px;">196</a>
							
							<a href="search.cfm?start=1961&" class="buttN" style="padding:1px;">197</a>
							
							<a href="search.cfm?start=1971&" class="buttN" style="padding:1px;">198</a>
							
							<a href="search.cfm?start=1981&" class="buttN" style="padding:1px;">199</a>
							
							<a href="search.cfm?start=1991&" class="buttN" style="padding:1px;">200</a>
							
							<a href="search.cfm?start=2001&" class="buttN" style="padding:1px;">201</a>
							
							<a href="search.cfm?start=2011&" class="buttN" style="padding:1px;">202</a>
							
							<a href="search.cfm?start=2021&" class="buttN" style="padding:1px;">203</a>
							
							<a href="search.cfm?start=2031&" class="buttN" style="padding:1px;">204</a>
							
							<a href="search.cfm?start=2041&" class="buttN" style="padding:1px;">205</a>
							
							<a href="search.cfm?start=2051&" class="buttN" style="padding:1px;">206</a>
							
							<a href="search.cfm?start=2061&" class="buttN" style="padding:1px;">207</a>
							
							<a href="search.cfm?start=2071&" class="buttN" style="padding:1px;">208</a>
							
							<a href="search.cfm?start=2081&" class="buttN" style="padding:1px;">209</a>
							
							<a href="search.cfm?start=2091&" class="buttN" style="padding:1px;">210</a>
							
							<a href="search.cfm?start=2101&" class="buttN" style="padding:1px;">211</a>
							
							<a href="search.cfm?start=2111&" class="buttN" style="padding:1px;">212</a>
							
							<a href="search.cfm?start=2121&" class="buttN" style="padding:1px;">213</a>
							
							<a href="search.cfm?start=2131&" class="buttN" style="padding:1px;">214</a>
							
							<a href="search.cfm?start=2141&" class="buttN" style="padding:1px;">215</a>
							
							<a href="search.cfm?start=2151&" class="buttN" style="padding:1px;">216</a>
							
							<a href="search.cfm?start=2161&" class="buttN" style="padding:1px;">217</a>
							
							<a href="search.cfm?start=2171&" class="buttN" style="padding:1px;">218</a>
							
							<a href="search.cfm?start=2181&" class="buttN" style="padding:1px;">219</a>
							
							<a href="search.cfm?start=2191&" class="buttN" style="padding:1px;">220</a>
							
							<a href="search.cfm?start=2201&" class="buttN" style="padding:1px;">221</a>
							
							<a href="search.cfm?start=2211&" class="buttN" style="padding:1px;">222</a>
							
							<a href="search.cfm?start=2221&" class="buttN" style="padding:1px;">223</a>
							
							<a href="search.cfm?start=2231&" class="buttN" style="padding:1px;">224</a>
							
							<a href="search.cfm?start=2241&" class="buttN" style="padding:1px;">225</a>
							
							<a href="search.cfm?start=2251&" class="buttN" style="padding:1px;">226</a>
							
							<a href="search.cfm?start=2261&" class="buttN" style="padding:1px;">227</a>
							
							<a href="search.cfm?start=2271&" class="buttN" style="padding:1px;">228</a>
							
							<a href="search.cfm?start=2281&" class="buttN" style="padding:1px;">229</a>
							
							<a href="search.cfm?start=2291&" class="buttN" style="padding:1px;">230</a>
							
							<a href="search.cfm?start=2301&" class="buttN" style="padding:1px;">231</a>
							
							<a href="search.cfm?start=2311&" class="buttN" style="padding:1px;">232</a>
							
							<a href="search.cfm?start=2321&" class="buttN" style="padding:1px;">233</a>
							
							<a href="search.cfm?start=2331&" class="buttN" style="padding:1px;">234</a>
							
							<a href="search.cfm?start=2341&" class="buttN" style="padding:1px;">235</a>
							
							<a href="search.cfm?start=2351&" class="buttN" style="padding:1px;">236</a>
							
							<a href="search.cfm?start=2361&" class="buttN" style="padding:1px;">237</a>
							
							<a href="search.cfm?start=2371&" class="buttN" style="padding:1px;">238</a>
							
							<a href="search.cfm?start=2381&" class="buttN" style="padding:1px;">239</a>
							
							<a href="search.cfm?start=2391&" class="buttN" style="padding:1px;">240</a>
							
							<a href="search.cfm?start=2401&" class="buttN" style="padding:1px;">241</a>
							
							<a href="search.cfm?start=2411&" class="buttN" style="padding:1px;">242</a>
							
							<a href="search.cfm?start=2421&" class="buttN" style="padding:1px;">243</a>
							
							<a href="search.cfm?start=2431&" class="buttN" style="padding:1px;">244</a>
							
							<a href="search.cfm?start=2441&" class="buttN" style="padding:1px;">245</a>
							
							<a href="search.cfm?start=2451&" class="buttN" style="padding:1px;">246</a>
							
							<a href="search.cfm?start=2461&" class="buttN" style="padding:1px;">247</a>
							
							<a href="search.cfm?start=2471&" class="buttN" style="padding:1px;">248</a>
							
							<a href="search.cfm?start=2481&" class="buttN" style="padding:1px;">249</a>
							
							<a href="search.cfm?start=2491&" class="buttN" style="padding:1px;">250</a>
							
							<a href="search.cfm?start=2501&" class="buttN" style="padding:1px;">251</a>
							
							<a href="search.cfm?start=2511&" class="buttN" style="padding:1px;">252</a>
							
							<a href="search.cfm?start=2521&" class="buttN" style="padding:1px;">253</a>
							
							<a href="search.cfm?start=2531&" class="buttN" style="padding:1px;">254</a>
							
							<a href="search.cfm?start=2541&" class="buttN" style="padding:1px;">255</a>
							
							<a href="search.cfm?start=2551&" class="buttN" style="padding:1px;">256</a>
							
							<a href="search.cfm?start=2561&" class="buttN" style="padding:1px;">257</a>
							
							<a href="search.cfm?start=2571&" class="buttN" style="padding:1px;">258</a>
							
							<a href="search.cfm?start=2581&" class="buttN" style="padding:1px;">259</a>
							
							<a href="search.cfm?start=2591&" class="buttN" style="padding:1px;">260</a>
							
							<a href="search.cfm?start=2601&" class="buttN" style="padding:1px;">261</a>
							
							<a href="search.cfm?start=2611&" class="buttN" style="padding:1px;">262</a>
							
							<a href="search.cfm?start=2621&" class="buttN" style="padding:1px;">263</a>
							
							<a href="search.cfm?start=2631&" class="buttN" style="padding:1px;">264</a>
							
							<a href="search.cfm?start=2641&" class="buttN" style="padding:1px;">265</a>
							
							<a href="search.cfm?start=2651&" class="buttN" style="padding:1px;">266</a>
							
							<a href="search.cfm?start=2661&" class="buttN" style="padding:1px;">267</a>
							
							<a href="search.cfm?start=2671&" class="buttN" style="padding:1px;">268</a>
							
							<a href="search.cfm?start=2681&" class="buttN" style="padding:1px;">269</a>
							
							<a href="search.cfm?start=2691&" class="buttN" style="padding:1px;">270</a>
							
							<a href="search.cfm?start=2701&" class="buttN" style="padding:1px;">271</a>
							
							<a href="search.cfm?start=2711&" class="buttN" style="padding:1px;">272</a>
							
							<a href="search.cfm?start=2721&" class="buttN" style="padding:1px;">273</a>
							
							<a href="search.cfm?start=2731&" class="buttN" style="padding:1px;">274</a>
							
							<a href="search.cfm?start=2741&" class="buttN" style="padding:1px;">275</a>
							
							<a href="search.cfm?start=2751&" class="buttN" style="padding:1px;">276</a>
							
							<a href="search.cfm?start=2761&" class="buttN" style="padding:1px;">277</a>
							
							<a href="search.cfm?start=2771&" class="buttN" style="padding:1px;">278</a>
							
							<a href="search.cfm?start=2781&" class="buttN" style="padding:1px;">279</a>
							
							<a href="search.cfm?start=2791&" class="buttN" style="padding:1px;">280</a>
							
							<a href="search.cfm?start=2801&" class="buttN" style="padding:1px;">281</a>
							
							<a href="search.cfm?start=2811&" class="buttN" style="padding:1px;">282</a>
							
							<a href="search.cfm?start=2821&" class="buttN" style="padding:1px;">283</a>
							
							<a href="search.cfm?start=2831&" class="buttN" style="padding:1px;">284</a>
							
							<a href="search.cfm?start=2841&" class="buttN" style="padding:1px;">285</a>
							
							<a href="search.cfm?start=2851&" class="buttN" style="padding:1px;">286</a>
							
							<a href="search.cfm?start=2861&" class="buttN" style="padding:1px;">287</a>
							
							<a href="search.cfm?start=2871&" class="buttN" style="padding:1px;">288</a>
							
							<a href="search.cfm?start=2881&" class="buttN" style="padding:1px;">289</a>
							
							<a href="search.cfm?start=2891&" class="buttN" style="padding:1px;">290</a>
							
							<a href="search.cfm?start=2901&" class="buttN" style="padding:1px;">291</a>
							
							<a href="search.cfm?start=2911&" class="buttN" style="padding:1px;">292</a>
							
							<a href="search.cfm?start=2921&" class="buttN" style="padding:1px;">293</a>
							
							<a href="search.cfm?start=2931&" class="buttN" style="padding:1px;">294</a>
							
							<a href="search.cfm?start=2941&" class="buttN" style="padding:1px;">295</a>
							
							<a href="search.cfm?start=2951&" class="buttN" style="padding:1px;">296</a>
							
							<a href="search.cfm?start=2961&" class="buttN" style="padding:1px;">297</a>
							
							<a href="search.cfm?start=2971&" class="buttN" style="padding:1px;">298</a>
							
							<a href="search.cfm?start=2981&" class="buttN" style="padding:1px;">299</a>
							
							<a href="search.cfm?start=2991&" class="buttN" style="padding:1px;">300</a>
							
							<a href="search.cfm?start=3001&" class="buttN" style="padding:1px;">301</a>
							
							<a href="search.cfm?start=3011&" class="buttN" style="padding:1px;">302</a>
							
							<a href="search.cfm?start=3021&" class="buttN" style="padding:1px;">303</a>
							
							<a href="search.cfm?start=3031&" class="buttN" style="padding:1px;">304</a>
							
							<a href="search.cfm?start=3041&" class="buttN" style="padding:1px;">305</a>
							
							<a href="search.cfm?start=3051&" class="buttN" style="padding:1px;">306</a>
							
							<a href="search.cfm?start=3061&" class="buttN" style="padding:1px;">307</a>
							
							<a href="search.cfm?start=3071&" class="buttN" style="padding:1px;">308</a>
							
							<a href="search.cfm?start=3081&" class="buttN" style="padding:1px;">309</a>
							
							<a href="search.cfm?start=3091&" class="buttN" style="padding:1px;">310</a>
							
							<a href="search.cfm?start=3101&" class="buttN" style="padding:1px;">311</a>
							
							<a href="search.cfm?start=3111&" class="buttN" style="padding:1px;">312</a>
							
							<a href="search.cfm?start=3121&" class="buttN" style="padding:1px;">313</a>
							
							<a href="search.cfm?start=3131&" class="buttN" style="padding:1px;">314</a>
							
							<a href="search.cfm?start=3141&" class="buttN" style="padding:1px;">315</a>
							
							<a href="search.cfm?start=3151&" class="buttN" style="padding:1px;">316</a>
							
							<a href="search.cfm?start=3161&" class="buttN" style="padding:1px;">317</a>
							
							<a href="search.cfm?start=3171&" class="buttN" style="padding:1px;">318</a>
							
							<a href="search.cfm?start=3181&" class="buttN" style="padding:1px;">319</a>
							
							<a href="search.cfm?start=3191&" class="buttN" style="padding:1px;">320</a>
							
							<a href="search.cfm?start=3201&" class="buttN" style="padding:1px;">321</a>
							
							<a href="search.cfm?start=3211&" class="buttN" style="padding:1px;">322</a>
							
							<a href="search.cfm?start=3221&" class="buttN" style="padding:1px;">323</a>
							
							<a href="search.cfm?start=3231&" class="buttN" style="padding:1px;">324</a>
							
							<a href="search.cfm?start=3241&" class="buttN" style="padding:1px;">325</a>
							
							<a href="search.cfm?start=3251&" class="buttN" style="padding:1px;">326</a>
							
							<a href="search.cfm?start=3261&" class="buttN" style="padding:1px;">327</a>
							
							<a href="search.cfm?start=3271&" class="buttN" style="padding:1px;">328</a>
							
							<a href="search.cfm?start=3281&" class="buttN" style="padding:1px;">329</a>
							
							<a href="search.cfm?start=3291&" class="buttN" style="padding:1px;">330</a>
							
							<a href="search.cfm?start=3301&" class="buttN" style="padding:1px;">331</a>
							
							<a href="search.cfm?start=3311&" class="buttN" style="padding:1px;">332</a>
							
							<a href="search.cfm?start=3321&" class="buttN" style="padding:1px;">333</a>
							
							<a href="search.cfm?start=3331&" class="buttN" style="padding:1px;">334</a>
							
							<a href="search.cfm?start=3341&" class="buttN" style="padding:1px;">335</a>
							
							<a href="search.cfm?start=3351&" class="buttN" style="padding:1px;">336</a>
							
							<a href="search.cfm?start=3361&" class="buttN" style="padding:1px;">337</a>
							
							<a href="search.cfm?start=3371&" class="buttN" style="padding:1px;">338</a>
							
							<a href="search.cfm?start=3381&" class="buttN" style="padding:1px;">339</a>
							
							<a href="search.cfm?start=3391&" class="buttN" style="padding:1px;">340</a>
							
							<a href="search.cfm?start=3401&" class="buttN" style="padding:1px;">341</a>
							
							<a href="search.cfm?start=3411&" class="buttN" style="padding:1px;">342</a>
							
							<a href="search.cfm?start=3421&" class="buttN" style="padding:1px;">343</a>
							
							<a href="search.cfm?start=3431&" class="buttN" style="padding:1px;">344</a>
							
							<a href="search.cfm?start=3441&" class="buttN" style="padding:1px;">345</a>
							
							<a href="search.cfm?start=3451&" class="buttN" style="padding:1px;">346</a>
							
							<a href="search.cfm?start=3461&" class="buttN" style="padding:1px;">347</a>
							
							<a href="search.cfm?start=3471&" class="buttN" style="padding:1px;">348</a>
							
							<a href="search.cfm?start=3481&" class="buttN" style="padding:1px;">349</a>
							
							<a href="search.cfm?start=3491&" class="buttN" style="padding:1px;">350</a>
							
							<a href="search.cfm?start=3501&" class="buttN" style="padding:1px;">351</a>
							
							<a href="search.cfm?start=3511&" class="buttN" style="padding:1px;">352</a>
							
							<a href="search.cfm?start=3521&" class="buttN" style="padding:1px;">353</a>
							
							<a href="search.cfm?start=3531&" class="buttN" style="padding:1px;">354</a>
							
							<a href="search.cfm?start=3541&" class="buttN" style="padding:1px;">355</a>
							
							<a href="search.cfm?start=3551&" class="buttN" style="padding:1px;">356</a>
							
							<a href="search.cfm?start=3561&" class="buttN" style="padding:1px;">357</a>
							
							<a href="search.cfm?start=3571&" class="buttN" style="padding:1px;">358</a>
							
							<a href="search.cfm?start=3581&" class="buttN" style="padding:1px;">359</a>
							
							<a href="search.cfm?start=3591&" class="buttN" style="padding:1px;">360</a>
							
							<a href="search.cfm?start=3601&" class="buttN" style="padding:1px;">361</a>
							
							<a href="search.cfm?start=3611&" class="buttN" style="padding:1px;">362</a>
							
							<a href="search.cfm?start=3621&" class="buttN" style="padding:1px;">363</a>
							
							<a href="search.cfm?start=3631&" class="buttN" style="padding:1px;">364</a>
							
							<a href="search.cfm?start=3641&" class="buttN" style="padding:1px;">365</a>
							
							<a href="search.cfm?start=3651&" class="buttN" style="padding:1px;">366</a>
							
							<a href="search.cfm?start=3661&" class="buttN" style="padding:1px;">367</a>
							
							<a href="search.cfm?start=3671&" class="buttN" style="padding:1px;">368</a>
							
							<a href="search.cfm?start=3681&" class="buttN" style="padding:1px;">369</a>
							
							<a href="search.cfm?start=3691&" class="buttN" style="padding:1px;">370</a>
							
							<a href="search.cfm?start=3701&" class="buttN" style="padding:1px;">371</a>
							
							<a href="search.cfm?start=3711&" class="buttN" style="padding:1px;">372</a>
							
							<a href="search.cfm?start=3721&" class="buttN" style="padding:1px;">373</a>
							
							<a href="search.cfm?start=3731&" class="buttN" style="padding:1px;">374</a>
							
							<a href="search.cfm?start=3741&" class="buttN" style="padding:1px;">375</a>
							
							<a href="search.cfm?start=3751&" class="buttN" style="padding:1px;">376</a>
							
							<a href="search.cfm?start=3761&" class="buttN" style="padding:1px;">377</a>
							
							<a href="search.cfm?start=3771&" class="buttN" style="padding:1px;">378</a>
							
							<a href="search.cfm?start=3781&" class="buttN" style="padding:1px;">379</a>
							
							<a href="search.cfm?start=3791&" class="buttN" style="padding:1px;">380</a>
							
							<a href="search.cfm?start=3801&" class="buttN" style="padding:1px;">381</a>
							
							<a href="search.cfm?start=3811&" class="buttN" style="padding:1px;">382</a>
							
							<a href="search.cfm?start=3821&" class="buttN" style="padding:1px;">383</a>
							
							<a href="search.cfm?start=3831&" class="buttN" style="padding:1px;">384</a>
							
							<a href="search.cfm?start=3841&" class="buttN" style="padding:1px;">385</a>
							
							<a href="search.cfm?start=3851&" class="buttN" style="padding:1px;">386</a>
							
							<a href="search.cfm?start=3861&" class="buttN" style="padding:1px;">387</a>
							
							<a href="search.cfm?start=3871&" class="buttN" style="padding:1px;">388</a>
							
							<a href="search.cfm?start=3881&" class="buttN" style="padding:1px;">389</a>
							
							<a href="search.cfm?start=3891&" class="buttN" style="padding:1px;">390</a>
							
							<a href="search.cfm?start=3901&" class="buttN" style="padding:1px;">391</a>
							
							<a href="search.cfm?start=3911&" class="buttN" style="padding:1px;">392</a>
							
							<a href="search.cfm?start=3921&" class="buttN" style="padding:1px;">393</a>
							
							<a href="search.cfm?start=3931&" class="buttN" style="padding:1px;">394</a>
							
							<a href="search.cfm?start=3941&" class="buttN" style="padding:1px;">395</a>
							
							<a href="search.cfm?start=3951&" class="buttN" style="padding:1px;">396</a>
							
							<a href="search.cfm?start=3961&" class="buttN" style="padding:1px;">397</a>
							
							<a href="search.cfm?start=3971&" class="buttN" style="padding:1px;">398</a>
							
							<a href="search.cfm?start=3981&" class="buttN" style="padding:1px;">399</a>
							
							<a href="search.cfm?start=3991&" class="buttN" style="padding:1px;">400</a>
							
							<a href="search.cfm?start=4001&" class="buttN" style="padding:1px;">401</a>
							
							<a href="search.cfm?start=4011&" class="buttN" style="padding:1px;">402</a>
							
							<a href="search.cfm?start=4021&" class="buttN" style="padding:1px;">403</a>
							
							<a href="search.cfm?start=4031&" class="buttN" style="padding:1px;">404</a>
							
							<a href="search.cfm?start=4041&" class="buttN" style="padding:1px;">405</a>
							
							<a href="search.cfm?start=4051&" class="buttN" style="padding:1px;">406</a>
							
							<a href="search.cfm?start=4061&" class="buttN" style="padding:1px;">407</a>
							
							<a href="search.cfm?start=4071&" class="buttN" style="padding:1px;">408</a>
							
							<a href="search.cfm?start=4081&" class="buttN" style="padding:1px;">409</a>
							
							<a href="search.cfm?start=4091&" class="buttN" style="padding:1px;">410</a>
							
							<a href="search.cfm?start=4101&" class="buttN" style="padding:1px;">411</a>
							
							<a href="search.cfm?start=4111&" class="buttN" style="padding:1px;">412</a>
							
							<a href="search.cfm?start=4121&" class="buttN" style="padding:1px;">413</a>
							
							<a href="search.cfm?start=4131&" class="buttN" style="padding:1px;">414</a>
							
							<a href="search.cfm?start=4141&" class="buttN" style="padding:1px;">415</a>
							
							<a href="search.cfm?start=4151&" class="buttN" style="padding:1px;">416</a>
							
							<a href="search.cfm?start=4161&" class="buttN" style="padding:1px;">417</a>
							
							<a href="search.cfm?start=4171&" class="buttN" style="padding:1px;">418</a>
							
							<a href="search.cfm?start=4181&" class="buttN" style="padding:1px;">419</a>
							
							<a href="search.cfm?start=4191&" class="buttN" style="padding:1px;">420</a>
							
							<a href="search.cfm?start=4201&" class="buttN" style="padding:1px;">421</a>
							
							<a href="search.cfm?start=4211&" class="buttN" style="padding:1px;">422</a>
							
							<a href="search.cfm?start=4221&" class="buttN" style="padding:1px;">423</a>
							
							<a href="search.cfm?start=4231&" class="buttN" style="padding:1px;">424</a>
							
							<a href="search.cfm?start=4241&" class="buttN" style="padding:1px;">425</a>
							
							<a href="search.cfm?start=4251&" class="buttN" style="padding:1px;">426</a>
							
							<a href="search.cfm?start=4261&" class="buttN" style="padding:1px;">427</a>
							
							<a href="search.cfm?start=4271&" class="buttN" style="padding:1px;">428</a>
							
							<a href="search.cfm?start=4281&" class="buttN" style="padding:1px;">429</a>
							
							<a href="search.cfm?start=4291&" class="buttN" style="padding:1px;">430</a>
							
							<a href="search.cfm?start=4301&" class="buttN" style="padding:1px;">431</a>
							
							<a href="search.cfm?start=4311&" class="buttN" style="padding:1px;">432</a>
							
							<a href="search.cfm?start=4321&" class="buttN" style="padding:1px;">433</a>
							
							<a href="search.cfm?start=4331&" class="buttN" style="padding:1px;">434</a>
							
							<a href="search.cfm?start=4341&" class="buttN" style="padding:1px;">435</a>
							
							<a href="search.cfm?start=4351&" class="buttN" style="padding:1px;">436</a>
							
							<a href="search.cfm?start=4361&" class="buttN" style="padding:1px;">437</a>
							
							<a href="search.cfm?start=4371&" class="buttN" style="padding:1px;">438</a>
							
							<a href="search.cfm?start=4381&" class="buttN" style="padding:1px;">439</a>
							
							<a href="search.cfm?start=4391&" class="buttN" style="padding:1px;">440</a>
							
							<a href="search.cfm?start=4401&" class="buttN" style="padding:1px;">441</a>
							
							<a href="search.cfm?start=4411&" class="buttN" style="padding:1px;">442</a>
							
							<a href="search.cfm?start=4421&" class="buttN" style="padding:1px;">443</a>
							
							<a href="search.cfm?start=4431&" class="buttN" style="padding:1px;">444</a>
							
							<a href="search.cfm?start=4441&" class="buttN" style="padding:1px;">445</a>
							
							<a href="search.cfm?start=4451&" class="buttN" style="padding:1px;">446</a>
							
							<a href="search.cfm?start=4461&" class="buttN" style="padding:1px;">447</a>
							
							<a href="search.cfm?start=4471&" class="buttN" style="padding:1px;">448</a>
							
							<a href="search.cfm?start=4481&" class="buttN" style="padding:1px;">449</a>
							
							<a href="search.cfm?start=4491&" class="buttN" style="padding:1px;">450</a>
							
							<a href="search.cfm?start=4501&" class="buttN" style="padding:1px;">451</a>
							
							<a href="search.cfm?start=4511&" class="buttN" style="padding:1px;">452</a>
							
							<a href="search.cfm?start=4521&" class="buttN" style="padding:1px;">453</a>
							
							<a href="search.cfm?start=4531&" class="buttN" style="padding:1px;">454</a>
							
							<a href="search.cfm?start=4541&" class="buttN" style="padding:1px;">455</a>
							
							<a href="search.cfm?start=4551&" class="buttN" style="padding:1px;">456</a>
							
							<a href="search.cfm?start=4561&" class="buttN" style="padding:1px;">457</a>
							
							<a href="search.cfm?start=4571&" class="buttN" style="padding:1px;">458</a>
							
							<a href="search.cfm?start=4581&" class="buttN" style="padding:1px;">459</a>
							
							<a href="search.cfm?start=4591&" class="buttN" style="padding:1px;">460</a>
							
							<a href="search.cfm?start=4601&" class="buttN" style="padding:1px;">461</a>
							
							<a href="search.cfm?start=4611&" class="buttN" style="padding:1px;">462</a>
							
							<a href="search.cfm?start=4621&" class="buttN" style="padding:1px;">463</a>
							
							<a href="search.cfm?start=4631&" class="buttN" style="padding:1px;">464</a>
							
							<a href="search.cfm?start=4641&" class="buttN" style="padding:1px;">465</a>
							
							<a href="search.cfm?start=4651&" class="buttN" style="padding:1px;">466</a>
							
							<a href="search.cfm?start=4661&" class="buttN" style="padding:1px;">467</a>
							
							<a href="search.cfm?start=4671&" class="buttN" style="padding:1px;">468</a>
							
							<a href="search.cfm?start=4681&" class="buttN" style="padding:1px;">469</a>
							
							<a href="search.cfm?start=4691&" class="buttN" style="padding:1px;">470</a>
							
							<a href="search.cfm?start=4701&" class="buttN" style="padding:1px;">471</a>
							
							<a href="search.cfm?start=4711&" class="buttN" style="padding:1px;">472</a>
							
							<a href="search.cfm?start=4721&" class="buttN" style="padding:1px;">473</a>
							
							<a href="search.cfm?start=4731&" class="buttN" style="padding:1px;">474</a>
							
							<a href="search.cfm?start=4741&" class="buttN" style="padding:1px;">475</a>
							
							<a href="search.cfm?start=4751&" class="buttN" style="padding:1px;">476</a>
							
							<a href="search.cfm?start=4761&" class="buttN" style="padding:1px;">477</a>
							
							<a href="search.cfm?start=4771&" class="buttN" style="padding:1px;">478</a>
							
							<a href="search.cfm?start=4781&" class="buttN" style="padding:1px;">479</a>
							
							<a href="search.cfm?start=4791&" class="buttN" style="padding:1px;">480</a>
							
							<a href="search.cfm?start=4801&" class="buttN" style="padding:1px;">481</a>
							
							<a href="search.cfm?start=4811&" class="buttN" style="padding:1px;">482</a>
							
							<a href="search.cfm?start=4821&" class="buttN" style="padding:1px;">483</a>
							
							<a href="search.cfm?start=4831&" class="buttN" style="padding:1px;">484</a>
							
							<a href="search.cfm?start=4841&" class="buttN" style="padding:1px;">485</a>
							
							<a href="search.cfm?start=4851&" class="buttN" style="padding:1px;">486</a>
							
							<a href="search.cfm?start=4861&" class="buttN" style="padding:1px;">487</a>
							
							<a href="search.cfm?start=4871&" class="buttN" style="padding:1px;">488</a>
							
							<a href="search.cfm?start=4881&" class="buttN" style="padding:1px;">489</a>
							
							<a href="search.cfm?start=4891&" class="buttN" style="padding:1px;">490</a>
							
							<a href="search.cfm?start=4901&" class="buttN" style="padding:1px;">491</a>
							
							<a href="search.cfm?start=4911&" class="buttN" style="padding:1px;">492</a>
							
							<a href="search.cfm?start=4921&" class="buttN" style="padding:1px;">493</a>
							
							<a href="search.cfm?start=4931&" class="buttN" style="padding:1px;">494</a>
							
							<a href="search.cfm?start=4941&" class="buttN" style="padding:1px;">495</a>
							
							<a href="search.cfm?start=4951&" class="buttN" style="padding:1px;">496</a>
							
							<a href="search.cfm?start=4961&" class="buttN" style="padding:1px;">497</a>
							
							<a href="search.cfm?start=4971&" class="buttN" style="padding:1px;">498</a>
							
							<a href="search.cfm?start=4981&" class="buttN" style="padding:1px;">499</a>
							
							<a href="search.cfm?start=4991&" class="buttN" style="padding:1px;">500</a>
							
							<a href="search.cfm?start=5001&" class="buttN" style="padding:1px;">501</a>
							
							<a href="search.cfm?start=5011&" class="buttN" style="padding:1px;">502</a>
							
							<a href="search.cfm?start=5021&" class="buttN" style="padding:1px;">503</a>
							
							<a href="search.cfm?start=5031&" class="buttN" style="padding:1px;">504</a>
							
							<a href="search.cfm?start=5041&" class="buttN" style="padding:1px;">505</a>
							
							<a href="search.cfm?start=5051&" class="buttN" style="padding:1px;">506</a>
							
							<a href="search.cfm?start=5061&" class="buttN" style="padding:1px;">507</a>
							
							<a href="search.cfm?start=5071&" class="buttN" style="padding:1px;">508</a>
							
							<a href="search.cfm?start=5081&" class="buttN" style="padding:1px;">509</a>
							
							<a href="search.cfm?start=5091&" class="buttN" style="padding:1px;">510</a>
							
							<a href="search.cfm?start=5101&" class="buttN" style="padding:1px;">511</a>
							
							<a href="search.cfm?start=5111&" class="buttN" style="padding:1px;">512</a>
							
							<a href="search.cfm?start=5121&" class="buttN" style="padding:1px;">513</a>
							
							<a href="search.cfm?start=5131&" class="buttN" style="padding:1px;">514</a>
							
							<a href="search.cfm?start=5141&" class="buttN" style="padding:1px;">515</a>
							
							<a href="search.cfm?start=5151&" class="buttN" style="padding:1px;">516</a>
							
							<a href="search.cfm?start=5161&" class="buttN" style="padding:1px;">517</a>
							
							<a href="search.cfm?start=5171&" class="buttN" style="padding:1px;">518</a>
							
							<a href="search.cfm?start=5181&" class="buttN" style="padding:1px;">519</a>
							
							<a href="search.cfm?start=5191&" class="buttN" style="padding:1px;">520</a>
							
							<a href="search.cfm?start=5201&" class="buttN" style="padding:1px;">521</a>
							
							<a href="search.cfm?start=5211&" class="buttN" style="padding:1px;">522</a>
							
							<a href="search.cfm?start=5221&" class="buttN" style="padding:1px;">523</a>
							
							<a href="search.cfm?start=5231&" class="buttN" style="padding:1px;">524</a>
							
							<a href="search.cfm?start=5241&" class="buttN" style="padding:1px;">525</a>
							
							<a href="search.cfm?start=5251&" class="buttN" style="padding:1px;">526</a>
							
							<a href="search.cfm?start=5261&" class="buttN" style="padding:1px;">527</a>
							
							<a href="search.cfm?start=5271&" class="buttN" style="padding:1px;">528</a>
							
							<a href="search.cfm?start=5281&" class="buttN" style="padding:1px;">529</a>
							
							<a href="search.cfm?start=5291&" class="buttN" style="padding:1px;">530</a>
							
							<a href="search.cfm?start=5301&" class="buttN" style="padding:1px;">531</a>
							
							<a href="search.cfm?start=5311&" class="buttN" style="padding:1px;">532</a>
							
							<a href="search.cfm?start=5321&" class="buttN" style="padding:1px;">533</a>
							
							<a href="search.cfm?start=5331&" class="buttN" style="padding:1px;">534</a>
							
							<a href="search.cfm?start=5341&" class="buttN" style="padding:1px;">535</a>
							
							<a href="search.cfm?start=5351&" class="buttN" style="padding:1px;">536</a>
							
							<a href="search.cfm?start=5361&" class="buttN" style="padding:1px;">537</a>
							
							<a href="search.cfm?start=5371&" class="buttN" style="padding:1px;">538</a>
							
							<a href="search.cfm?start=5381&" class="buttN" style="padding:1px;">539</a>
							
							<a href="search.cfm?start=5391&" class="buttN" style="padding:1px;">540</a>
							
							<a href="search.cfm?start=5401&" class="buttN" style="padding:1px;">541</a>
							
							<a href="search.cfm?start=5411&" class="buttN" style="padding:1px;">542</a>
							
							<a href="search.cfm?start=5421&" class="buttN" style="padding:1px;">543</a>
							
							<a href="search.cfm?start=5431&" class="buttN" style="padding:1px;">544</a>
							
							<a href="search.cfm?start=5441&" class="buttN" style="padding:1px;">545</a>
							
							<a href="search.cfm?start=5451&" class="buttN" style="padding:1px;">546</a>
							
							<a href="search.cfm?start=5461&" class="buttN" style="padding:1px;">547</a>
							
							<a href="search.cfm?start=5471&" class="buttN" style="padding:1px;">548</a>
							
							<a href="search.cfm?start=5481&" class="buttN" style="padding:1px;">549</a>
							
							<a href="search.cfm?start=5491&" class="buttN" style="padding:1px;">550</a>
							
							<a href="search.cfm?start=5501&" class="buttN" style="padding:1px;">551</a>
							
							<a href="search.cfm?start=5511&" class="buttN" style="padding:1px;">552</a>
							
							<a href="search.cfm?start=5521&" class="buttN" style="padding:1px;">553</a>
							
							<a href="search.cfm?start=5531&" class="buttN" style="padding:1px;">554</a>
							
							<a href="search.cfm?start=5541&" class="buttN" style="padding:1px;">555</a>
							
							<a href="search.cfm?start=5551&" class="buttN" style="padding:1px;">556</a>
							
							<a href="search.cfm?start=5561&" class="buttN" style="padding:1px;">557</a>
							
							<a href="search.cfm?start=5571&" class="buttN" style="padding:1px;">558</a>
							
							<a href="search.cfm?start=5581&" class="buttN" style="padding:1px;">559</a>
							
							<a href="search.cfm?start=5591&" class="buttN" style="padding:1px;">560</a>
							
							<a href="search.cfm?start=5601&" class="buttN" style="padding:1px;">561</a>
							
							<a href="search.cfm?start=5611&" class="buttN" style="padding:1px;">562</a>
							
							<a href="search.cfm?start=5621&" class="buttN" style="padding:1px;">563</a>
							
							<a href="search.cfm?start=5631&" class="buttN" style="padding:1px;">564</a>
							
							<a href="search.cfm?start=5641&" class="buttN" style="padding:1px;">565</a>
							
							<a href="search.cfm?start=5651&" class="buttN" style="padding:1px;">566</a>
							
							<a href="search.cfm?start=5661&" class="buttN" style="padding:1px;">567</a>
							
							<a href="search.cfm?start=5671&" class="buttN" style="padding:1px;">568</a>
							
							<a href="search.cfm?start=5681&" class="buttN" style="padding:1px;">569</a>
							
							<a href="search.cfm?start=5691&" class="buttN" style="padding:1px;">570</a>
							
							<a href="search.cfm?start=5701&" class="buttN" style="padding:1px;">571</a>
							
							<a href="search.cfm?start=5711&" class="buttN" style="padding:1px;">572</a>
							
							<a href="search.cfm?start=5721&" class="buttN" style="padding:1px;">573</a>
							
							<a href="search.cfm?start=5731&" class="buttN" style="padding:1px;">574</a>
							
							<a href="search.cfm?start=5741&" class="buttN" style="padding:1px;">575</a>
							
							<a href="search.cfm?start=5751&" class="buttN" style="padding:1px;">576</a>
							
							<a href="search.cfm?start=5761&" class="buttN" style="padding:1px;">577</a>
							
							<a href="search.cfm?start=5771&" class="buttN" style="padding:1px;">578</a>
							
							<a href="search.cfm?start=5781&" class="buttN" style="padding:1px;">579</a>
							
							<a href="search.cfm?start=5791&" class="buttN" style="padding:1px;">580</a>
							
							<a href="search.cfm?start=5801&" class="buttN" style="padding:1px;">581</a>
							
							<a href="search.cfm?start=5811&" class="buttN" style="padding:1px;">582</a>
							
							<a href="search.cfm?start=5821&" class="buttN" style="padding:1px;">583</a>
							
							<a href="search.cfm?start=5831&" class="buttN" style="padding:1px;">584</a>
							
							<a href="search.cfm?start=5841&" class="buttN" style="padding:1px;">585</a>
							
							<a href="search.cfm?start=5851&" class="buttN" style="padding:1px;">586</a>
							
							<a href="search.cfm?start=5861&" class="buttN" style="padding:1px;">587</a>
							
							<a href="search.cfm?start=5871&" class="buttN" style="padding:1px;">588</a>
							
							<a href="search.cfm?start=5881&" class="buttN" style="padding:1px;">589</a>
							
							<a href="search.cfm?start=5891&" class="buttN" style="padding:1px;">590</a>
							
							<a href="search.cfm?start=5901&" class="buttN" style="padding:1px;">591</a>
							
							<a href="search.cfm?start=5911&" class="buttN" style="padding:1px;">592</a>
							
							<a href="search.cfm?start=5921&" class="buttN" style="padding:1px;">593</a>
							
							<a href="search.cfm?start=5931&" class="buttN" style="padding:1px;">594</a>
							
							<a href="search.cfm?start=5941&" class="buttN" style="padding:1px;">595</a>
							
							<a href="search.cfm?start=5951&" class="buttN" style="padding:1px;">596</a>
							
							<a href="search.cfm?start=5961&" class="buttN" style="padding:1px;">597</a>
							
							<a href="search.cfm?start=5971&" class="buttN" style="padding:1px;">598</a>
							
							<a href="search.cfm?start=5981&" class="buttN" style="padding:1px;">599</a>
							
							<a href="search.cfm?start=5991&" class="buttN" style="padding:1px;">600</a>
							
							<a href="search.cfm?start=6001&" class="buttN" style="padding:1px;">601</a>
							
							<a href="search.cfm?start=6011&" class="buttN" style="padding:1px;">602</a>
							
							<a href="search.cfm?start=6021&" class="buttN" style="padding:1px;">603</a>
							
							<a href="search.cfm?start=6031&" class="buttN" style="padding:1px;">604</a>
							
							<a href="search.cfm?start=6041&" class="buttN" style="padding:1px;">605</a>
							
							<a href="search.cfm?start=6051&" class="buttN" style="padding:1px;">606</a>
							
							<a href="search.cfm?start=6061&" class="buttN" style="padding:1px;">607</a>
							
							<a href="search.cfm?start=6071&" class="buttN" style="padding:1px;">608</a>
							
							<a href="search.cfm?start=6081&" class="buttN" style="padding:1px;">609</a>
							
							<a href="search.cfm?start=6091&" class="buttN" style="padding:1px;">610</a>
							
							<a href="search.cfm?start=6101&" class="buttN" style="padding:1px;">611</a>
							
							<a href="search.cfm?start=6111&" class="buttN" style="padding:1px;">612</a>
							
							<a href="search.cfm?start=6121&" class="buttN" style="padding:1px;">613</a>
							
							<a href="search.cfm?start=6131&" class="buttN" style="padding:1px;">614</a>
							
							<a href="search.cfm?start=6141&" class="buttN" style="padding:1px;">615</a>
							
							<a href="search.cfm?start=6151&" class="buttN" style="padding:1px;">616</a>
							
							<a href="search.cfm?start=6161&" class="buttN" style="padding:1px;">617</a>
							
							<a href="search.cfm?start=6171&" class="buttN" style="padding:1px;">618</a>
							
							<a href="search.cfm?start=6181&" class="buttN" style="padding:1px;">619</a>
							
							<a href="search.cfm?start=6191&" class="buttN" style="padding:1px;">620</a>
							
							<a href="search.cfm?start=6201&" class="buttN" style="padding:1px;">621</a>
							
							<a href="search.cfm?start=6211&" class="buttN" style="padding:1px;">622</a>
							
							<a href="search.cfm?start=6221&" class="buttN" style="padding:1px;">623</a>
							
							<a href="search.cfm?start=6231&" class="buttN" style="padding:1px;">624</a>
							
							<a href="search.cfm?start=6241&" class="buttN" style="padding:1px;">625</a>
							
							<a href="search.cfm?start=6251&" class="buttN" style="padding:1px;">626</a>
							
							<a href="search.cfm?start=6261&" class="buttN" style="padding:1px;">627</a>
							
							<a href="search.cfm?start=6271&" class="buttN" style="padding:1px;">628</a>
							
							<a href="search.cfm?start=6281&" class="buttN" style="padding:1px;">629</a>
							
							<a href="search.cfm?start=6291&" class="buttN" style="padding:1px;">630</a>
							
							<a href="search.cfm?start=6301&" class="buttN" style="padding:1px;">631</a>
							
							<a href="search.cfm?start=6311&" class="buttN" style="padding:1px;">632</a>
							
							<a href="search.cfm?start=6321&" class="buttN" style="padding:1px;">633</a>
							
							<a href="search.cfm?start=6331&" class="buttN" style="padding:1px;">634</a>
							
							<a href="search.cfm?start=6341&" class="buttN" style="padding:1px;">635</a>
							
							<a href="search.cfm?start=6351&" class="buttN" style="padding:1px;">636</a>
							
							<a href="search.cfm?start=6361&" class="buttN" style="padding:1px;">637</a>
							
							<a href="search.cfm?start=6371&" class="buttN" style="padding:1px;">638</a>
							
							<a href="search.cfm?start=6381&" class="buttN" style="padding:1px;">639</a>
							
							<a href="search.cfm?start=6391&" class="buttN" style="padding:1px;">640</a>
							
							<a href="search.cfm?start=6401&" class="buttN" style="padding:1px;">641</a>
							
							<a href="search.cfm?start=6411&" class="buttN" style="padding:1px;">642</a>
							
							<a href="search.cfm?start=6421&" class="buttN" style="padding:1px;">643</a>
							
							<a href="search.cfm?start=6431&" class="buttN" style="padding:1px;">644</a>
							
							<a href="search.cfm?start=6441&" class="buttN" style="padding:1px;">645</a>
							
							<a href="search.cfm?start=6451&" class="buttN" style="padding:1px;">646</a>
							
							<a href="search.cfm?start=6461&" class="buttN" style="padding:1px;">647</a>
							
							<a href="search.cfm?start=6471&" class="buttN" style="padding:1px;">648</a>
							
							<a href="search.cfm?start=6481&" class="buttN" style="padding:1px;">649</a>
							
							<a href="search.cfm?start=6491&" class="buttN" style="padding:1px;">650</a>
							
							<a href="search.cfm?start=6501&" class="buttN" style="padding:1px;">651</a>
							
							<a href="search.cfm?start=6511&" class="buttN" style="padding:1px;">652</a>
							
							<a href="search.cfm?start=6521&" class="buttN" style="padding:1px;">653</a>
							
							<a href="search.cfm?start=6531&" class="buttN" style="padding:1px;">654</a>
							
							<a href="search.cfm?start=6541&" class="buttN" style="padding:1px;">655</a>
							
							<a href="search.cfm?start=6551&" class="buttN" style="padding:1px;">656</a>
							
							<a href="search.cfm?start=6561&" class="buttN" style="padding:1px;">657</a>
							
							<a href="search.cfm?start=6571&" class="buttN" style="padding:1px;">658</a>
							
							<a href="search.cfm?start=6581&" class="buttN" style="padding:1px;">659</a>
							
							<a href="search.cfm?start=6591&" class="buttN" style="padding:1px;">660</a>
							
							<a href="search.cfm?start=6601&" class="buttN" style="padding:1px;">661</a>
							
							<a href="search.cfm?start=6611&" class="buttN" style="padding:1px;">662</a>
							
							<a href="search.cfm?start=6621&" class="buttN" style="padding:1px;">663</a>
							
							<a href="search.cfm?start=6631&" class="buttN" style="padding:1px;">664</a>
							
							<a href="search.cfm?start=6641&" class="buttN" style="padding:1px;">665</a>
							
							<a href="search.cfm?start=6651&" class="buttN" style="padding:1px;">666</a>
							
							<a href="search.cfm?start=6661&" class="buttN" style="padding:1px;">667</a>
							
							<a href="search.cfm?start=6671&" class="buttN" style="padding:1px;">668</a>
							
							<a href="search.cfm?start=6681&" class="buttN" style="padding:1px;">669</a>
							
							<a href="search.cfm?start=6691&" class="buttN" style="padding:1px;">670</a>
							
							<a href="search.cfm?start=6701&" class="buttN" style="padding:1px;">671</a>
							
							<a href="search.cfm?start=6711&" class="buttN" style="padding:1px;">672</a>
							
							<a href="search.cfm?start=6721&" class="buttN" style="padding:1px;">673</a>
							
							<a href="search.cfm?start=6731&" class="buttN" style="padding:1px;">674</a>
							
							<a href="search.cfm?start=6741&" class="buttN" style="padding:1px;">675</a>
							
							<a href="search.cfm?start=6751&" class="buttN" style="padding:1px;">676</a>
							
							<a href="search.cfm?start=6761&" class="buttN" style="padding:1px;">677</a>
							
							<a href="search.cfm?start=6771&" class="buttN" style="padding:1px;">678</a>
							
							<a href="search.cfm?start=6781&" class="buttN" style="padding:1px;">679</a>
							
							<a href="search.cfm?start=6791&" class="buttN" style="padding:1px;">680</a>
							
							<a href="search.cfm?start=6801&" class="buttN" style="padding:1px;">681</a>
							
							<a href="search.cfm?start=6811&" class="buttN" style="padding:1px;">682</a>
							
							<a href="search.cfm?start=6821&" class="buttN" style="padding:1px;">683</a>
							
							<a href="search.cfm?start=6831&" class="buttN" style="padding:1px;">684</a>
							
							<a href="search.cfm?start=6841&" class="buttN" style="padding:1px;">685</a>
							
							<a href="search.cfm?start=6851&" class="buttN" style="padding:1px;">686</a>
							
							<a href="search.cfm?start=6861&" class="buttN" style="padding:1px;">687</a>
							
							<a href="search.cfm?start=6871&" class="buttN" style="padding:1px;">688</a>
							
							<a href="search.cfm?start=6881&" class="buttN" style="padding:1px;">689</a>
							
							<a href="search.cfm?start=6891&" class="buttN" style="padding:1px;">690</a>
							
							<a href="search.cfm?start=6901&" class="buttN" style="padding:1px;">691</a>
							
							<a href="search.cfm?start=6911&" class="buttN" style="padding:1px;">692</a>
							
							<a href="search.cfm?start=6921&" class="buttN" style="padding:1px;">693</a>
							
							<a href="search.cfm?start=6931&" class="buttN" style="padding:1px;">694</a>
							
							<a href="search.cfm?start=6941&" class="buttN" style="padding:1px;">695</a>
							
							<a href="search.cfm?start=6951&" class="buttN" style="padding:1px;">696</a>
							
							<a href="search.cfm?start=6961&" class="buttN" style="padding:1px;">697</a>
							
							<a href="search.cfm?start=6971&" class="buttN" style="padding:1px;">698</a>
							
							<a href="search.cfm?start=6981&" class="buttN" style="padding:1px;">699</a>
							
							<a href="search.cfm?start=6991&" class="buttN" style="padding:1px;">700</a>
							
							<a href="search.cfm?start=7001&" class="buttN" style="padding:1px;">701</a>
							
							<a href="search.cfm?start=7011&" class="buttN" style="padding:1px;">702</a>
							
							<a href="search.cfm?start=7021&" class="buttN" style="padding:1px;">703</a>
							
							<a href="search.cfm?start=7031&" class="buttN" style="padding:1px;">704</a>
							
							<a href="search.cfm?start=7041&" class="buttN" style="padding:1px;">705</a>
							
							<a href="search.cfm?start=7051&" class="buttN" style="padding:1px;">706</a>
							
							<a href="search.cfm?start=7061&" class="buttN" style="padding:1px;">707</a>
							
							<a href="search.cfm?start=7071&" class="buttN" style="padding:1px;">708</a>
							
							<a href="search.cfm?start=7081&" class="buttN" style="padding:1px;">709</a>
							
							<a href="search.cfm?start=7091&" class="buttN" style="padding:1px;">710</a>
							
							<a href="search.cfm?start=7101&" class="buttN" style="padding:1px;">711</a>
							
							<a href="search.cfm?start=7111&" class="buttN" style="padding:1px;">712</a>
							
							<a href="search.cfm?start=7121&" class="buttN" style="padding:1px;">713</a>
							
							<a href="search.cfm?start=7131&" class="buttN" style="padding:1px;">714</a>
							
							<a href="search.cfm?start=7141&" class="buttN" style="padding:1px;">715</a>
							
							<a href="search.cfm?start=7151&" class="buttN" style="padding:1px;">716</a>
							
							<a href="search.cfm?start=7161&" class="buttN" style="padding:1px;">717</a>
							
							<a href="search.cfm?start=7171&" class="buttN" style="padding:1px;">718</a>
							
							<a href="search.cfm?start=7181&" class="buttN" style="padding:1px;">719</a>
							
							<a href="search.cfm?start=7191&" class="buttN" style="padding:1px;">720</a>
							
							<a href="search.cfm?start=7201&" class="buttN" style="padding:1px;">721</a>
							
							<a href="search.cfm?start=7211&" class="buttN" style="padding:1px;">722</a>
							
							<a href="search.cfm?start=7221&" class="buttN" style="padding:1px;">723</a>
							
							<a href="search.cfm?start=7231&" class="buttN" style="padding:1px;">724</a>
							
							<a href="search.cfm?start=7241&" class="buttN" style="padding:1px;">725</a>
							
							<a href="search.cfm?start=7251&" class="buttN" style="padding:1px;">726</a>
							
							<a href="search.cfm?start=7261&" class="buttN" style="padding:1px;">727</a>
							
							<a href="search.cfm?start=7271&" class="buttN" style="padding:1px;">728</a>
							
							<a href="search.cfm?start=7281&" class="buttN" style="padding:1px;">729</a>
							
							<a href="search.cfm?start=7291&" class="buttN" style="padding:1px;">730</a>
							
							<a href="search.cfm?start=7301&" class="buttN" style="padding:1px;">731</a>
							
							<a href="search.cfm?start=7311&" class="buttN" style="padding:1px;">732</a>
							
							<a href="search.cfm?start=7321&" class="buttN" style="padding:1px;">733</a>
							
							<a href="search.cfm?start=7331&" class="buttN" style="padding:1px;">734</a>
							
							<a href="search.cfm?start=7341&" class="buttN" style="padding:1px;">735</a>
							
							<a href="search.cfm?start=7351&" class="buttN" style="padding:1px;">736</a>
							
							<a href="search.cfm?start=7361&" class="buttN" style="padding:1px;">737</a>
							
							<a href="search.cfm?start=7371&" class="buttN" style="padding:1px;">738</a>
							
							<a href="search.cfm?start=7381&" class="buttN" style="padding:1px;">739</a>
							
							<a href="search.cfm?start=7391&" class="buttN" style="padding:1px;">740</a>
							
							<a href="search.cfm?start=7401&" class="buttN" style="padding:1px;">741</a>
							
							<a href="search.cfm?start=7411&" class="buttN" style="padding:1px;">742</a>
							
							<a href="search.cfm?start=7421&" class="buttN" style="padding:1px;">743</a>
							
							<a href="search.cfm?start=7431&" class="buttN" style="padding:1px;">744</a>
							
							<a href="search.cfm?start=7441&" class="buttN" style="padding:1px;">745</a>
							
							<a href="search.cfm?start=7451&" class="buttN" style="padding:1px;">746</a>
							
							<a href="search.cfm?start=7461&" class="buttN" style="padding:1px;">747</a>
							
							<a href="search.cfm?start=7471&" class="buttN" style="padding:1px;">748</a>
							
							<a href="search.cfm?start=7481&" class="buttN" style="padding:1px;">749</a>
							
							<a href="search.cfm?start=7491&" class="buttN" style="padding:1px;">750</a>
							
							<a href="search.cfm?start=7501&" class="buttN" style="padding:1px;">751</a>
							
							<a href="search.cfm?start=7511&" class="buttN" style="padding:1px;">752</a>
							
							<a href="search.cfm?start=7521&" class="buttN" style="padding:1px;">753</a>
							
							<a href="search.cfm?start=7531&" class="buttN" style="padding:1px;">754</a>
							
							<a href="search.cfm?start=7541&" class="buttN" style="padding:1px;">755</a>
							
							<a href="search.cfm?start=7551&" class="buttN" style="padding:1px;">756</a>
							
							<a href="search.cfm?start=7561&" class="buttN" style="padding:1px;">757</a>
							
							<a href="search.cfm?start=7571&" class="buttN" style="padding:1px;">758</a>
							
							<a href="search.cfm?start=7581&" class="buttN" style="padding:1px;">759</a>
							
							<a href="search.cfm?start=7591&" class="buttN" style="padding:1px;">760</a>
							
							<a href="search.cfm?start=7601&" class="buttN" style="padding:1px;">761</a>
							
							<a href="search.cfm?start=7611&" class="buttN" style="padding:1px;">762</a>
							
							<a href="search.cfm?start=7621&" class="buttN" style="padding:1px;">763</a>
							
							<a href="search.cfm?start=7631&" class="buttN" style="padding:1px;">764</a>
							
							<a href="search.cfm?start=7641&" class="buttN" style="padding:1px;">765</a>
							
							<a href="search.cfm?start=7651&" class="buttN" style="padding:1px;">766</a>
							
							<a href="search.cfm?start=7661&" class="buttN" style="padding:1px;">767</a>
							
							<a href="search.cfm?start=7671&" class="buttN" style="padding:1px;">768</a>
							
							<a href="search.cfm?start=7681&" class="buttN" style="padding:1px;">769</a>
							
							<a href="search.cfm?start=7691&" class="buttN" style="padding:1px;">770</a>
							
							<a href="search.cfm?start=7701&" class="buttN" style="padding:1px;">771</a>
							
							<a href="search.cfm?start=7711&" class="buttN" style="padding:1px;">772</a>
							
							<a href="search.cfm?start=7721&" class="buttN" style="padding:1px;">773</a>
							
							<a href="search.cfm?start=7731&" class="buttN" style="padding:1px;">774</a>
							
							<a href="search.cfm?start=7741&" class="buttN" style="padding:1px;">775</a>
							
							<a href="search.cfm?start=7751&" class="buttN" style="padding:1px;">776</a>
							
							<a href="search.cfm?start=7761&" class="buttN" style="padding:1px;">777</a>
							
							<a href="search.cfm?start=7771&" class="buttN" style="padding:1px;">778</a>
							
							<a href="search.cfm?start=7781&" class="buttN" style="padding:1px;">779</a>
							
							<a href="search.cfm?start=7791&" class="buttN" style="padding:1px;">780</a>
							
							<a href="search.cfm?start=7801&" class="buttN" style="padding:1px;">781</a>
							
							<a href="search.cfm?start=7811&" class="buttN" style="padding:1px;">782</a>
							
							<a href="search.cfm?start=7821&" class="buttN" style="padding:1px;">783</a>
							
							<a href="search.cfm?start=7831&" class="buttN" style="padding:1px;">784</a>
							
							<a href="search.cfm?start=7841&" class="buttN" style="padding:1px;">785</a>
							
							<a href="search.cfm?start=7851&" class="buttN" style="padding:1px;">786</a>
							
							<a href="search.cfm?start=7861&" class="buttN" style="padding:1px;">787</a>
							
							<a href="search.cfm?start=7871&" class="buttN" style="padding:1px;">788</a>
							
							<a href="search.cfm?start=7881&" class="buttN" style="padding:1px;">789</a>
							
							<a href="search.cfm?start=7891&" class="buttN" style="padding:1px;">790</a>
							
							<a href="search.cfm?start=7901&" class="buttN" style="padding:1px;">791</a>
							
							<a href="search.cfm?start=7911&" class="buttN" style="padding:1px;">792</a>
							
							<a href="search.cfm?start=7921&" class="buttN" style="padding:1px;">793</a>
							
							<a href="search.cfm?start=7931&" class="buttN" style="padding:1px;">794</a>
							
							<a href="search.cfm?start=7941&" class="buttN" style="padding:1px;">795</a>
							
							<a href="search.cfm?start=7951&" class="buttN" style="padding:1px;">796</a>
							
							<a href="search.cfm?start=7961&" class="buttN" style="padding:1px;">797</a>
							
							<a href="search.cfm?start=7971&" class="buttN" style="padding:1px;">798</a>
							
							<a href="search.cfm?start=7981&" class="buttN" style="padding:1px;">799</a>
							
							<a href="search.cfm?start=7991&" class="buttN" style="padding:1px;">800</a>
							
							<a href="search.cfm?start=8001&" class="buttN" style="padding:1px;">801</a>
							
							<a href="search.cfm?start=8011&" class="buttN" style="padding:1px;">802</a>
							
							<a href="search.cfm?start=8021&" class="buttN" style="padding:1px;">803</a>
							
							<a href="search.cfm?start=8031&" class="buttN" style="padding:1px;">804</a>
							
							<a href="search.cfm?start=8041&" class="buttN" style="padding:1px;">805</a>
							
							<a href="search.cfm?start=8051&" class="buttN" style="padding:1px;">806</a>
							
							<a href="search.cfm?start=8061&" class="buttN" style="padding:1px;">807</a>
							
							<a href="search.cfm?start=8071&" class="buttN" style="padding:1px;">808</a>
							
							<a href="search.cfm?start=8081&" class="buttN" style="padding:1px;">809</a>
							
							<a href="search.cfm?start=8091&" class="buttN" style="padding:1px;">810</a>
							
							<a href="search.cfm?start=8101&" class="buttN" style="padding:1px;">811</a>
							
							<a href="search.cfm?start=8111&" class="buttN" style="padding:1px;">812</a>
							
							<a href="search.cfm?start=8121&" class="buttN" style="padding:1px;">813</a>
							
							<a href="search.cfm?start=8131&" class="buttN" style="padding:1px;">814</a>
							
					</td valign="top">
					<td style="font-size:1px;">&nbsp;</td>
					<td valign="top">
						
		<form action="login.cfm" method="post">
			<table width="180" cellpadding="0" cellspacing="0" border="0" style="border:1px solid #003399;">
				<tr title="Advanced Search Report" class="subnavhead">
					<td height="18">
						Member Login
						
					</td>
				</tr>
				<tr>
					<td class="body" align="center" class="leftnav">
						<div align="left" style="padding:3px;">
							Email Address:
							<br />
							<input type="text" name="email" value="" size="15" class="inputtext" style="width:95%" title="Email">
							<br />
							Password:<br>
							<input type="password" name="password" value="" size="9" class="inputtext" style="width:95%" title="Password">
							<br />
							<input type="submit" name="Login" value="Login" class="inputbutton" title="Login">
						</div>
						<div style="width:100%;background-color:#003366;color:#FFFFFF;">
							<a href="signup.cfm" class="smallnav" title="New Account">New Account</a>
							:: 
							<a href="lost.cfm" class="smallnav" title="Lost Password?">Lost Password?</a>
						</div>
					</td>
				</tr>
			</table>
		</form>
		
							<br />
							
	<table width="180" cellpadding="0" cellspacing="0" border="0" style="border:1px solid #003399;">
		<tr title="Inspections" class="subnavhead">
			<td height="18">&nbsp;Inspections</td>
		</tr>
		<tr>
			<td class="body" align="left" class="leftnav" style="padding:3px;" valign="top">
				<div style="padding-left:5px;width:150px;border-bottom:1px dotted #003399;">
					<a href="index.cfm">Home</a>
				</div>
				<div style="padding-left:5px;width:150px;border-bottom:1px dotted #003399;">
					<a href="search.cfm?searchShow=name">Quick Search by Name</a>
				</div>
				<div style="padding-left:5px;width:150px;border-bottom:1px dotted #003399;">
					<a href="search.cfm?searchShow=zip">Quick Search by Zipcode</a>
				</div>
				<div style="padding-left:5px;width:150px;border-bottom:1px dotted #003399;">
					<a href="search.cfm?searchShow=letter">Browse by First Letter</a>
				</div>
			</td>
		</tr>
	</table>

							<br />
							
	<table width="180" cellpadding="0" cellspacing="0" border="0" style="border:1px solid #003399;">
		<tr title="Site Services" class="subnavhead">
			<td height="18">&nbsp;Site Services</td>
		</tr>
		<tr>
			<td class="body" align="left" class="leftnav" style="padding:3px;" valign="top">
				<div style="padding-left:5px;width:150px;border-bottom:1px dotted #003399;">
					<a href="signup.cfm">Become a Member</a>
				</div>
				
					<div style="padding-left:5px;width:150px;border-bottom:1px dotted #003399;">
						<a href="login.cfm">Login</a>
					</div>
				
				
			</td>
		</tr>
	</table>

					</td>
				</tr>
			</table>
		</div>
	
</body>
</html> 