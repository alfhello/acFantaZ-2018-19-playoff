// Initialize app
var myApp = new Framework7({
	cache: false, 
	cacheDuration: 0,
	template7Pages: true,
	smartSelectOpenIn: 'page',
	smartSelectSearchbar: true,
	smartSelectBackOnSelect: true,
	sortable: {moveElements: true},
});

// If we need to use custom DOM library, let's save it to $$ variable:
var $$ = Dom7;
var JSLink = 'http://privacy.ascdevelop.com:8500/CFIDE/ASCWS/CFC/';
var JSLink = 'http://ascdevelop.win/ASC_WS/CFC/';
var JSLink = 'http://privacy.ascdevelop.win:5918/CFIDE/ASCWS/CFC/';
//var defHomeData = {APP:'DictA', VALUE:0, CHKPASS:0, APPVER:'', FReady:0};
var defPageProp = {url:'', ignoreCache:true, animatePages:false, reload:false, context:{}};
var AppINI = {'AppName':'FantAz', 'AppVer':0};
var logOb;
var INIOb;
//var chkCount = 0;

var P010 = {};
P010.url = 'newhome.html';
//P010.url = 'pages/pageMain.html';
P010.defData = {APP:AppINI.AppName, VALUE:0, CHKPASS:0, APPVER:AppINI.AppVer};

// Add view  
var mainView = myApp.addView('.view-main', {
    dynamicNavbar: true,
});

// Handle Cordova Device Ready Event
$$(document).on('deviceready', function() {
	displayConsole('my-App','deviceReady.PASS');
// get device parameter
	checkSupp();
	upGPS();
	if (device.platform != "browser") {
//		alert('read before');
		beforeStartApp(function(INIStatus) {
// check if INI file is new created or it AppName can't matched. It return false
			if (!INIStatus)	{
//				alert(INIStatus);
				setTimeout(function() {
//					alert('go to user set up');
					doAppStartUp();
				}, 1200)
				return false;
			} else { 
//				alert('INIStatus is : ' + INIStatus);
				setTimeout( function() {
					doAppStartUp();
				}, 1200)	
			}
		});
	} else {
		console.log('browser - skip INI checking');	
		setLStorage('AppINI',JSON.stringify(AppINI));
		setTimeout(function() {
			doAppStartUp();
		}, 1200)
	}
});

myApp.onPageInit('index', function(page) {
	displayConsole('index','pageInit');
	indexPageBtnReset();
});

myApp.onPageInit('newHome', function(page) {
	displayConsole('newHome','pageInit');
	indexPageBtnReset();
	doShowHeaderFooter(false);
	
	$$("#freadyVar").html('Fready' + JSON.stringify(AppINI));
	
	$$("#listFS").on('click', function() {
		showDir(cordova.file.dataDirectory);
	})
	$$("#delLog").on('click', function() {
		delAppFile(cordova.file.dataDirectory, 'log.txt');
	})	
	$$("#delLS").on('click', function() {
//		localStorage.clear();
		delLStorage('ALL')
		alert('All localStorage Clear.');
	})		
	$$("#delINI").on('click', function() {
		delAppFile(cordova.file.dataDirectory, 'APP.js');
	})	
	$$("#appendINI").on('click', function() {
//		AppINI.newLn = 'newLn added';
		writeINI(AppINI);
		setLStorage('userTeam','treeroot');
		alert('LStorage userId added');
	})	
	$$("#viewINI").on('click', function() {
		showINIFile();
	})		
	$$("#viewLog").on('click', function() {
		showLogFile();
	})		
	$$("#viewVar").on('click', function() {
		showAppINIVar();
	})	
	$$("#viewINIStr").on('click', function() {
		showINIStr();
	})
	$$("#btnStartApp").on('click', function() {
		doGoHome();
	});
	$$("#btnUserReg").on('click', function() {
		doGoUserReg();
	});
});

myApp.onPageInit('pageRoster', function(page) {
	displayConsole('pageRoster', 'Loaded');
	indexPageBtnReset();

	$$(".TopTeamName").html(" "+getLStorage('userTeam')+" ("+getLStorage('userGroup')+")");
	$$(".TopTeamName").addClass("Active");	
	
	$$(".APOS").on('click', function() {
		displayConsole('POS Change clicked', this.id.split('_')[1], event, this);

		$$("li.swipeout[id='TR_" + this.id.split('_')[0] + "'] div div.TPOS").addClass('ChangeFm');

// show DIV UTRoster 
//		$$(".UTRoster").removeClass("inActive");
		$$(".hiddenBtn").addClass("Active");

// init first. All reset to AvailTo
		$$.each($$("li.swipeout[id='TR_" + this.id.split('_')[0] + "'] div div").removeClass('ChangeTo'))
		$$.each($$("li.swipeout[id='TR_" + this.id.split('_')[0] + "'] div div.CPOS").addClass('AvailTo'))		

// update selected object class
		$$("li.swipeout[id='TR_" + this.id.split('_')[0] + "'] div div[id='" + this.id.split('_')[1] +"']").removeClass('AvailTo')
		$$("li.swipeout[id='TR_" + this.id.split('_')[0] + "'] div div[id='" + this.id.split('_')[1] +"']").addClass('ChangeTo')
		$$("li.swipeout[id='TR_" + this.id.split('_')[0] + "'] div div[id='" + this.id.split('_')[1] +"'] p").addClass('POSFlag ChangeTo')

// all swipeout close		
		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(this, function() {
				displayConsole('swipeoutClose' + this);
			});
		});
	})
	
	$$(".resetTRoster").on('click', function() {
// hide DIV UTRoster 
//		$$(".UTRoster").addClass("inActive");
		$$(".hiddenBtn").removeClass("Active");
// reset All CPOS class to availTo
		$$.each($$(".CPOS").removeClass('ChangeTo'));		
		$$.each($$(".CPOS").addClass('AvailTo'));				
// remove TPOS class ChangeFm
		$$.each($$("div.TPOS").removeClass('ChangeFm'));		
	})
	
	$$(".saveTRoster").on('click', function() {
//		$$(".UTRoster").addClass("inActive");		
		$$(".hiddenBtn").removeClass("Active");
		$$(".TPOS.ChangeFm").each(function(idx,elm) {
			alert($$(elm).parent().parent().attr('id'));
		})
	})
	
	$$(".buyRosterG").on('click', function() {
		doPlayerLst('G',0);
	});
	$$(".buyRosterF").on('click', function() {
		doPlayerLst('F',0);
	});
	$$(".buyRosterC").on('click', function() {
		doPlayerLst('C',0);
	});
	$$(".buyRosterB").on('click', function() {
		doPlayerLst('B',0);
	});
	
	$$(".tradeRosterG").on('click', function() {
		doPlayerLst('G',0);
	});
	$$(".tradeRosterF").on('click', function() {
		doPlayerLst('F',0);
	});
	$$(".tradeRosterC").on('click', function() {
		doPlayerLst('C',0);
	});
	$$(".tradeRosterB").on('click', function() {
		doPlayerLst('B',0);
	});
		
	$$(".plyHist").on('click', function() {
		doStatHdr('Player', this.id);
	});	
});

myApp.onPageInit('newReg', function(page) {
	displayConsole('newReg', 'Loaded');
	indexPageBtnReset();
});

function doGoHome() {
	displayConsole('doGoHome goPage:pageRoster','BeforeLoad-');	
	var dINI = JSON.parse(getLStorage('AppINI'));	
//	mainView.router.loadPage({url:'pages/pageRoster.html', ignoreCache:true, reload:true, context:{}
		var JSFile = 'ascFanta_p.cfm'
		var JSMethod = '?method=doGetUTRoster_DTS_NBA_2018_s3'
		var JSParam = '&inUTKey=' + getLStorage('teamKey') + '&inGpKey=' + getLStorage('groupKey') + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			setLStorage('lastKey', json.LASTKEY);
//			console.log(json.KEYSET);
			setLStorage('keySet',JSON.stringify(json.KEYSET));
			mainView.router.loadPage({url:'pages/pageRoster.html', ignoreCache:true, reload:true, context: json });
		});
}

myApp.onPageInit('pageACPRank', function(page) {
	displayConsole('pageACPRank','Loaded');
	indexPageBtnReset();
	
	$$("#doTACPRank").on('click', function(){
		displayConsole('doTACPRank Clicked');
		mainView.router.loadPage({url:'pages/pageACPRank.html', ignoreCache:true, reload:true, context: {} });
		setTimeout(function(){
			doACPRank('TACP','desc');
		}, 1000);		
	});
	
	$$("#doAACPRank").on('click', function(){
		displayConsole('doAACPRank Clicked');
		mainView.router.loadPage({url:'pages/pageACPRank.html', ignoreCache:true, reload:true, context: {} });
		setTimeout(function(){
			doACPRank('AACP','desc');
		}, 100);				
	});	
	
	$$("#doDACPRank").on('click', function(){
		displayConsole('doDACPRank Clicked');
		mainView.router.loadPage({url:'pages/pageACPRank.html', ignoreCache:true, reload:true, context: {} });
		setTimeout(function(){
			doACPRank('DACP','desc');
		}, 100);				
	});		
	$$(".PutWLActive").on('click', function(){
		doPutWL(this);
	})
});

function doACPRank_php(oBy, oMd) {
	displayConsole('doGoACPRank gopage:pageACPRank_PHP','BeforeLoad');
	var dINI = JSON.parse(getLStorage('AppINI'));
	var JSLink = "http://ascdevelop.com/";
	var JSFile = "phpselect.php";
	var JSMethod = '';
//	console.log(AINI.seasonYear);
	var JSParam = '?ginfo={"ordBy":"' + oBy + '","ordMethod":"' + oMd + '"}';
//	var JSParam = '&&ordby=' + oBy + '&ordmethod=' + oMd + '&inName' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pageACPRank.html', ignoreCache:true, reload:true, context: json});	
	});
}

function doACPRank(oBy, oMd) {
	displayConsole('doGoACPRank gopage:pageACPRank','BeforeLoad');
	var dINI = JSON.parse(getLStorage('AppINI'));
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doACPRanking_NBA';
//	console.log(AINI.seasonYear);
	var JSParam = '&fxParam={"ordBy":"' + oBy + '","ordMethod":"' + oMd + '","seasonYr":' + dINI.seasonYear + ',"Stage":' + dINI.seasonStage + '}&logParam={"inName":"' + getLStorage('userId') + '","inTName":"' + getLStorage('userTeam') + '","inApp":"' + dINI.AppName + '","inAct":"ACPRanking"}' + getLStorage('inParam');
//	var JSParam = '&&ordby=' + oBy + '&ordmethod=' + oMd + '&inName' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pageACPRank.html', ignoreCache:true, reload:true, context: json});	
	});
}

function doACPRank_O(oBy, oMd) {
	displayConsole('doGoACPRank gopage:pageACPRank','BeforeLoad');
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doACPRanking';
	var JSParam = '&ordby=' + oBy + '&ordmethod=' + oMd + '&inName' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pageACPRank.html', ignoreCache:true, reload:true, context: json});	
	});
}

function doPlayerLst(oPos, oCst) {
	displayConsole('doPlayerList gopage:pagePlayerList-' + oPos,'BeforeLoad');
	setLStorage('WLDsp', 'N');
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doGetPlayerLst_2018_s3';
	var JSParam = '&gPos=' + oPos + '&cstUp=' + oCst + '&pName=&ordby=TACP&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
	});
}

function doPlayerBy(iType) {
	displayConsole('doPlayerBy gopage:pagePlayerList-' + iType, 'BeforeLoad');
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doGetPlayerBy_2018_s3';
	var JSParam = '&inType=' +  iType + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
	});
}

function doPlayerNLst(iType, TVal) {
	displayConsole('doPlayerList gopage:pagePlayerList-' + iType + ':' + TVal, 'BeforeLoad');	
	setLStorage('WLDsp', 'N');
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doGetPlayerLst_2018_s3';
	var JSParam = '&gPos=' + iType + '&cstUp=' + TVal + '&pName=&ordby=TACP&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
	});
}

myApp.onPageInit('pagePlayer', function(page) {
	displayConsole('pagePlayer', 'Loaded');	

	$$(".tmRosterWLCan").addClass('Active');
	$$(".TradeRejected").removeClass('Active');
	
	if (getLStorage('WLDsp') === 'Y') {
		$$(".tmRosterWL").removeClass('Active');		
		$$("#tr_PlayerList").removeClass('Active');
		$$("#tr_UTRosterList").addClass('Active');		
	} else {
		$$(".tmRosterWL").addClass('Active');		
	}
	
	$$(".pByTeam").on('click', function() {
		doPlayerNLst('T',this.id.slice(2));
	});
	$$(".pByPos").on('click', function() {
		doPlayerLst(this.id.slice(2),0)
	});	
	$$(".pByCost").on('click', function() {
		doPlayerLst('S', this.id.slice(2))
	});	
	
	$$("#openPlayerByTeam").on('click', function() {
		doPlayerBy('T');
	});
	$$("#openPlayerByPos").on('click', function() {
		doPlayerBy('P');
	})
	$$("#openPlayerByCost").on('click', function() {
		doPlayerBy('S');
	})
	
	$$("#openPlayerG").on('click', function() {
		doPlayerLst('G',0);
	});
	$$("#openPlayerF").on('click', function() {
		doPlayerLst('F',0);
	});
	$$("#openPlayerC").on('click', function() {
		doPlayerLst('C',0);
	});
	$$("#openPlayerB").on('click', function() {
		doPlayerLst('B',0);
	});
	$$("#openTrWL").on('click', function() {
		setLStorage('WLDsp', 'Y');
		
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doGetWLInfo_2018_s3';
		var JSParam = '&WLIDs=' + JSON.parse(getLStorage('wl')) + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			setLStorage('lastKey', json.LASTKEY);
			mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
		});
	});

	$$("#moveToUTRWL").on('click', function() {
		displayConsole('move to UTR WL click');
		$$("#tr_PlayerList").removeClass('Active');
		$$("#tr_UTRosterList").addClass('Active');
	});

/*
	$$(".tmRosterWL").on('click', function() {
		displayConsole('tmRoster WL click');
//		$$("#tr_PlayerList").removeClass('Active');
//		$$("#tr_UTRosterList").addClass('Active');
		setLStorage('WLDsp', 'Y');
		
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doGetWLInfo_2018_s3';
		var JSParam = '&WLIDs=' + JSON.parse(getLStorage('wl')) + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			setLStorage('lastKey', json.LASTKEY);
			mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
		});
	});
*/
	
	$$(".SellActive").on('click', function() {
		displayConsole('SellActive Click: ' + this.id);
		$$("#sAct_" + this.id.slice(-2)).addClass('Active');
		$$("#sCan_" + this.id.slice(-2)).addClass('Active');
		$$(".CmdBar_woReplace").addClass('Active');
		
		$$(".tmRosterWL").addClass('Active');
		$$(".tmRosterWLCan").addClass('Active');	
		$$(".TradeRejected").removeClass('Active');	
		
		$$(".TrCfmBtn").addClass('Active');
		$$("#" + this.id.slice(-2)).parent().parent().addClass('toSell');
		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(this, function() {
				displayConsole('swipeoutClose');
			});
		});	
		CostJustUp();		
	});
	$$(".SellCancel").on('click', function() {
		displayConsole('SellActive Click: ' + this.id);		
		$$("#sAct_" + this.id.slice(-2)).removeClass('Active');
		$$("#sCan_" + this.id.slice(-2)).removeClass('Active');
		
		$$(".TradeRejected").removeClass('Active');		
		
		$$("#" + this.id.slice(-2)).parent().parent().removeClass('toSell');
		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(this, function() {
				displayConsole('swipeoutClose');
			});
		});	
		ChkTrStatus('toSell');
		CostJustUp()
	});
	$$(".PutWLActive").on('click', function() {
		doPutWL(this);
		/*
		displayConsole('PutWLActive Click: ' + this.id);
		var nWL = $$("#" + this.id).parent().parent().attr('name')
		
		doCheckLS('wl');
		if (doPushArray('wl',nWL)) {
			displayConsole(nWL + ' added to wish list');	
		} else {
			displayConsole(nWL + ' denied. wish list fulled');
		}

		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(this, function() {
				displayConsole('swipeoutClose');
			});
		});	
		*/	
	});	
	
	$$(".BuyActive").on('click', function() {
		displayConsole('BuyActive Click: ' + this.id);
		$$("#" + this.id).addClass('Active');
		$$("#sCan_" + this.id.slice(5)).addClass('Active');
		
		$$(".TradeRejected").removeClass('Active');
		
		$$("#" + this.id).parent().parent().children(".RdyTr").addClass('toBuy');
		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(this, function() {
				displayConsole('swipeoutClose');
			});
		});		
		CostJustUp()
	});
	$$(".BuyCancel").on('click', function() {
		displayConsole('BuyCancel Click: ' + this.id);		
		$$("#" + this.id).removeClass('Active');
		$$("#sBuy_" + this.id.slice(5)).removeClass('Active');
		
		$$(".TradeRejected").removeClass('Active');
		
		$$("#" + this.id).parent().parent().children(0).removeClass('toBuy');
		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(this, function() {
				displayConsole('swipeoutClose');
			});
		});		
		CostJustUp()
	});
		
	$$("#sellPlayerNoReplace").on('click', function() {
		displayConsole('woReplace click');
		var sellposList =[];
		var sellposChk = [];
		var sellIDList = [];
		var sellpCost = 0;
		
		var trDate = $$("#txDate").attr('name');
		var aToken = $$("#availableToken").attr('name').slice(4);
		var aCostR = $$("#UTCostRemain").attr('name').slice(5);
		sellpCost = Number(aCostR);
		
		$$(".toSell").each(function(idx,elm) {
			sellposList.push($$(elm).parent().attr('name').toLowerCase().slice(0,2));
			sellposChk.push($$(elm).parent().attr('name').toLowerCase().slice(0,1));
			sellIDList.push($$(elm).parent().attr('id').slice(3));
		})
		if (aToken < sellposList.length) {
			alert('Not enough Trade Token');			
		} else {
			console.log('Pass. Sell without replace');
			console.log('sell pos:' + sellposList + ' sell id:' + sellIDList);				
			console.log('sell action: sell without replacement');	
			var xpCr = $$("#UTCostRemain").html();
			console.log('xp CR:' + xpCr + ' Tk used:' + sellposList.length);				
		}
		console.log(sellposList.length);
		console.log(aToken + ":" + aCostR);
	})
	
	$$("#clearWatchList").on('click', function() {
		setLStorage('wl','[]');
		reopenWL();
		$$(".TradeRejected").removeClass('Active');		
	});
	
	$$(".tmRosterWLCan").on('click', function() {
		setLStorage('wl','[]');
		reopenTmRosterWL();
		$$(".TradeRejected").removeClass('Active');		
	});

	$$(".tmRosterWL").on('click', function() {	
//	$$("#sellPlayerWReplace").on('click', function() {
		displayConsole('with Replace click');
		var buyIDList = [];
		var buyposList = [];
		var sellIDList = [];
		var sellposList = [];
		var sellposChk = [];
		var sellpCost = 0;
		var buypCost = 0;
		var TknRtn = 0;
		
		var trDate = $$("#txDate").attr('name').slice(3);
		var aToken = $$("#availableToken").attr('name').slice(4);
		var aCostR = $$("#UTCostRemain").attr('name').slice(5);
		var sellpCost = Number(aCostR);
		console.log(sellpCost);
		
		$$(".TradeRejected").removeClass('Active');
		
		$$(".toSell").each(function(idx,elm) {
			sellposList.push($$(elm).parent().attr('name').toLowerCase().slice(0,2));
			sellposChk.push($$(elm).parent().attr('name').toLowerCase().slice(0,1));
			sellIDList.push($$(elm).parent().attr('id').slice(3));
			if  ($$(elm).parent().attr('id').slice(3).length < 3 ) {
				TknRtn += 1
			}
			sellpCost = sellpCost + Number($$(elm).attr('name').slice(3));
		})
		$$(".toBuy").each(function(idx,elm) {
			buyIDList.push($$(elm).parent().attr('id').slice(3));
			buyposList.push($$(elm).parent().attr('name').slice(4));	
			buypCost = buypCost + Number($$(elm).attr('name').slice(3));
		})		

		console.log(sellposList.length-TknRtn);
//		xRos = JSON.parse(getLStorage('keySet'))[0];
//		console.log(xRos);
		
		if (aToken < (sellposList.length-TknRtn)) {
//			alert('Not enough Trade Token');
			$$(".TradeRejected").addClass("Active");
			$$(".TradeRejected").html("Not Enough Trade Token. Trade Rejected");			
		} else {
			if (sellpCost < buypCost) {
//				 alert('Not enough Cost');	
				$$(".TradeRejected").addClass("Active");
				$$(".TradeRejected").html("Not Enough Cost. Trade Rejected");				 
			} else {
				if (sellIDList.length === buyIDList.length) {
					if (checkPOSMatch(sellposChk, buyposList)) {
						console.log('Pass. Sell equal Buy item');
						console.log('sell pos:' + sellposList + ' sell id:' + sellIDList + ' sell Cost:' + sellpCost);				
						console.log('buy pos:' + buyposList + ' buy id:' + buyIDList + ' buy Cost:' + buypCost);
						var xpCr = $$("#UTCostRemain").html();
						console.log('xp CR:' + xpCr + ' Tk used:' + sellposList.length + ' trade date:' + trDate);		
						doSubmitTradeStatment(sellIDList, sellposList, buyIDList, buyposList, trDate, sellposList.length, sellpCost, buypCost)								
					} else {
						console.log('Fail, Pos not fit');
//						alert('Position not fit. Trade rejected 1');
						$$(".TradeRejected").addClass("Active");
						$$(".TradeRejected").html("Position not Fit. Trade Rejected");
						return false;
					}
				} else {
					console.log('Fail. Sell and Buy not match');	
					$$(".TradeRejected").addClass("Active");
					$$(".TradeRejected").html("Position not Fit. Trade Rejected");
//					alert('Position not fit. Trade rejected 2');
					return false;
				}
			}
		}
	})

	$$(".RemoveWL").on('click', function(event) {
		displayConsole('RemoveWL Clicked', 'Fx RemoveWL' + this.id);
		pWL = JSON.parse(getLStorage('wl'));
		tID = this.id.replace("rm_","p_")
		pWL.splice(pWL.indexOf(tID,1))
// 		console.log(pWL);
		setLStorage('wl',JSON.stringify(pWL));
		reopenTmRosterWL();
	});

});

function openTradeCenter() {
	setLStorage('WLDsp', 'Y');
	
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doGetWLInfo_2018_s3';
	var JSParam = '&WLIDs=' + JSON.parse(getLStorage('wl')) + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
	});
}

function doPutWL(obj) {
		displayConsole('PutWLActive Click: ' + obj.id);
//		var nWL = $$("#" + obj.id).parent().parent().attr('name')
		var nWL = "p_" + obj.id.slice(2);
		
		doCheckLS('wl');
		if (doPushArray('wl',nWL)) {
			displayConsole(nWL + ' added to wish list');	
		} else {
			displayConsole(nWL + ' denied. Player already existed or List Fulled');
		}

		$$("li.swipeout").each(function() {
			myApp.swipeoutClose(obj, function() {
				displayConsole('swipeoutClose');
			});
		});		
}

function reopenTmRosterWL() {
	displayConsole('open WL click');
	setLStorage('WLDsp', 'Y');
	
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doGetWLInfo_2018_s3';
	var JSParam = '&WLIDs=' + JSON.parse(getLStorage('wl')) + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pagePlayer.html', ignoreCache:true, reload:true, context: json});	
	});
}
function CostJustUp() {
	var aCostR = $$("#UTCostRemain").attr('name').slice(5);
	var sellpCost = Number(aCostR);
	var aToken = $$("#availableToken").attr('name').slice(4);
	var i = 0;
	$$(".toSell").each(function(idx,elm) {
		sellpCost = sellpCost + Number($$(elm).attr('name').slice(3));
		i = i - 1;
	})
	$$(".toBuy").each(function(idx,elm) {
		sellpCost = sellpCost - Number($$(elm).attr('name').slice(3));
	})		
	$$("#UTCostRemain").html(sellpCost.toFixed(1));
	$$("#availableToken").html(aToken + ' (' + i + ')');
}

function checkPOSMatch(SellArray, BuyArray) {
		var ctSG = 0;
		var ctSF = 0;
		var ctSC = 0;
		var ctBG = 0;
		var ctBF = 0;
		var ctBC = 0;
		var posB = 'A';
		
		$$.each(SellArray, function(index,value) {
			if (value.toLowerCase().indexOf('g') >= 0) {
				ctSG += 1;	
			}
			if (value.toLowerCase().indexOf('f') >= 0) {
				ctSF += 1;	
			}
			if (value.toLowerCase().indexOf('c') >= 0) {
				ctSC += 1;	
			}
		})
		$$.each(BuyArray, function(index,value) {
			if (value.toLowerCase().indexOf('g') >= 0) {
				ctBG += 1;	
			}
			if (value.toLowerCase().indexOf('f') >= 0) {
				ctBF += 1;	
			}
			if (value.toLowerCase().indexOf('c') >= 0) {
				ctBC += 1;	
			}
		})
		if ((ctBG >= ctSG) && (ctBF >= ctSF) && (ctBC >= ctSC)) {
			$$.each(BuyArray, function(index, value) {
				if (value.toLowerCase().length === 1) {
					if (SellArray.indexOf(value.toLowerCase()) < 0 ) {
						if (SellArray.indexOf('b') < 0) {
							console.log('No pos fit: ' + value.toLowerCase());	
							posB = 'B'
							return false;
						}
					}
				}
			});
			if (posB === 'B') {
				return false;
			} else {
				console.log("good transaction");
				return true;
			}
		} else {
			console.log("NG. position unmatch");	
			return false;
		}
//		console.log(ctSG + ":" + ctSF + ":" + ctSC);
//		console.log(ctBG + ":" + ctBF + ":" + ctBC);	
};

function ChkTrStatus(clsName) {
	if($$("." + clsName).length == 0) {
		$$(".CmdBar_woReplace").removeClass('Active');
	};
}

function doCheckLS(LSName) {
	if (localStorage.getItem(LSName) === null) {
		setLStorage(LSName,'[]');
	}
};

function doPushArray(LSName, Val) {

	$$("li.swipeout").each(function() {
		myApp.swipeoutClose(this, function() {
			displayConsole('swipeoutClose');
		});
	});	

	var a = JSON.parse(getLStorage(LSName));
	if (a.length <= 10) {
		if (a.indexOf(Val) < 0) {
			a.push(Val);
			setLStorage(LSName, JSON.stringify(a));
//			screenPop('Player added');
		} else {
//			screenPop('Player already in List');
			return false;
		}
	} else 	{
//		screenPop('Wish List fulled');
		return false;
	}
	return true;
};

function doSubmitTradeStatment(sID, sPos, bID, bPos, gmDate, TknUsed, sCost, bCost) {
	displayConsole('pagePlayer', 'sellPlayerWReplace sub Fx:doSubmitTradeStatment');
	var dINI = JSON.parse(getLStorage('AppINI'));
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doRosterSellWReplacement_2018_s3';
	var JSParam = '&SellIDList=' + sID + '&SellPosList=' + sPos + '&pBuyIDList=' + bID + '&pBuyPosList=' + bPos + '&TradeGmDate=' + gmDate + '&TokenUsed=' + TknUsed + '&TrSellCost=' + sCost + '&TrBuyCost=' + bCost;
	JSParam = JSParam + '&inTeamKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inGmDate=' + dINI.gmToday + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);	
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		console.log(json.TRVAL);
		console.log(json.DETAIL);
		if (json.TRVAL === 1) {
			removeWLLS(json.BUYID);
			reopenTmRosterWL();
		}
		if (json.TRVAL === 0) {
			alert(json.MSG);
			reopenTmRosterWL();
		}
	});
}

function removeWLLS(buyList) {
/*
		buyList.forEach(itm) {
			
		}
		pWL = JSON.parse(getLStorage('wl'));
		buyList.each(itm) {
			itm.replace("p_")
		}
		tID = this.id.replace("rm_","p_")
		pWL.splice(pWL.indexOf(tID,1))
		setLStorage('wl',JSON.stringify(pWL));
*/	
}

function doLeagueRank(utRank) {
	displayConsole('doLeagueRank goPage:pageLeagueRank','BeforeLoad');
	displayConsole(getLStorage('groupKey') + ':' + getLStorage('teamKey'));
	var dINI = JSON.parse(getLStorage('AppINI'));
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doLeagueRank_2018_s3';
	var JSParam = '&inTeamKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') + '&inGmDate=' + dINI.gmToday + '&intype=' + utRank + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');
	console.log(JSLink + JSFile + JSMethod + JSParam);	
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
		setLStorage('lastKey', json.LASTKEY);
		mainView.router.load({url:'pages/pageULeague.html', ignoreCache:true, reload:true, context: json});
	});
}

myApp.onPageInit('pageULeague', function(page) {
	displayConsole('pageULeague','Loaded');
	indexPageBtnReset();
	
	$$("#doUTPrvLRank").on('click', function(){
		displayConsole('doUTPrvLRank Clicked **-');
		mainView.router.loadPage({url:'pages/pageULeague.html', ignoreCache:true, reload:true, context: null });
		setTimeout(function(){
			doLeagueRank('prvL');
		}, 1000);		
	});

	$$("#doUTPrvLRanklgd").on('click', function(){
		displayConsole('doUTPrvLRank Clicked **-');
		mainView.router.loadPage({url:'pages/pageULeague.html', ignoreCache:true, reload:true, context: null });
		setTimeout(function(){
			doLeagueRank('prvLlgd');
		}, 1000);		
	});

	$$("#doUTWorldLRank").on('click', function(){
		displayConsole('doUTWorldLRank Clicked **-*');
		mainView.router.loadPage({url:'pages/pageULeague.html', ignoreCache:true, reload:true, context: null });
		setTimeout(function(){
			doLeagueRank('wwL');
		}, 1000);		
	});

	$$("#doUTWorldLRanklgd").on('click', function(){
		displayConsole('doUTWorldLRank Clicked **-*');
		mainView.router.loadPage({url:'pages/pageULeague.html', ignoreCache:true, reload:true, context: null });
		setTimeout(function(){
			doLeagueRank('wwLlgd');
		}, 1000);		
	});

	$$("#doUTWorldLRankld").on('click', function(){
		displayConsole('doUTWorldLRank Clicked **-*');
		mainView.router.loadPage({url:'pages/pageULeague.html', ignoreCache:true, reload:true, context: null });
		setTimeout(function(){
			doLeagueRank('wwL');
		}, 1000);		
	});
	
	$$(".UTTHist").on('click', function() {
		doStatHdr('UTTeam', this.id);
	});	
});

function doGoUserReg() {
	displayConsole('doGoUserReg goPage:pageRoster','BeforeLoad--');
	mainView.router.loadPage({url:'pages/pageSignIN.html', ignoreCache:true, reload:true});
}

myApp.onPageInit('pageSignIN', function(page) {
	displayConsole('pageSignIN', 'Loaded');
	doShowHeaderFooter(false);
	indexPageBtnReset();
	
	$$("#btnUserSignIN").on('click', function() {
		console.log('sign in clicked');
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doUserTeamLogin';
		var JSParam = '&inTName=' + $$("#SignIN_userTeamName").val() + '&inPass=' + $$("#SignIN_userTeamPass").val() + '&inApp=' + P010.defData.APP + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			if (json.CHKPASS == 1) {
				console.log('login success');
				setLStorage('groupKey',json.GROUPKEY);
				setLStorage('teamKey',json.TEAMKEY);
				setLStorage('lastKey',json.LASTKEY);
				setLStorage('userId',json.USERID);
				setLStorage('userTeam',json.USERTEAM);
				setLStorage('userGroup',json.USERGROUP);

				var newAppINI = {'AppName':'FantAz','AppVer':json.APPVER,'seasonYear':json.SEASONYEAR,'seasonStage':json.SEASONSTAGE,'gmToday':json.GMTODAY};
				delLStorage('AppINI');
				setLStorage('AppINI',JSON.stringify(newAppINI));
				
				doGoHome();
			} else {
				console.log('login fail');
//				console.log(json.LOGCOUNT);				
				delLStorage('ALL');
				var wTm = 4;
				if (json.LOGCOUNT > 5) {
					wTm = 5*60;
					var now = new Date();
					var tmStr = now.getTime();
					setLStorage('tempSupp',tmStr);
					console.log(wTm);					
				}
				showLoginFail(wTm);
			}
		});
	});
	$$("#btnUserSignUP").on('click', function() {
		console.log('sign up clicked');
		delLStorage('groupKey');
		delLStorage('teamKey');
		delLStorage('lastKey');
		delLStorage('userId');
		delLStorage('userTeam');
		delLStorage('userGroup');
		delLStorage('keySet');
		doOpenNewReg();
	});				
	
});

function doOpenNewReg() {
	mainView.router.load({url:'pages/pageNewReg.html', ignoreCache:true, reload:true, context: [] });			
}

myApp.onPageInit('pageNewReg', function(page) {
	displayConsole('pageNewReg', 'Loaded');	

	$$("#btnUserRegPage1").on("click", function() {
		$$(".formErr").removeClass("Active");
		$$(".formLabel").removeClass("Err");

		if ($$("#signUP_username").val().length < 3 ) {
			$$("#fieldName").addClass("Err");
			$$("#signUP_nameErr").addClass('Active');
			console.log('user name at least 3 characters');							
			return false;
		}		
		if ($$("#signUP_useremail").val().indexOf('@',0) < 0 ) {
			$$("#fieldEmail").addClass("Err");
			$$("#signUP_emailErr").addClass('Active');
			console.log('invalid email format');							
			return false;
		}

		if ($$("#signUP_useremail").val().indexOf('@',0) > 0 ) {
			var JSFile = 'ascFanta_p.cfm';
			var JSMethod = '?method=doSignUP_checkeMail';
			var JSParam = '&inUserEmail=' + $$("#signUP_useremail").val() + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
//			console.log(JSLink + JSFile + JSMethod + JSParam);
			$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
				setLStorage('emailXst',json.XST)				
				if (json.XST > 0) {
					$$("#fieldEmail").addClass("Err");
					$$("#signUP_emailXst").addClass('Active');								
				}
			})			
		}

		if ($$("#signUP_password").val() != $$("#signUP_repass").val() || $$("#signUP_password").val().length < 5) {
			$$("#fieldPassword").addClass("Err");
			$$("#fieldrePass").addClass("Err");						
			if ($$("#signUP_password").val().length < 5) {
				$$("#signUP_passErr").addClass('Active');
				console.log('password at leaset 5 characters');				
			}
			if ($$("#signUP_password").val() != $$("#signUP_repass").val()) {
				$$("#signUP_repassErr").addClass("Active");
				console.log('password mis-match');				
			}
			$$("#signUP_password").val("");
			$$("#signUP_repass").val("");			
			return false;	
		}
		
		if ($$("#signUP_DOB").val().length < 1 ) {
			$$("#fieldDOB").addClass("Err");
			$$("#signUP_DOBErr").addClass('Active');
			console.log('DOB is a must');							
			return false;
		}	
		
		$$(".pageSignUP1").removeClass('Active');
		$$(".pageSignUP2").addClass('Active');
		console.log($$("#signUP_password").val().length);
	});
	$$("#btnUserRegPage2").on('click', function() {
		$$(".pageSignUP2").removeClass('Active');
		$$(".pageSignUP1").addClass('Active');
	});

	$$("#btnUserSendSignUP").on('click', function() {
		console.log('send Sign Up clicked');
		var signUP_channel = '';
		var signUP_favorite = '';		
		
		if (getLStorage('emailXst') > 0) {
			$$(".pageSignUP2").removeClass('Active');
			$$(".pageSignUP1").addClass('Active');			
			return false;	
		}
		
		$$("input:checked").each(function() {
			if ($$(this).attr('name') === 'userknowus') {
				signUP_channel += ',' + $$(this).val();
			}
		});
		$$("input:checked").each(function() {
			if ($$(this).attr('name') === 'userfavorite') {
				signUP_favorite += ',' + $$(this).val();
			}
		});		
		console.log($$("#signUP_username").val());
		console.log($$("#signUP_useremail").val());		
		console.log($$("#signUP_password").val());
		console.log($$("#signUP_gender").val());
		console.log($$("#signUP_DOB").val());		
		console.log(signUP_channel.slice(1));
		console.log(signUP_favorite.slice(1));
		
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doSignUP_submit';
		var JSParam = '&inUserName=' + $$("#signUP_username").val() + '&inUserPass=' + $$("#signUP_password").val() + '&inUserEmail=' + $$("#signUP_useremail").val() + '&inUserGender=' + $$("#signUP_gender").val() + '&inUserDOB=' + $$("#signUP_DOB").val() + '&inUserChannel=' + signUP_channel.slice(1) + '&inUserFavorite=' + signUP_favorite.slice(1) + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			console.log(json.RESULT);
			if (json.RESULT === 1) {
				$$(".divresult").removeClass("Active");
				$$("#verifySend").addClass("Active");
				$$(".pageSignUP1").removeClass("Active")
				$$("#btnUserRegPage2").removeClass("Active")
				$$("#btnUserSendSignUP").removeClass("Active")
				$$("#btnUserTeamCreate").addClass("Active")
				setLStorage('lastKey', json.LASTKEY);
				setLStorage('userId', json.USERID);
				console.log('Nice');
			} 
			if (json.RESULT === 2) {
				$$(".divresult").removeClass("Active");				
				$$("#mailUsed").addClass("Active");
				console.log('Result is not good');
			}
		})					
	});	
	
	$$("#btnUserTeamCreate").on('click', function() {
		console.log('CreateTeam clicked');
		openTeamMainPage('new');
	});
	
});

function openTeamMainPage(iType) {
	mainView.router.load({url:'pages/pageMain.html', ignoreCache:true, reload:true, context: [] });			
}

myApp.onPageInit('pageTeamMain', function(page) {
	displayConsole('pageTeamMain', 'Loaded');
	
	$$("#btnTeamNamePass").on('click', function() {
		$$("#teamMain_nameErr").removeClass("Active");		
		
		if ($$("#teamMain_TeamName").val().length < 3) {
			$$("#teamMain_nameErr").addClass("Active");
			return false;	
		}
		
		displayConsole('pageTeamMain - TeamName Create', 'Loaded');		
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doTeamMain_addTeamName';
		var JSParam = '&inUserID=' + getLStorage('userId') + '&inUserTeam=' + $$("#teamMain_TeamName").val() + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			console.log(json);		
			setLStorage('lastKey', json.LASTKEY);
			setLStorage('userTeam', json.NEWTEAMNAME);
			if (json.VALUE === 1) {
				$$(".secCreateTeam").removeClass("Active");
				$$(".secTeamReady").addClass("Active");
				$$(".secGroupBtn").addClass("Active");
				$$("#teamMain_vTeamName").html(json.NEWTEAMNAME);
			} else {
				$$("#teamMain_teamNameMsg").addClass("Active");
				$$("#teamMain_teamNameMsg").html(json.MSG);
			}
		})
	});
	
	$$("#teamMain_newGroup").on('click', function() {
		displayConsole('pageMain - Create New Group', 'Loaded');
		$$(".secTeamReady").addClass("Active");		
		$$(".secGroupBtn").removeClass("Active");
		$$(".secCreateGroup").addClass("Active");
		showGroupFx(true, 'chk');
	});
	
	function showGroupFx(iDsp, iAct) {
		if (iDsp) {
			$$(".secGroupFxBtn").addClass("Active");
		} else {
			$$(".secGroupFxBtn").removeClass("Active");
		}
		$$(".groupBtn").each(function() {
			$$(".groupBtn").removeClass("Active");
		});
		if (iAct === 'chk') {
			$$("#teamMain_doNewGroupChk").addClass("Active")
		}
		if (iAct === 'join') {
			$$("#teamMain_doJoinGroup").addClass("Active")
		}
		if (iAct === 'new') {
			$$("#teamMain_doNewGroup").addClass("Active")
		}		
	}
	
	$$("#teamMain_doNewGroupChk").on('click', function() {
		displayConsole('pageMain - do New Group Name Check', 'Loaded');
		$$(".formErr").removeClass("Active");		
		
		if ($$("#teamMain_newGroupNameChk").val().length < 3) {
			$$("#teamMain_GroupNameErr").addClass("Active");
			return false;
		} else {
			newGroupNameCheck();
			showGroupFx(true, 'new');
		}
	});
	
	$$("#teamMain_doNewGroup").on('click', function() {
		displayConsole('pageMain - do New Group Name', 'Loaded');
		$$(".formErr").removeClass("Active");	
		
		if ($$("input[name='GroupType']:checked").val() === '1') {
			if ($$("#teamMain_GroupPassCode").val().length < 3) {
				showGroupFx(true, 'new');			
				$$("#teamMain_passErr").addClass("Active");
				return false;
			} else {
				doNewGroupName()
			}
		} else {
			$$("#teamMain_GroupPassCode").val('xxx');
			doNewGroupName()
		}
		
	});	
	
//	$$("#btnGroupNameCheck").on('click', function() {
	function newGroupNameCheck() {
		displayConsole('pageTeamMain - GroupName Create', 'Loaded');
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doTeamMain_checkGroupName';
		var JSParam = '&inUserID=' + getLStorage('userId') + '&inUserTeam=' + $$("#teamMain_TeamName").val() + '&inGroupName=' + $$("#teamMain_newGroupNameChk").val() + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			console.log(json);
			if (json.VALUE === 1) {
				$$(".secNewGroupSet").addClass("Active");
			} else {
				$$("#teamMain_GroupNameMsg").addClass("Active");
				$$("#teamMain_GroupNameMsg").html(json.MSG);
				return false;			
			}
		});
	}

	$$("input[type=radio][name='GroupType']").change(function() {
		console.log('my-app.js Ln1193. Radio Change')
		console.log($$("input[name='GroupType']:checked").val());
		if ($$("input[name='GroupType']:checked").val() === '1' ) {
			$$(".secNewGroupSetPass").addClass("Active");	
		} else {
			$$(".secNewGroupSetPass").removeClass("Active");
		}
	});
	
//	$$("#btnGroupNameCreate").on('click', function() {
	function doNewGroupName() {
		displayConsole('pageMain - GroupName Create', 'Loaded');
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doTeamMain_addGroupName';
		var JSParam = '&inUserID=' + getLStorage('userId') + '&inUserTeam=' + getLStorage('userTeam') + '&inGroupName=' + $$("#teamMain_newGroupNameChk").val() + '&inGroupType=' + $$("input[name='GroupType']:checked").val() + '&inGroupCode=' + $$("#teamMain_GroupPassCode").val() + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			console.log(json);
			if (json.VALUE === 1) {
				$$(".secPage").removeClass("Active");
				$$(".secTeamGroupDone").addClass("Active");
				setTimeout( function(){
					doTeamInit(json.USERNAME, json.USERTEAM, json.USERGROUP, json.GROUPKEY);
				}, 2000)
			} else {
				$$("#teamMain_GroupNameMsg").addClass("Active");
				$$("#teamMain_GroupNameMsg").html(json.MSG);					
				return false;
			}
		});
	}

	function doTeamInit(iUN, iUT, iGN, iGK) {
		console.log(iUN);
		console.log(iUT);
		console.log(iGN);
		console.log(iGK);
		
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doTeamMain_addUT';
		var JSParam = '&inUserID=' + getLStorage('userId') + '&inUserName=' + iUN + '&inUserTeam=' + iUT + '&inGroupName=' + iGN + '&inGroupKey=' + iGK + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			console.log(json);
			if (json.VALUE === 1) {
				setLStorage('teamKey', json.UTKEY);
				setLStorage('groupKey', iGK);
				setLStorage('lastKey', json.LASTKEY);
				setLStorage('userGroup', iGN);
				
				var newAppINI = {'AppName':'FantAz', 'AppVer':json.APPVER,'seasonYear':json.SEASONYEAR,'seasonStage':json.SEASONSTAGE,'gmToday':json.GMTODAY};
				delLStorage('AppINI');
				setLStorage('AppINI',JSON.stringify(newAppINI));				
				
				doGoHome();
			} else {
				console.log('Error found');
				$$(".secPage").removeClass("Active");
				$$(".secTeamGroupErr").addClass("Active");			
			}
		});
	}

	$$("#btnGoHome").on('click', function() {
		displayConsole('pageTeamMain - TeamMain Final', 'Loaded');
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doTeamMain_UTFinalize';
		var JSParam = '&inUserID=' + getLStorage('userId') + '&inUserTeam=' + getLStorage('userTeam') + '&inTeamKey=' + getLStorage('teamKey') + '&inGroupKey=' + getLStorage('groupKey') + '&inApp=' + getLStorage('AppINI') + getLStorage('inParam');	
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {		
		
		});
	});

})

function showLoginFail(tStr) {
	$$("#btnUserSignIN").addClass("hide");
	$$("#btnSignINFail").removeClass("hide");
	setTimeout( function(){
		$$("#btnUserSignIN").removeClass("hide");
		$$("#btnSignINFail").addClass("hide");
	}, tStr*1000
	);
}

function doStatHdr(iType, iValue) {

	$$(".link").removeClass("active");
	$$("#toolbarStat").addClass("active");
		
	switch (iType) {
	case 'ACPRank':
		displayConsole('doStatHdr goPage:pageStatRec','BeforeLoad- iValue:'+iValue);
		var dINI = JSON.parse(getLStorage('AppINI'));
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doACPRanking_NBA';
		var JSParam = '&fxParam={"ordBy":"TACP","ordMethod":"desc","seasonYr":' + dINI.seasonYear + ',"Stage":' + dINI.seasonStage + '}&logParam={"inName":"' + getLStorage('userId') + '","inTName":"' + getLStorage('userTeam') + '","inApp":"' + dINI.AppName + '","inAct":"ACPRanking"}' + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			mainView.router.load({url:'pages/pageStatRec.html', ignoreCache:true, reload:true, context: json });			
		});
		break;
	case 'Player':
		displayConsole('doStatHdr goPage:pageStatRec','iValue:'+iValue);
		var dINI = JSON.parse(getLStorage('AppINI'));
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doStat_Player_2018_s3';
		var JSParam = '&PlayerID=' + iValue + '&logParam={"inName":"' + getLStorage('userId') + '","inTName":"' + getLStorage('userTeam') + '","inApp":"' + dINI.AppName + '","inAct":"ACPRanking"}' + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			mainView.router.load({url:'pages/pageStatRec.html', ignoreCache:true, reload:true, context: json });			
		});
		break;
	case 'UTTeam':
		displayConsole('doStatHdr goPage:pageStatRec','iValue:'+iValue);
		var dINI = JSON.parse(getLStorage('AppINI'));
		var JSFile = 'ascFanta_p.cfm';
		var JSMethod = '?method=doStat_UTTeam_2018_s3';
		var JSParam = '&TeamID=' + iValue.slice(0,36) + '&GroupID=' + iValue.slice(-36) + '&logParam={"inName":"' + getLStorage('userId') + '","inTName":"' + getLStorage('userTeam') + '","inApp":"' + dINI.AppName + '","inAct":"ACPRanking"}' + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {
			mainView.router.load({url:'pages/pageStatRec.html', ignoreCache:true, reload:true, context: json });			
		});
		break;		
	}
}

myApp.onPageInit('pageStatRec', function(page) {
	displayConsole('pageStatRec', 'Loaded');
	$$(".PutWLActive").on('click', function(){
		doPutWL(this);
	})
	$$(".plyHist").on('click', function() {
		doStatHdr('Player', this.id);
	});
});

myApp.onPageInit('pageSettA', function(page) {
	indexPageBtnReset();
	$$("#asclogout").on('click',function(event) {
//		alert('Force Logout clicked');
		doForceLogout('userId')
	});
});

myApp.onPageInit('pageNR', function(page) {
	displayConsole('pageNR', 'Loaded');
	indexPageBtnReset();
	doShowHeaderFooter(true);	
});

$$(".hiddenBtn").on('click',function(event) {
	$$(".hiddenBtn").removeClass("Active");	
	var chgFmstate = [];
	var chgTostate = [];
	var chgFvstate = [];
	var chgTvstate = [];
	var chgPID = [];
	var chgFmKey = [];
	var keyVar = '';
	var keySetVal = JSON.parse(getLStorage('keySet'));
//	console.log('KeySetVal:' + keySetVal[0]['f1log']);
	$$(".CPOS.ChangeTo").each(function(idx,elm) {
		FmPos = $$(elm).parent().children(0).children().text();
		FvPos = $$(elm).parent().children(0).children().attr('id');
		ToPos = this.id.slice(-1);
//		alert(FmPos + ":" + ToPos + ":" + FvPos);
		if (FmPos != ToPos) {
			keyVar = FvPos.toLowerCase() + 'log';
//			console.log(keyVar);
//			console.log(keySetVal[0][keyVar]);
			chgFmKey.push(keySetVal[0][keyVar]);
			chgFmstate.push(FmPos);
			chgFvstate.push(FvPos);
			chgTostate.push(this.id.slice(-1));
			chgTvstate.push(this.id.slice(-1));
			chgPID.push($$(elm).parent().parent().attr('id'));
		}
//		displayConsole('pageRoster', this.id.slice(-1) + ',' + $$(elm).parent().parent().attr('id') + ',' + $$(elm).parent().children(0).children().text(), event, this);
	})

	displayConsole("propose change = " + chgFvstate + ":" + chgPID + ":" + chgTostate + ":" + chgFmstate.length);
	displayConsole(chgFvstate);
	displayConsole(chgFmKey);
	
	if (chgFmstate.length > 0) {
		if (chgFmstate.sort().toString() === chgTostate.sort().toString()) {
			$$(".preloader").addClass("Active");
//			alert('Valid Change - Do Update POS'); 
			displayConsole("Valid propose, " + chgFmstate.length + " record(s) involved in this changes")
			
			var JSFile = 'ascFanta_p.cfm'
			var JSMethod = '?method=doUpdUTRoster_NBA_2018_s3_N'
			var JSParam = '&inUTKey=' + getLStorage('teamKey') + '&inGrpKey=' + getLStorage('groupKey') +'&inFmPos='+chgFvstate+'&inPId='+chgPID+'&inToPos='+chgTvstate+'&inFmKey=' + chgFmKey + '&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + getLStorage('inParam');
			console.log(JSLink+JSFile+JSMethod+JSParam);
			$$.getJSON(JSLink+JSFile+JSMethod+JSParam, function(json) {
				setLStorage('lastKey', json.LASTKEY);
				mainView.router.loadPage({url: goPage, ignoreCache:true, reload:true, context: json});
			});
			console.log('ready goPagewData_initRoster');
//			goPagewData_initRoster();
//			doGoHome();			
		} else {
			alert('Conflicted - Reset everything');
			displayConsole("Invalid changes proposal. Action declined");
		};
	} else {
		alert('Nothing Changes');
		displayConsole("proposal declined. Same position changes do not trigger any action");
	}

	setTimeout( function() {
		$$(".preloader").removeClass("Active");			
	}, 1500)
//	goPagewData_1(JSLink+JSFile+JSMethod+JSParam, 'pages/pageRoster.html');
//	goPagewData_initRoster();
	doGoHome();
});

/*
$$(".hiddenBtn").on('click',function(event) {
	$$(".hiddenBtn").removeClass("Active");	
	var chgFmstate = [];
	var chgTostate = [];
	var chgFvstate = [];
	var chgTvstate = [];
	var chgPID = [];
	$$(".CPOS.ChangeTo").each(function(idx,elm) {
		FmPos = $$(elm).parent().children(0).children().text();
		FvPos = $$(elm).parent().children(0).children().attr('id');
		ToPos = this.id.slice(-1);
		//alert(FmPos + ":" + ToPos + ":");
		if (FmPos != ToPos) {
			chgFmstate.push(FmPos);
			chgFvstate.push(FvPos);
			chgTostate.push(this.id.slice(-1));
			chgTvstate.push(this.id.slice(-1));
			chgPID.push($$(elm).parent().parent().attr('id'));
		}
//		displayConsole('pageRoster', this.id.slice(-1) + ',' + $$(elm).parent().parent().attr('id') + ',' + $$(elm).parent().children(0).children().text(), event, this);
	})

	displayConsole("propose change = " + chgFvstate + ":" + chgPID + ":" + chgTostate + ":" + chgFmstate.length);
	displayConsole(chgFvstate);
	
	if (chgFmstate.length > 0) {
		if (chgFmstate.sort().toString() === chgTostate.sort().toString()) {
			$$(".preloader").addClass("Active");
//			alert('Valid Change - Do Update POS'); 
			displayConsole("Valid propose, " + chgFmstate.length + " record(s) involved in this changes")
			
			var JSFile = 'ascFanta_p.cfm'
			var JSMethod = '?method=doUpdUTRoster_NBA_2018_s3'
			var JSParam = '&inUTKey=' + getLStorage('teamKey') + '&inFmPos='+chgFvstate+'&inPId='+chgPID+'&inToPos='+chgTvstate+'&inName=' + getLStorage('userId') + '&inTName=' + getLStorage('userTeam') + getLStorage('inParam');
			console.log(JSLink+JSFile+JSMethod+JSParam);
			$$.getJSON(JSLink+JSFile+JSMethod+JSParam, function(json) {
				setLStorage('lastKey', json.LASTKEY);
				mainView.router.loadPage({url: goPage, ignoreCache:true, reload:true, context: json});
			});
			console.log('ready goPagewData_initRoster');
//			goPagewData_initRoster();
//			doGoHome();			
		} else {
			alert('Conflicted - Reset everything');
			displayConsole("Invalid changes proposal. Action declined");
		};
	} else {
		alert('Nothing Changes');
		displayConsole("proposal declined. Same position changes do not trigger any action");
	}

	setTimeout( function() {
		$$(".preloader").removeClass("Active");			
	}, 1500)
//	goPagewData_1(JSLink+JSFile+JSMethod+JSParam, 'pages/pageRoster.html');
//	goPagewData_initRoster();
	doGoHome();
});
*/

function goPagewData_initRoster() {
	var JSFile = 'ascFanta_p.cfm'
	var JSMethod = '?method=doGetUTRoster_DTS_NBA_2018_s3'
	var JSParam = '&inUTKey=7422&inDate=&inName=' + getLStorage('userId') + getLStorage('inParam');

	$$.getJSON(JSLink+JSFile+JSMethod+JSParam, function(json) {
		setLStorage('lastKey', json.LASTKEY);
		setLStorage('keySet', JSON.stringify(json.KEYSET));
		mainView.router.loadPage({url: 'pages/pageRoster.html', ignoreCache:true, reload:true, context: json});
	});
}

function indexPageBtnReset() {
	$$(".hiddenBtn").removeClass("Active");
	$$(".tmRosterWL").removeClass("Active");	
	$$(".tmRosterWLCan").removeClass("Active");
	setLStorage('WLDsp', 'N')	
}

// Footer Toolbar 
$$(".link").on('click', function(event) {
	displayConsole('index', 'toolbar', event, this);

	$$(".link").removeClass("active");
	$$("#" + this.id).addClass("active");

	switch (this.id) {
		case 'toolbarRoster':
			doGoHome();
			break;
		case 'toolbarLeague':
			doLeagueRank('prvLlgd');
			break;
		case 'toolbarRank':
			doACPRank('DACP','desc');
			break;
		case 'toolbarPlayer':
			openTradeCenter();
//			doPlayerLst('B',0);
			break;
		case 'toolbarStat':
			doStatHdr('ACPRank');
			break;
	}
});

function displayConsole(iPage, iFx, iAct, iObj) {
	if (arguments[3]) {
		if (typeof(iObj.id) === 'undefined') {
			dObj = iObj.class;
		} else {
			dObj = iObj.id
		}
		console.log('Page:' + iPage + ' ; Fx:' + iFx + ' ; Act:' + iAct.type + ' ; Id: ' + dObj);	
	} else {
		if (arguments[2]) {
			console.log('Page:' + iPage + ' ; Fx:' + iFx + ' ; Act:' + iAct.type);	
		} else {
			console.log('Page:' + iPage + ' ; Fx:' + iFx);		
		}
	}
}

function displayReturn(iName, iRet) {
	console.log('display JSON [' + iName + '] return in below line');	
	console.log(iRet);
	console.log('End display JSON Return');
};

function displayVar() {
	console.log('displayVar in Next line');
	var oName = arguments[0];
	var oVal = arguments;
	
	$$.each(oName.split(','), function(iName, iValue) {
		console.log(' --> ' + iValue + ':' + oVal[iName+1]);
	});
	console.log('End display Var');
}

function doShowHeaderFooter(iVal) {
	if (iVal) {
		mainView.showNavbar();
		mainView.showToolbar();			
	} else {
		mainView.hideNavbar();
		mainView.hideToolbar();			
	}
}

function HomewData() {
	displayConsole('myApp.js','HomewData');
	if (arguments[0]) {
		mainView.router.load({url:P010.url, ignoreCache:true, reload:false, context:arguments[0]})
	} else {
		console.log('missing parameters: HomewData');
	}
}

function doForceLogout(LSName) {
//	var JSFile = 'ascDict_JS_proxy.cfm';
	var JSFile = 'ascFanta_p.cfm';
	var JSMethod = '?method=doForceLogout';
	var JSParam = '&inName=' + getLStorage(LSName) + '&inTName=' + getLStorage('userTeam')+ getLStorage('inParam');	
//	console.log(JSLink + JSFile + JSMethod + JSParam);
	$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function(lOut) {
		if (lOut.DONE) {
			console.log('logout clicked. Localstorage cleared');
		}
		delLStorage('ALL');
		HomewData(P010.defData);
		setTimeout( function() {
			setLStorage('AppINI',JSON.stringify(AppINI));
			setInParam()
//			readInAppJS('ascDictA.js');
			doAppStartUp();
		}, 2000)
	});	
}

function setLStorage(iKey, iValue) {
	localStorage.setItem(iKey, iValue);	
}

function getLStorage(iKey) {
	return	localStorage.getItem(iKey);
}

function delLStorage(iKey) {
	if (iKey == 'ALL') {
		localStorage.clear();
	}
	else {		
		localStorage.removeItem(iKey);
	}
}

function listLStorage() {
	for (i = 0; i < localStorage.length; i++)   {
		console.log(localStorage.key(i) + "=[" + localStorage.getItem(localStorage.key(i)) + "]");
	}	
}

function setInParam() {
//	setLStorage('inParam','&inParam='+device.platform+"|"+device.version+"|"+device.uuid+"|"+device.manufacturer+"|"+device.isVirtual+"|"+getLStorage('inLati')+","+getLStorage('inLongi')+","+getLStorage('inAlti'));
	setLStorage('inParam','&inParam='+device.platform+"|"+device.version+"|"+device.uuid+"|"+device.manufacturer+"|"+device.isVirtual+"|"+getLStorage('inLati')+","+getLStorage('inLongi')+","+getLStorage('inAlti'));
	delLStorage('inLati');
	delLStorage('inLongi');
	delLStorage('inAlti');
	displayConsole('call setInParam');
}

function chkLoginStatus() {
	if (!localStorage.userId) {
		setLStorage('userId','NoData');
		return false;
	} else {
		return true
	}
};

function readInAppJS(iLocalVar) {
	displayConsole('','readInAppJS');
	
	var JSFile = 'ascDict_JS_proxy.cfm'
	var JSMethod = '?method=doChkValidLogin'
	var JSParam = '&inName=' + getLStorage('userId') + '&inKey=' + getLStorage('lastKey') + '&inApp=DictA' + getLStorage('inParam');

	$$.ajax({
		url: JSLink + JSFile + JSMethod + JSParam,
		dataType: 'json',
		success: function(chkPassValue) {
			displayReturn('chkPassValue',chkPassValue);
			if (chkPassValue.VALUE == 1) {
				mainView.router.loadPage({url:P010.url, ignoreCache:true, reload:true, context: chkPassValue})
			}
		},
		error: function(e, ts, et) { 
			console.log('Error found: ' + e + ':' + ts + ':' + et);
		}
	 });
}

function onPOSSuccess(position) {
	setLStorage('inLati', position.coords.latitude);
	setLStorage('inLongi', position.coords.longitude);
	setLStorage('inAlti', position.coords.altitude);	
	setInParam();
}

function onPOSError(error) {
	setLStorage('inLati','null-Lati');
	setLStorage('inLongi','null-Longi');
	setLStorage('inAlti','null-Alti');
	setInParam();
}

function upGPS() {
	displayConsole('call upGPS');
	navigator.geolocation.getCurrentPosition(onPOSSuccess, onPOSError); 
}

function beforeStartApp(oStatus) {
	CreateINIFile(function(readINI) {
		if (readINI.isFile) {
//			alert('it is True' + readINI.fullPath);	
				readINIFileLen(function(fLen) {
//					alert(fLen);
					if (fLen == 0) {
//	INI file can't be found. create new and write default value to INI.
						writeINI(AppINI);
						oStatus(false);
					} else {
						writeINI(AppINI);
						JSPath = cordova.file.dataDirectory;
//						alert(JSPath + readINI.fullPath);
						$$.getJSON(JSPath + readINI.fullPath, function(readRes) {
//							alert(readRes);							
							if (readRes.AppName == AppINI.AppName) {
// update system variable AppINI
								AppINI = readRes;
// AppINI save to Local Storage as name AppINI	
								setLStorage('AppINI',JSON.stringify(AppINI));
//								setLStorage('userId',AppINI.userName);								
								oStatus(true);
							} else {
//	INI file may be crash. write empty and default value to INI.								
								writeINI(AppINI);
								oStatus(false);
							}
						});
					}
				});
		}
	});
}

function readINIFileLen(fileLen) {
	INIOb.file(function(INIFile) {	
	var reader = new FileReader();
    reader.onloadend = function(e) {
		fileLen(this.result.length)
    };
    reader.readAsText(INIFile);	
//	alert(INIFile);
	})
}

function CreateLOGFile(successCallback, failCallback) {
	window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function(dir) {	
		dir.getFile("log.txt", {create:true}, function(logFile) {
			logOb = logFile;
//			alert(logFile.isFile +':'+chkCount);
			writeLog("App started");  
			successCallback(logFile);        
		});
	});
}

function CreateINIFile(successCallback) {
//	alert('createINI Start');
	window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function(dir) {	
		dir.getFile("APP.js", {create:true}, function(iniFile) {
			INIOb = iniFile;		
//			alert('createINI proc');
			successCallback(iniFile);
		});
	});
}

function doAppStartUp() {
	displayConsole('index','doAppStart');
	
	var wTm = 2
	
	StartPageProp = defPageProp;
	StartPageProp.url = P010.url;

	if (getLStorage('tempSupp')) {
		StartPageProp.context = {'tempSupp':getLStorage('tempSupp')};
		wTm = 3*60
	}
	goPagewData(StartPageProp);

	setTimeout(function() {
//		var JSFile = 'ascDict_JS_proxy.cfm'
		var JSFile = 'ascFanta_p.cfm';		
		var JSMethod = '?method=doStartApp';
		var JSParam = '&inTName=' + getLStorage('userTeam') + '&inApp=' + P010.defData.APP + '&inLastKey=' + getLStorage('lastKey') + getLStorage('inParam');
		console.log(JSLink + JSFile + JSMethod + JSParam);
		$$.getJSON(JSLink + JSFile + JSMethod + JSParam, function (json) {	
			if (json.CHKPASS == "1") {
				setLStorage('lastKey', json.LASTKEY);
				setLStorage('groupKey', json.GROUPKEY);
				setLStorage('teamKey', json.TEAMKEY);
				setLStorage('userId', json.USERID);			
				setLStorage('userGroup',json.USERGROUP);				
//				alert(AppINI.AppVer + ":" + json.APPVER);
//				alert(json);
				var newAppINI = {'AppName':'FantAz', 'AppVer':json.APPVER,'seasonYear':json.SEASONYEAR,'seasonStage':json.SEASONSTAGE,'gmToday':json.GMTODAY};
				delLStorage('AppINI');
				setLStorage('AppINI',JSON.stringify(newAppINI));

				if (json.APPVER !== AppINI.AppVer) {
//					doVerUpd()
//					alert('do Version update');
				}
				var upPageData = defPageProp;
				upPageData.url = P010.url;
				upPageData.reload = true;
				upPageData.context = json;
				goPagewData(upPageData)
				return
			} else {
				delLStorage('userTeam');
				delLStorage('lastKey');
				var newAppINI = {'AppName':'FantAz', 'AppVer':json.APPVER};
				delLStorage('AppINI');
				setLStorage('AppINI',JSON.stringify(newAppINI));
				var upPageData = defPageProp;
				upPageData.url = P010.url;
				upPageData.reload = true;
				upPageData.context = json;
				goPagewData(upPageData)
				return
			}
		});
	}, wTm*1000);
}

function checkSupp() {
	var ntm = new Date();
	if (parseInt(ntm-getLStorage('tempSupp')) > 3*60*1000) {
		delLStorage('tempSupp');	
	}
}

function writeLog(str) {
	if(!logOb) return;
	var log = str + " [" + (new Date()) + "]\n";
	logOb.createWriter(function(fileWriter) {
		fileWriter.seek(fileWriter.length);
		var blob = new Blob([log], {type:'text/plain'});
		fileWriter.write(blob);
	}, Filefail);
}

function writeINI(str) {
//	alert('doing Write INI');
	if(!INIOb) return;
	var iniStr = JSON.stringify(str);
	INIOb.createWriter(function(fileWriter) {
		fileWriter.seek(0);
		var blob = new Blob([iniStr], {type:'text/plain'});
		fileWriter.write(blob);
	}, Filefail);
}

function Filefail(e) {
	console.log("FileSystem Error");
	console.dir(e);
	alert('FS error' + e);
}

function showLogFile() {
	if (device.platform != "browser") {
		logOb.file(function(logfile) {
			var reader = new FileReader();
			reader.onloadend = function(e) {
				alert(this.result);
//				updGVar(this.result);
			};
			reader.readAsText(logfile);
		}, Filefail);
	}
}

function showINIFile() {
//	alert(device.platform);
// browser not work. So bypass it
	if (device.platform != "browser") {
		INIOb.file(function(INIFile) {
			var reader = new FileReader();
			reader.onloadend = function(e) {
				alert(this.result);
//				INIOb = this.result;
			};
			reader.readAsText(INIFile);
		}, Filefail);
	}
}

function showINIStr() {
	var LSS = '';
	for(var i in localStorage) {
		LSS = LSS +(i + ':' + localStorage[i] + '; ');
	}
	alert(LSS);
}

function showDir(path){
//		alert(path);
	$$("#listFiles").empty();
	window.resolveLocalFileSystemURL(path, function(fileSystem) {
		var listPath;
		var listFile = fileSystem.createReader();
		listFile.readEntries(function(entries) {
			for(i=0;i<=entries.length;i++) {
				if (entries[i].name.slice(-3) == 'wav') {
//					alert(path + ":+:" + entries[i].name +"-\n");
					$$("#listFiles").append("<p class='selfFile'>" + path + ":+:" + entries[i].name + "</p>");
				} else {				
//					alert(path + ":+:" + entries[i].name +"-\n");
					$$("#listFiles").append("<p>" + path + ":+:" + entries[i].name + "</p>");						
				}
			}
		});
	});
}

function showAppINIVar() {
	alert(JSON.stringify(AppINI));
}

function delAppFile(path, filename) {
	window.resolveLocalFileSystemURL(path, function(dir) {
		dir.getFile(filename, {create:false}, function(fileEntry) {
				  fileEntry.remove(function(){
					  // The file has been removed succesfully
					  alert('File removed');
				  },function(error){
					  // Error deleting the file
					  alert('delAppFile error');
				  },function(){
					 // The file doesn't exist
					 alert('Target file not existed');
				  });
		});
	});	
}

function updGVar(str) {
	var lines = str.split("\n");
// -2: Substrate First Index 0 and Last Empty Row
	AppINI.lastAccessDT = lines[parseInt(lines.length)-2];
	alert("Last Login DT:" + AppINI.lastAccessDT);
}

function goPagewData(pageObj) {
	mainView.router.loadPage(pageObj);
}

function formBoolean(iVar) {
	if (iVar.indexOf("on") >= 0) {
		ret = 1;	
	} else {
		ret = 0;			
	}
	return ret;
}

function json2URLparam(iCase, iData) {
	var ret = "";
	switch (iCase) {
		case 'regForm':
			if ((iData.gender).length <= 0) {
				alert('gender can\'t empty');
				return false;	
			} 
			if ((iData.DOB).length <= 0) {
				alert('DOB can\'t empty');
				return false;	
			} 
			if ((iData.liveat).length <= 0) {
				alert('LiveAt can\'t is empty');
				return false;	
			} 
			
			ret = iData.gender + "|" + iData.DOB + "|" + iData.liveat + "|" + iData.yrschool + "|" + iData.yrschoolgrade + "|" + formBoolean(iData.rTerms) + "|" + formBoolean(iData.rRemoveAd);
			break;
	}
	return ret;
};
