<style type="text/css">

	#master		 {position:absolute; width: 200px; top: 3px; left: -186px; z-index:2; visibility:visible;}
	#menu		 {position:absolute; width:  18px; top: 0px; left:  186px; z-index:5; visibility:visible;}
	#top		 {position:absolute; width: 180px; top: 0px; left:    6px; z-index:5; visibility:visible;}
	#screen		 {position:absolute; width: 180px; top: 6px; left:    6px; z-index:5; visibility:visible;}
	#screenlinks {position:absolute; width: 180px; top: 6px; left:    6px; z-index:5; visibility:visible;}

	.NavJump          {font-family: verdana; font-size: 10pt; color: #808080; text-decoration: none;}
	a:link.NavJump    {color : #808080;}
	a:visited.NavJump {color : #808080;}
	a:active.NavJump  {text-decoration: none; color: #0080c0;}
	a:hover.NavJump   {text-decoration: none; color: #0080c0;}

</style>

<script language="JavaScript">
var top = 3;
var left = 186;
var left_h = -left;
var left_mv = 6;

menutop = new Image();
menutop.src = "images/menu.gif";
menutop_on = new Image();
menutop_on.src = "images/menu_on.gif";

menutopb = new Image();
menutopb.src = "images/menub.gif";
menutopb_on = new Image();
menutopb_on.src = "images/menub_on.gif";

var ie = document.all ? 1 : 0;
var ns = document.layers ? 1 : 0;
var expandState = 0;

if(ie)
{
	document.write('<style type="text/css">');
	document.write("#screen	{filter:Alpha(Opacity=30);}");
	document.write("</style>");
}

if(ns)
{
	document.write('<style type="text/css">');
	document.write("#master	{clip:rect(6,180,250,6);}");
	document.write("</style>");
}

</script>

<script language="JavaScript">

var ie = document.all ? 1 : 0;
var ns = document.layers ? 1 : 0;

var master = new Object("element");

master.curLeft = left_h;	
master.curTop = top;
master.gapLeft = 6;		
master.gapTop = 0;
master.timer = null;

function moveAlong(layerName, paceLeft, paceTop, fromLeft, fromTop)
{
	clearTimeout(eval(layerName).timer);

	if(eval(layerName).curLeft != fromLeft)
	{
    	if((Math.max(eval(layerName).curLeft, fromLeft) - Math.min(eval(layerName).curLeft, fromLeft)) < paceLeft)
		{
			eval(layerName).curLeft = fromLeft;
		} else 
			if(eval(layerName).curLeft < fromLeft)
			{
				eval(layerName).curLeft = eval(layerName).curLeft + paceLeft;
			} else 
				if(eval(layerName).curLeft > fromLeft)
				{
					eval(layerName).curLeft = eval(layerName).curLeft - paceLeft;
				}
		if(ie)
		{
			document.all[layerName].style.left = eval(layerName).curLeft;
		}
		if(ns)
		{
			document[layerName].left = eval(layerName).curLeft;
		}
	}

	if(eval(layerName).curTop != fromTop)
	{
    	if((Math.max(eval(layerName).curTop, fromTop) - Math.min(eval(layerName).curTop, fromTop)) < paceTop)
		{
			eval(layerName).curTop = fromTop;
		} else 
			if(eval(layerName).curTop < fromTop)
			{
				eval(layerName).curTop = eval(layerName).curTop + paceTop;
			} else 
				if(eval(layerName).curTop > fromTop)
				{
					eval(layerName).curTop = eval(layerName).curTop - paceTop;
				}
			if(ie)
			{
				document.all[layerName].style.top = eval(layerName).curTop;
			}
			if(ns)
			{
				document[layerName].top = eval(layerName).curTop;
			}
	}
	eval(layerName).timer=setTimeout('moveAlong("'+layerName+'",'+paceLeft+','+paceTop+','+fromLeft+','+fromTop+')',30);
}

function setPace(layerName, fromLeft, fromTop, motionSpeed)
{
	eval(layerName).gapLeft = (Math.max(eval(layerName).curLeft, fromLeft) - Math.min(eval(layerName).curLeft, fromLeft))/motionSpeed;
	eval(layerName).gapTop = (Math.max(eval(layerName).curTop, fromTop) - Math.min(eval(layerName).curTop, fromTop))/motionSpeed;
	moveAlong(layerName, eval(layerName).gapLeft, eval(layerName).gapTop, fromLeft, fromTop);
}

function expand()
{
	if(expandState == 0)
	{
		setPace("master", left_mv, top, 10); 
		if(ie)
		{
			document.menutop.src = "images/menub.gif";
		}
		expandState = 1;
	} else
	{
		setPace("master", left_h, top, 10);
		if(ie)
		{
			document.menutop.src = "images/menu.gif";
		}
		expandState = 0;
	}
}
</script>

<script language="JavaScript">
var ie = document.all ? 1 : 0;
var ns = document.layers ? 1 : 0;


if(ie)
{
	var sidemenu = document.all.master;
}

if(ns)
{
	var sidemenu = document.master;
}

function FixY()
{
	if(ie)
	{
		var sidemenu = document.all.master;
		sidemenu.style.top = document.body.scrollTop+top;
	}
	if(ns)
	{
		var sidemenu = document.master;
		sidemenu.top = window.pageYOffset+top;
	}
}

function ativa()
{
	if ( expandState )
	{
		if (document.images) document.menutop.src = eval("menutopb_on.src");
	} else
	{
	    if (document.images) document.menutop.src = eval("menutop_on.src");
	}
}

function desativa()
{
	if ( expandState )
	{
		if (document.images) document.menutop.src = menutopb.src;
	} else
	{
	    if (document.images) document.menutop.src = menutop.src;
	}
}

function init_menu()
{
	setInterval("FixY()",100);
}

onload=init_menu;
</script>

<div id="master">
	<div id="menu">
		<table border="0" width="18" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%">
				<a href="javascript:expand()" onmouseover="ativa()" onmouseout="desativa()" onfocus="this.blur()"><img name="menutop" border="0" src="images/menu.gif"></a>
			</td>
		</tr>
		</table>
	</div>

	<div id="top">
		<table border="0" width="180" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%"><img border="0" src="images/top.gif" width="180" height="6"></td>
		</tr>
		</table>
	</div>

	<div id="screen">
	<table border="0" width="180" cellspacing="0" cellpadding="5">
	<tr>
		<td width="100%" bgcolor="#808080">
			<table border="0" width="100%" bgcolor="#808080" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100%">
					<table border="0" width="100%" cellspacing="1" cellpadding="5">
					<tr>
						<td width="100%" bgcolor="#FFFFFF">
							<font class="NavJump"><br></font>
							<font class="NavJump"><br></font>
							<font class="NavJump"><br></font>
							<font class="NavJump"><br></font>
							<font class="NavJump"><br></font>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</div>

	<div id="screenlinks">
	<table border="0" width="180" cellspacing="0" cellpadding="5">
	<tr>
		<td width="100%">
			<table border="0" width="100%" bgcolor="#808080" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100%">
					<table border="0" width="100%" cellspacing="1" cellpadding="5">
					<tr>
						<td width="100%" bgcolor="#FFFFFF">
							<a href="frame.php?link=www"    class="NavJump"><b>Web Servers</b></a><br>
							<a href="frame.php?link=base"   class="NavJump"><b>DataBase Servers</b></a><br>
							<a href="frame.php?link=mail"   class="NavJump"><b>Mail Servers</b></a><br>
							<a href="frame.php?link=ftp"    class="NavJump"><b>FTP Servers</b></a><br>
							<a href="frame.php?link=proxy"  class="NavJump"><b>Proxy Servers</b></a><br>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</div>
</div>
