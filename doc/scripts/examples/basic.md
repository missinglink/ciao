# Check Google is still running

*Generated: Wed Jan 30 2013 23:28:03 GMT+0000 (GMT)*
## Request
```javascript
{
  "protocol": "http:",
  "host": "www.google.co.uk",
  "method": "GET",
  "port": 80,
  "path": "/",
  "headers": {
    "User-Agent": "Ciao/Client 1.0"
  }
}
```

## Response
```javascript
Status: 200
{
  "date": "Wed, 30 Jan 2013 23:27:58 GMT",
  "expires": "-1",
  "cache-control": "private, max-age=0",
  "content-type": "text/html; charset=ISO-8859-1",
  "set-cookie": [
    "PREF=ID=7e09ee1576f25cbc:FF=0:TM=1359588478:LM=1359588478:S=mbvE2kdwd8IB2_Wx; expires=Fri, 30-Jan-2015 23:27:58 GMT; path=/; domain=.google.co.uk",
    "NID=67=HazlouIm54mdDerM56vn70u8nZWOcCbvvvHQY3HkdN55fhS4POnEPnBPZcIxTMGXY62Mvujq6yERfmC2shr1_SO9_oTbM5YNB1z3HNES0lsVdPP9DCCrugvLqdABVPdH; expires=Thu, 01-Aug-2013 23:27:58 GMT; path=/; domain=.google.co.uk; HttpOnly"
  ],
  "p3p": "CP=\"This is not a P3P policy! See http://www.google.com/support/accounts/bin/answer.py?hl=en&answer=151657 for more info.\"",
  "server": "gws",
  "x-xss-protection": "1; mode=block",
  "x-frame-options": "SAMEORIGIN",
  "connection": "close"
}
```
```html
<!doctype html><html itemscope="itemscope" itemtype="http://schema.org/WebPage"><head><meta itemprop="image" content="/images/google_favicon_128.png"><title>Google</title><script>(function(){
window.google={kEI:"fqwJUd6gL5Sr0AXS8YDgCw",getEI:function(a){for(var b;a&&(!a.getAttribute||!(b=a.getAttribute("eid")));)a=a.parentNode;return b||google.kEI},https:function(){return"https:"==window.location.protocol},kEXPI:"17259,39523,39977,4000116,4001569,4001683,4001959,4001975,4002001,4002378,4002436,4002562,4002700,4002733,4002855,4002858,4002928,4003035,4003215,4003225,4003316,4003320,4003335,4003340,4003385,4003386,4003518,4003523,4003526,4003644,4003654",kCSI:{e:"17259,39523,39977,4000116,4001569,4001683,4001959,4001975,4002001,4002378,4002436,4002562,4002700,4002733,4002855,4002858,4002928,4003035,4003215,4003225,4003316,4003320,4003335,4003340,4003385,4003386,4003518,4003523,4003526,4003644,4003654",ei:"fqwJUd6gL5Sr0AXS8YDgCw"},authuser:0,ml:function(){},kHL:"en",time:function(){return(new Date).getTime()},log:function(a,
b,c,i){var d=new Image,f=google.lc,e=google.li,g="";d.onerror=d.onload=d.onabort=function(){delete f[e]};f[e]=d;!c&&-1==b.search("&ei=")&&(g="&ei="+google.getEI(i));c=c||"/gen_204?atyp=i&ct="+a+"&cad="+b+g+"&zx="+google.time();a=/^http:/i;a.test(c)&&google.https()?(google.ml(Error("GLMM"),!1,{src:c}),delete f[e]):(d.src=c,google.li=e+1)},lc:[],li:0,Toolbelt:{},y:{},x:function(a,b){google.y[a.id]=[a,b];return!1},load:function(a,b){google.x({id:"l"+a},function(){google.load(a,b)})}};
})();
(function(){var d=!1;google.sn="webhp";google.timers={};google.startTick=function(a,b){google.timers[a]={t:{start:google.time()},bfr:!!b}};google.tick=function(a,b,h){google.timers[a]||google.startTick(a);google.timers[a].t[b]=h||google.time()};google.startTick("load",!0);
try{}catch(e){}})();
var _gjwl=location;function _gjuc(){var a=_gjwl.href.indexOf("#");if(0<=a&&(a=_gjwl.href.substring(a),0<a.indexOf("&q=")||0<=a.indexOf("#q=")))if(a=a.substring(1),-1==a.indexOf("#")){for(var d=0;d<a.length;){var b=d;"&"==a.charAt(b)&&++b;var c=a.indexOf("&",b);-1==c&&(c=a.length);b=a.substring(b,c);if(0==b.indexOf("fp="))a=a.substring(0,d)+a.substring(c,a.length),c=d;else if("cad=h"==b)return 0;d=c}_gjwl.href="/search?"+a+"&cad=h";return 1}return 0}
function _gjp(){(!window._gjwl.hash||!window._gjuc())&&setTimeout(_gjp,500)};
window._gjp&&_gjp();</script><style>#gbar,#guser{font-size:13px;padding-top:1px !important;}#gbar{height:22px}#guser{padding-bottom:7px !important;text-align:right}.gbh,.gbd{border-top:1px solid #c9d7f1;font-size:1px}.gbh{height:0;position:absolute;top:24px;width:100%}@media all{.gb1{height:22;margin-right:.5em;vertical-align:top}#gbar{float:left}}a.gb1,a.gb4{text-decoration:underline !important}a.gb1,a.gb4{color:#00c !important}.gbi .gb4{color:#dd8e27 !important}.gbf .gb4{color:#900 !important}</style><style>.h{font-family:arial,sans-serif}body{font-family:arial,sans-serif}td{font-family:arial,sans-serif}a{font-family:arial,sans-serif}p{font-family:arial,sans-serif}body{margin:0;overflow-y:scroll}#gog{padding:3px 8px 0}.h{color:#36c}.q{color:#00c}.ts{border-collapse:collapse}td{line-height:.8em}.gac_m td{line-height:17px}form{margin-bottom:20px}.ts td{padding:0}em{font-weight:bold;font-style:normal}.lst{height:25px;width:496px;font:18px arial,sans-serif}.gsfi{font:18px arial,sans-serif}.gsfs{font:17px arial,sans-serif}.ds{display:inline-box;display: inline-block;margin:3px 0 4px;margin-left:4px}input{font-family:inherit}body{background:#fff;color:black}a.gb1{color:#11c !important}a.gb2{color:#11c !important}a.gb3{color:#11c !important}a.gb4{color:#11c !important}.sblc{padding-top:5px}.lsbb{background:#eee;border:solid 1px;border-color:#ccc #999 #999 #ccc;height:30px}a{color:#11c;text-decoration:none}a:hover{text-decoration:underline}a:active{text-decoration:underline}.fl a{color:#36c}a:visited{color:#551a8b}a.gb1{text-decoration:underline}a.gb4{text-decoration:underline}a.gb3:hover{text-decoration:none}.sblc a{display:block;margin:2px 0;margin-left:13px;font-size:11px}#ghead a.gb2:hover{color:#fff !important}.lsbb{display:block}.ftl{display:inline-block;margin:0 12px}.lsb{background:url(/images/srpr/nav_logo80.png) 0 -258px repeat-x;border:none;color:#000;cursor:pointer;height:30px;margin:0;outline:0;font:15px arial,sans-serif;vertical-align:top}#fll a{display:inline-block;margin:0 12px}.lsb:active{background:#ccc}.lst:focus{outline:none}#addlang a{padding:0 3px}</style><script></script> </head><body dir="ltr" bgcolor="#fff"><script>(function(){var src='/images/srpr/nav_logo80.png';var iesg=false;document.body.onload = function(){window.n && window.n();if (document.images){new Image().src=src;}
if (!iesg){document.f&&document.f.q.focus();document.gbqf&&document.gbqf.q.focus();}
}
})();</script><textarea id="csi" style="display:none"></textarea><div id="mngb"><div id=gbar><nobr><b class=gb1>Search</b> <a class=gb1 href="http://www.google.co.uk/imghp?hl=en&tab=wi">Images</a> <a class=gb1 href="http://maps.google.co.uk/maps?hl=en&tab=wl">Maps</a> <a class=gb1 href="https://play.google.com/?hl=en&tab=w8">Play</a> <a class=gb1 href="http://www.youtube.com/?gl=GB&tab=w1">YouTube</a> <a class=gb1 href="http://news.google.co.uk/nwshp?hl=en&tab=wn">News</a> <a class=gb1 href="https://mail.google.com/mail/?tab=wm">Gmail</a> <a class=gb1 href="https://drive.google.com/?tab=wo">Drive</a> <a class=gb1 style="text-decoration:none" href="http://www.google.co.uk/intl/en/options/"><u>More</u> &raquo;</a></nobr></div><div id=guser width=100%><nobr><span id=gbn class=gbi></span><span id=gbf class=gbf></span><span id=gbe></span><a href="http://www.google.co.uk/history/optout?hl=en" class=gb4>Web History</a> | <a  href="/preferences?hl=en" class=gb4>Settings</a> | <a target=_top id=gb_70 href="https://accounts.google.com/ServiceLogin?hl=en&continue=http://www.google.co.uk/" class=gb4>Sign in</a></nobr></div><div class=gbh style=left:0></div><div class=gbh style=right:0></div></div><center><br clear="all" id="lgpd"><div id="lga"><div style="padding:28px 0 3px"><div dir="ltr" title="Google" align="left" id="hplogo" onload="window.lol&&lol()" style="height:110px;width:276px;background:url(/images/srpr/logo1w.png) no-repeat"><div nowrap="nowrap" style="color:#777;font-size:16px;font-weight:bold;position:relative;left:214px;top:70px">UK</div></div></div><br></div><form action="/search" name="f"><table cellpadding="0" cellspacing="0"><tr valign="top"><td width="25%">&nbsp;</td><td align="center" nowrap="nowrap"><input name="ie" value="ISO-8859-1" type="hidden"><input value="en-GB" name="hl" type="hidden"><input name="source" type="hidden" value="hp"><div class="ds" style="height:32px;margin:4px 0"><input autocomplete="off" class="lst" value="" title="Google Search" maxlength="2048" name="q" size="57" style="color:#000;margin:0;padding:5px 8px 0 6px;vertical-align:top"></div><br style="line-height:0"><span class="ds"><span class="lsbb"><input class="lsb" value="Google Search" name="btnG" type="submit"></span></span><span class="ds"><span class="lsbb"><input class="lsb" value="I'm Feeling Lucky" name="btnI" type="submit" onclick="if(this.form.q.value)this.checked=1; else top.location='/doodles/'"></span></span></td><td class="fl sblc" align="left" nowrap="nowrap" width="25%"><a href="/advanced_search?hl=en-GB&amp;authuser=0">Advanced search</a><a href="/language_tools?hl=en-GB&amp;authuser=0">Language tools</a></td></tr></table><input type="hidden" id="gbv" name="gbv" value="1"></form><div id="gac_scont"></div><div style="font-size:83%;min-height:3.5em"><br></div><span id="footer"><div style="font-size:10pt"><div id="fll" style="margin:19px auto;text-align:center"><a href="/intl/en/ads/">Advertising&nbsp;Programmes</a><a href="/services/">Business Solutions</a><a href="https://plus.google.com/103583604759580854844" rel="publisher">+Google</a><a href="/intl/en/about.html">About Google</a><a href="http://www.google.co.uk/setprefdomain?prefdom=US&amp;sig=0_DbGq3IpNpw6PXwRhrmiW130Kd9Y%3D" id="fehl">Google.com</a></div></div><p style="color:#767676;font-size:8pt">&copy; 2012 - <a href="/intl/en/policies/">Privacy & Terms</a></p></span></center><div id=xjsd></div><div id=xjsi><script>if(google.y)google.y.first=[];(function(){var b;function c(a){window.setTimeout(function(){var d=document.createElement("script");d.src=a;document.getElementById("xjsd").appendChild(d)},0)}google.dljp=function(a){b=a;google.xjsi||(google.xjsu=a,c(b))};google.dlj=c;})();
if(!google.xjs){google.dstr=[];google.rein=[];window._=window._||{};window._._DumpException=function(e){throw e};if(google.timers&&google.timers.load.t){google.timers.load.t.xjsls=new Date().getTime();}google.dljp('/xjs/_/js/hp/sb_he,pcc/rt\x3dj/ver\x3dECw6ze06JVo.en_US./d\x3d1/sv\x3d1/rs\x3dAItRSTMXMY0kse0DL3ro3zcp1x_cSU-yeg');google.xjs=1;}google.pmc={sb:{"agen":false,"cgen":true,"client":"heirloom-hp","dh":true,"ds":"","eqch":true,"fl":true,"host":"google.co.uk","jsonp":true,"msgs":{"lcky":"I\u0026#39;m Feeling Lucky","lml":"Learn more","oskt":"Input tools","psrc":"This search was removed from your \u003Ca href=\"/history\"\u003EWeb History\u003C/a\u003E","psrl":"Remove","sbit":"Search by image","srch":"Google Search"},"ovr":{"ms":1},"pq":"","qcpw":false,"scd":10,"sce":5,"stok":"sHLcYfdob1rEjI7DOS24GfIEvOo"},hp:{},pcc:{}};google.y.first.push(function(){if(google.med){google.med('init');google.initHistory();google.med('history');}google.History&&google.History.initialize('/');google.hs&&google.hs.init&&google.hs.init()});if(google.j&&google.j.en&&google.j.xi){window.setTimeout(google.j.xi,0);}</script></div><script>(function(){var b,c,d,e;function g(a,f){a.removeEventListener?(a.removeEventListener("load",f,!1),a.removeEventListener("error",f,!1)):(a.detachEvent("onload",f),a.detachEvent("onerror",f))}function h(a){e=(new Date).getTime();++c;a=a||window.event;a=a.target||a.srcElement;g(a,h)}var i=document.getElementsByTagName("img");b=i.length;
for(var j=c=0,k;j<b;++j)k=i[j],k.complete||"string"!=typeof k.src||!k.src?++c:k.addEventListener?(k.addEventListener("load",h,!1),k.addEventListener("error",h,!1)):(k.attachEvent("onload",h),k.attachEvent("onerror",h));d=b-c;
function l(){if(google.timers.load.t){google.timers.load.t.ol=(new Date).getTime();google.timers.load.t.iml=e;google.kCSI.imc=c;google.kCSI.imn=b;google.kCSI.imp=d;void 0!==google.stt&&(google.kCSI.stt=google.stt);google.csiReport&&google.csiReport()}}window.addEventListener?window.addEventListener("load",l,!1):window.attachEvent&&window.attachEvent("onload",l);google.timers.load.t.prt=e=(new Date).getTime();})();
</script></body></html>
```

## Tests

### ✓ Should have company name
```javascript
response.body.should.containEql 'Google'
```

