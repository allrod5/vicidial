<?
# manager_send.php
# 
# Copyright (C) 2007  Matt Florell <vicidial@gmail.com>    LICENSE: GPLv2
#
# This script is designed purely to insert records into the vicidial_manager table to signal Actions to an asterisk server
# This script depends on the server_ip being sent and also needs to have a valid user/pass from the vicidial_users table
# 
# required variables:
#  - $server_ip
#  - $session_name
#  - $user
#  - $pass
# optional variables:
#  - $ACTION - ('Originate','Redirect','Hangup','Command','Monitor','StopMonitor','SysCIDOriginate','RedirectName','RedirectNameVmail','MonitorConf','StopMonitorConf','RedirectXtra','RedirectXtraCX','RedirectVD','HangupConfDial','VolumeControl','OriginateVDRelogin')
#  - $queryCID - ('CN012345678901234567',...)
#  - $format - ('text','debug')
#  - $channel - ('Zap/41-1','SIP/test101-1jut','IAX2/iaxy@iaxy',...)
#  - $exten - ('1234','913125551212',...)
#  - $ext_context - ('default','demo',...)
#  - $ext_priority - ('1','2',...)
#  - $filename - ('20050406-125623_44444',...)
#  - $extenName - ('phone100',...)
#  - $parkedby - ('phone100',...)
#  - $extrachannel - ('Zap/41-1','SIP/test101-1jut','IAX2/iaxy@iaxy',...)
#  - $auto_dial_level - ('0','1','1.1',...)
#  - $campaign - ('CLOSER','TESTCAMP',...)
#  - $uniqueid - ('1120232758.2406800',...)
#  - $lead_id - ('1234',...)
#  - $seconds - ('32',...)
#  - $outbound_cid - ('3125551212','0000000000',...)
#  - $agent_log_id - ('123456',...)
#  - $call_server_ip - ('10.10.10.15',...)
#  - $CalLCID - ('VD01234567890123456',...)
#  - $stage - ('UP','DOWN')
# 

# CHANGELOG:
# 50401-1002 - First build of script, Hangup function only
# 50404-1045 - Redirect basic function enabled
# 50406-1522 - Monitor basic function enabled
# 50407-1647 - Monitor and StopMonitor full functions enabled
# 50422-1120 - basic Originate function enabled
# 50428-1451 - basic SysCIDOriginate function enabled for checking voicemail
# 50502-1539 - basic RedirectName and RedirectNameVmail added
# 50503-1227 - added session_name checking for extra security
# 50523-1341 - added Conference call start/stop recording
# 50523-1421 - added OriginateName and OriginateNameVmail for local calls
# 50524-1602 - added RedirectToPark and RedirectFromPark
# 50531-1203 - added RedirecXtra for dual channel redirection
# 50630-1100 - script changed to not use HTTP login vars, user/pass instead
# 50804-1148 - Added RedirectVD for VICIDIAL blind redirection with logging
# 50815-1204 - Added NEXTAVAILABLE to RedirectXtra function
# 50903-2343 - Added HangupConfDial function to hangup in-dial channels in conf
# 50913-1057 - Added outbound_cid set if present to originate call
# 51020-1556 - Added agent_log_id framework for detailed agent activity logging
# 51118-1204 - Fixed Blind transfer bug from VICIDIAL when in manual dial mode
# 51129-1014 - Added ability to accept calls from other VICIDIAL servers
# 51129-1253 - Fixed Hangups of other agents channels in VICIDIAL AD
# 60310-2022 - Fixed NEXTAVAILABLE bug in leave-3way-call redirect function
# 60421-1413 - check GET/POST vars lines with isset to not trigger PHP NOTICES
# 60619-1158 - Added variable filters to close security holes for login form
# 60809-1544 - Added direct transfers to leave-3ways in consultative transfers
# 61004-1526 - Added parsing of volume control command and lookup or number
# 61130-1617 - Added lead_id to MonitorConf for recording_log
# 61201-1115 - Added user to MonitorConf for recording_log
# 70111-1600 - added ability to use BLEND/INBND/*_C/*_B/*_I as closer campaigns
# 70226-1251 - Added Mute/UnMute to conference volume control
# 70320-1502 - Added option to allow retry of leave-3way-call and debug logging
# 70322-1636 - Added sipsak display ability
#

require("dbconnect.php");

### These are variable assignments for PHP globals off
if (isset($_GET["user"]))					{$user=$_GET["user"];}
	elseif (isset($_POST["user"]))			{$user=$_POST["user"];}
if (isset($_GET["pass"]))					{$pass=$_GET["pass"];}
	elseif (isset($_POST["pass"]))			{$pass=$_POST["pass"];}
if (isset($_GET["server_ip"]))				{$server_ip=$_GET["server_ip"];}
	elseif (isset($_POST["server_ip"]))		{$server_ip=$_POST["server_ip"];}
if (isset($_GET["session_name"]))			{$session_name=$_GET["session_name"];}
	elseif (isset($_POST["session_name"]))	{$session_name=$_POST["session_name"];}
if (isset($_GET["ACTION"]))					{$ACTION=$_GET["ACTION"];}
	elseif (isset($_POST["ACTION"]))		{$ACTION=$_POST["ACTION"];}
if (isset($_GET["queryCID"]))				{$queryCID=$_GET["queryCID"];}
	elseif (isset($_POST["queryCID"]))		{$queryCID=$_POST["queryCID"];}
if (isset($_GET["format"]))					{$format=$_GET["format"];}
	elseif (isset($_POST["format"]))		{$format=$_POST["format"];}
if (isset($_GET["channel"]))				{$channel=$_GET["channel"];}
	elseif (isset($_POST["channel"]))		{$channel=$_POST["channel"];}
if (isset($_GET["exten"]))					{$exten=$_GET["exten"];}
	elseif (isset($_POST["exten"]))			{$exten=$_POST["exten"];}
if (isset($_GET["ext_context"]))			{$ext_context=$_GET["ext_context"];}
	elseif (isset($_POST["ext_context"]))	{$ext_context=$_POST["ext_context"];}
if (isset($_GET["ext_priority"]))			{$ext_priority=$_GET["ext_priority"];}
	elseif (isset($_POST["ext_priority"]))	{$ext_priority=$_POST["ext_priority"];}
if (isset($_GET["filename"]))				{$filename=$_GET["filename"];}
	elseif (isset($_POST["filename"]))		{$filename=$_POST["filename"];}
if (isset($_GET["extenName"]))				{$extenName=$_GET["extenName"];}
	elseif (isset($_POST["extenName"]))		{$extenName=$_POST["extenName"];}
if (isset($_GET["parkedby"]))				{$parkedby=$_GET["parkedby"];}
	elseif (isset($_POST["parkedby"]))		{$parkedby=$_POST["parkedby"];}
if (isset($_GET["extrachannel"]))			{$extrachannel=$_GET["extrachannel"];}
	elseif (isset($_POST["extrachannel"]))	{$extrachannel=$_POST["extrachannel"];}
if (isset($_GET["auto_dial_level"]))			{$auto_dial_level=$_GET["auto_dial_level"];}
	elseif (isset($_POST["auto_dial_level"]))	{$auto_dial_level=$_POST["auto_dial_level"];}
if (isset($_GET["campaign"]))				{$campaign=$_GET["campaign"];}
	elseif (isset($_POST["campaign"]))		{$campaign=$_POST["campaign"];}
if (isset($_GET["uniqueid"]))				{$uniqueid=$_GET["uniqueid"];}
	elseif (isset($_POST["uniqueid"]))		{$uniqueid=$_POST["uniqueid"];}
if (isset($_GET["lead_id"]))				{$lead_id=$_GET["lead_id"];}
	elseif (isset($_POST["lead_id"]))		{$lead_id=$_POST["lead_id"];}
if (isset($_GET["secondS"]))				{$secondS=$_GET["secondS"];}
	elseif (isset($_POST["secondS"]))		{$secondS=$_POST["secondS"];}
if (isset($_GET["outbound_cid"]))			{$outbound_cid=$_GET["outbound_cid"];}
	elseif (isset($_POST["outbound_cid"]))	{$outbound_cid=$_POST["outbound_cid"];}
if (isset($_GET["agent_log_id"]))			{$agent_log_id=$_GET["agent_log_id"];}
	elseif (isset($_POST["agent_log_id"]))	{$agent_log_id=$_POST["agent_log_id"];}
if (isset($_GET["call_server_ip"]))				{$call_server_ip=$_GET["call_server_ip"];}
	elseif (isset($_POST["call_server_ip"]))	{$call_server_ip=$_POST["call_server_ip"];}
if (isset($_GET["CalLCID"]))				{$CalLCID=$_GET["CalLCID"];}
	elseif (isset($_POST["CalLCID"]))		{$CalLCID=$_POST["CalLCID"];}
if (isset($_GET["phone_code"]))				{$phone_code=$_GET["phone_code"];}
	elseif (isset($_POST["phone_code"]))	{$phone_code=$_POST["phone_code"];}
if (isset($_GET["phone_number"]))			{$phone_number=$_GET["phone_number"];}
	elseif (isset($_POST["phone_number"]))	{$phone_number=$_POST["phone_number"];}
if (isset($_GET["stage"]))					{$stage=$_GET["stage"];}
	elseif (isset($_POST["stage"]))			{$stage=$_POST["stage"];}
if (isset($_GET["extension"]))					{$extension=$_GET["extension"];}
	elseif (isset($_POST["extension"]))			{$extension=$_POST["extension"];}
if (isset($_GET["protocol"]))					{$protocol=$_GET["protocol"];}
	elseif (isset($_POST["protocol"]))			{$protocol=$_POST["protocol"];}
if (isset($_GET["phone_ip"]))				{$phone_ip=$_GET["phone_ip"];}
	elseif (isset($_POST["phone_ip"]))		{$phone_ip=$_POST["phone_ip"];}
if (isset($_GET["enable_sipsak_messages"]))				{$enable_sipsak_messages=$_GET["enable_sipsak_messages"];}
	elseif (isset($_POST["enable_sipsak_messages"]))	{$enable_sipsak_messages=$_POST["enable_sipsak_messages"];}
if (isset($_GET["allow_sipsak_messages"]))				{$allow_sipsak_messages=$_GET["allow_sipsak_messages"];}
	elseif (isset($_POST["allow_sipsak_messages"]))		{$allow_sipsak_messages=$_POST["allow_sipsak_messages"];}

$user=ereg_replace("[^0-9a-zA-Z]","",$user);
$pass=ereg_replace("[^0-9a-zA-Z]","",$pass);
$secondS = ereg_replace("[^0-9]","",$secondS);

# default optional vars if not set
if (!isset($ACTION))   {$ACTION="Originate";}
if (!isset($format))   {$format="alert";}
if (!isset($ext_priority))   {$ext_priority="1";}

$version = '2.0.29';
$build = '70320-1502';
$StarTtime = date("U");
$NOW_DATE = date("Y-m-d");
$NOW_TIME = date("Y-m-d H:i:s");
if (!isset($query_date)) {$query_date = $NOW_DATE;}

	$stmt="SELECT count(*) from vicidial_users where user='$user' and pass='$pass' and user_level > 0;";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_query($stmt, $link);
	$row=mysql_fetch_row($rslt);
	$auth=$row[0];

  if( (strlen($user)<2) or (strlen($pass)<2) or ($auth==0))
	{
    echo "Invalide Utilisateurname/Mot de passe: |$user|$pass|\n";
    exit;
	}
  else
	{

	if( (strlen($server_ip)<6) or (!isset($server_ip)) or ( (strlen($session_name)<12) or (!isset($session_name)) ) )
		{
		echo "Invalide server_ip: |$server_ip|  or  Invalide session_name: |$session_name|\n";
		exit;
		}
	else
		{
		$stmt="SELECT count(*) from web_client_sessions where session_name='$session_name' and server_ip='$server_ip';";
		if ($DB) {echo "|$stmt|\n";}
		$rslt=mysql_query($stmt, $link);
		$row=mysql_fetch_row($rslt);
		$SNauth=$row[0];
		  if($SNauth==0)
			{
			echo "Invalide session_name: |$session_name|$server_ip|\n";
			exit;
			}
		  else
			{
			# do nothing for now
			}
		}
	}

if ($format=='debug')
{
echo "<html>\n";
echo "<head>\n";
echo "<!-- VERSION: $version     BUILD: $build    ACTION: $ACTION   server_ip: $server_ip-->\n";
echo "<title>Envoi de l'Administrateur: ";
if ($ACTION=="Originate")		{echo "Originate";}
if ($ACTION=="Redirect")		{echo "Redirect";}
if ($ACTION=="RedirectName")	{echo "RedirectName";}
if ($ACTION=="Hangup")			{echo "Hangup";}
if ($ACTION=="Command")			{echo "Command";}
if ($ACTION==99999)	{echo "AIDE";}
echo "</title>\n";
echo "</head>\n";
echo "<BODY BGCOLOR=white marginheight=0 marginwidth=0 leftmargin=0 topmargin=0>\n";
}





######################
# ACTION=SysCIDOriginate  - insert Originate Manager statement allowing small CIDs for system calls
######################
if ($ACTION=="SysCIDOriginate")
{
	if ( (strlen($exten)<1) or (strlen($channel)<1) or (strlen($ext_context)<1) or (strlen($queryCID)<1) )
	{
		echo "Exten $exten est invalide or queryCID $queryCID est invalide, Originate commande non insérée\n";
	}
	else
	{
	$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Originate','$queryCID','Channel: $channel','Context: $ext_context','Exten: $exten','Priority: $ext_priority','Callerid: $queryCID','','','','','');";
		if ($format=='debug') {echo "\n<!-- $stmt -->";}
	$rslt=mysql_query($stmt, $link);
	echo "Originate commande envoyée pour Exten $exten Canal $channel sur $server_ip\n";
	}
}



######################
# ACTION=Originate, OriginateName, OriginateNameVmail  - insert Originate Manager statement
######################
if ($ACTION=="OriginateName")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15)  or (strlen($extenName)<1)  or (strlen($ext_context)<1)  or (strlen($ext_priority)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "extenName $extenName est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nOriginateName Action pas envoyé\n";
	}
	else
	{
		$stmt="SELECT dialplan_number FROM phones where server_ip = '$server_ip' and extension='$extenName';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$name_count = mysql_num_rows($rslt);
		if ($name_count>0)
		{
		$row=mysql_fetch_row($rslt);
		$exten = $row[0];
		$ACTION="Originate";
		}
	}
}

if ($ACTION=="OriginateNameVmail")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15)  or (strlen($extenName)<1)  or (strlen($exten)<1)  or (strlen($ext_context)<1)  or (strlen($ext_priority)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "extenName $extenName est obligatoire\n";
		echo "exten $exten est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nOriginateNameVmail Action pas envoyé\n";
	}
	else
	{
		$stmt="SELECT voicemail_id FROM phones where server_ip = '$server_ip' and extension='$extenName';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$name_count = mysql_num_rows($rslt);
		if ($name_count>0)
		{
		$row=mysql_fetch_row($rslt);
		$exten = "$exten$row[0]";
		$ACTION="Originate";
		}
	}
}

if ($ACTION=="OriginateVDRelogin")
{
	if ( ($enable_sipsak_messages > 0) and ($allow_sipsak_messages > 0) and (eregi("SIP",$protocol)) )
	{
	$CIDdate = date("ymdHis");
	$DS='-';
	$SIPSAK_prefix = 'LIN-';
	print "<!-- sending login sipsak message: $SIPSAK_prefix$VD_campaign -->\n";
	passthru("/usr/local/bin/sipsak -M -O desktop -B \"$SIPSAK_prefix$campaign\" -r 5060 -s sip:$extension@$phone_ip > /dev/null");
	$queryCID = "$SIPSAK_prefix$campaign$DS$CIDdate";

	}
	$ACTION="Originate";
}

if ($ACTION=="Originate")
{
	if ( (strlen($exten)<1) or (strlen($channel)<1) or (strlen($ext_context)<1) or (strlen($queryCID)<10) )
	{
		echo "Exten $exten est invalide or queryCID $queryCID est invalide, Originate commande non insérée\n";
	}
	else
	{
	if (strlen($outbound_cid)>1)
		{$outCID = "\"$queryCID\" <$outbound_cid>";}
	else
		{$outCID = "$queryCID";}
	$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Originate','$queryCID','Channel: $channel','Context: $ext_context','Exten: $exten','Priority: $ext_priority','Callerid: $outCID','','','','','');";
		if ($format=='debug') {echo "\n<!-- $stmt -->";}
	$rslt=mysql_query($stmt, $link);
	echo "Originate commande envoyée pour Exten $exten Canal $channel sur $server_ip\n";
	}
}



######################
# ACTION=HangupConfDial  - find the Local channel that is in the conference and needs to be hung up
######################
if ($ACTION=="HangupConfDial")
{
	$row='';   $rowx='';
	$channel_live=1;
	if ( (strlen($exten)<3) or (strlen($queryCID)<15) or (strlen($ext_context)<1) )
	{
		$channel_live=0;
		echo "conference $exten est invalide or ext_context $ext_context or queryCID $queryCID est invalide, Hangup commande non insérée\n";
	}
	else
	{
		$local_DEF = 'Local/';
		$local_AMP = '@';
		$hangup_channel_prefix = "$local_DEF$exten$local_AMP$ext_context";

		$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$server_ip' and channel LIKE \"$hangup_channel_prefix%\";";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$row=mysql_fetch_row($rslt);
		if ($row > 0)
		{
			$stmt="SELECT channel FROM live_sip_channels where server_ip = '$server_ip' and channel LIKE \"$hangup_channel_prefix%\";";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			$channel=$rowx[0];
			$ACTION="Hangup";
			$queryCID = eregi_replace("^.","G",$queryCID);
		}
	}
}



######################
# ACTION=Hangup  - insert Hangup Manager statement
######################
if ($ACTION=="Hangup")
{
	$row='';   $rowx='';
	$channel_live=1;
	if ( (strlen($channel)<3) or (strlen($queryCID)<15) )
	{
		$channel_live=0;
		echo "Canal $channel est invalide or queryCID $queryCID est invalide, Hangup commande non insérée\n";
	}
	else
	{
		if (strlen($call_server_ip)<7) {$call_server_ip = $server_ip;}

#		$stmt="SELECT count(*) FROM live_channels where server_ip = '$call_server_ip' and channel='$channel';";
#			if ($format=='debug') {echo "\n<!-- $stmt -->";}
#		$rslt=mysql_query($stmt, $link);
#		$row=mysql_fetch_row($rslt);
#		if ($row[0]==0)
#		{
#			$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$call_server_ip' and channel='$channel';";
#				if ($format=='debug') {echo "\n<!-- $stmt -->";}
#			$rslt=mysql_query($stmt, $link);
#			$rowx=mysql_fetch_row($rslt);
#			if ($rowx[0]==0)
#			{
#				$channel_live=0;
#				echo "Channel $channel is not live on $call_server_ip, Hangup command not inserted\n";
#			}	
#		}
		if ( ($auto_dial_level > 0) and (strlen($CalLCID)>2) and (strlen($exten)>2) and ($secondS > 4))
		{
			$stmt="SELECT count(*) FROM vicidial_auto_calls where channel='$channel' and callerid='$CalLCID';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			if ($rowx[0]==0)
			{
			echo "Call $CalLCID $channel n'est pas en ligne sur $call_server_ip, Checking Live Canal...\n";

				$stmt="SELECT count(*) FROM live_channels where server_ip = '$call_server_ip' and channel='$channel' and extension LIKE \"%$exten\";";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				$row=mysql_fetch_row($rslt);
				if ($row[0]==0)
				{
				$channel_live=0;
				echo "Canal $channel n'est pas en ligne sur $call_server_ip, Hangup commande non insérée $rowx[0]\n$stmt\n";
				}
				else
				{
				echo "$stmt\n";
				}
			}	
		}
		if ($channel_live==1)
		{
		$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$call_server_ip','','Hangup','$queryCID','Channel: $channel','','','','','','','','','');";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		echo "Hangup commande envoyée pour Canal $channel sur $call_server_ip\n";
		}
	}
}



######################
# ACTION=Redirect, RedirectName, RedirectNameVmail, RedirectToPark, RedirectFromPark, RedirectVD, RedirectXtra, RedirectXtraCX
# - insert Redirect Manager statement using extensions name
######################
if ($ACTION=="RedirectVD")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15) or (strlen($exten)<1) or (strlen($campaign)<1) or (strlen($ext_context)<1) or (strlen($ext_priority)<1) or (strlen($uniqueid)<2) or (strlen($lead_id)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "exten $exten est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "auto_dial_level $auto_dial_level est obligatoire\n";
		echo "campaign $campaign est obligatoire\n";
		echo "uniqueid $uniqueid est obligatoire\n";
		echo "lead_id $lead_id est obligatoire\n";
		echo "\nRedirectVD Action pas envoyé\n";
	}
	else
	{
		if (strlen($call_server_ip)>6) {$server_ip = $call_server_ip;}
			if (eregi("(CLOSER|BLEND|INBND|_C$|_B$|_I$)",$campaign))
				{
				$stmt = "UPDATE vicidial_closer_log set end_epoch='$StarTtime', length_in_sec='$secondS',status='XFER' where lead_id='$lead_id' order by start_epoch desc limit 1;";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				}
			if ($auto_dial_level < 1)
				{
				$stmt = "UPDATE vicidial_log set end_epoch='$StarTtime', length_in_sec='$secondS',status='XFER' where uniqueid='$uniqueid';";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				}
			else
				{
				$stmt = "DELETE from vicidial_auto_calls where uniqueid='$uniqueid';";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				}

		$ACTION="Redirect";
	}
}

if ($ACTION=="RedirectToPark")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15) or (strlen($exten)<1) or (strlen($extenName)<1) or (strlen($ext_context)<1) or (strlen($ext_priority)<1) or (strlen($parkedby)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "exten $exten est obligatoire\n";
		echo "extenName $extenName est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "parkedby $parkedby est obligatoire\n";
		echo "\nRedirectToPark Action pas envoyé\n";
	}
	else
	{
		if (strlen($call_server_ip)>6) {$server_ip = $call_server_ip;}
		$stmt = "INSERT INTO parked_channels values('$channel','$server_ip','','$extenName','$parkedby','$NOW_TIME');";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$ACTION="Redirect";
	}
}

if ($ACTION=="RedirectFromPark")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15) or (strlen($exten)<1) or (strlen($ext_context)<1) or (strlen($ext_priority)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "exten $exten est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nRedirectFromPark Action pas envoyé\n";
	}
	else
	{
		if (strlen($call_server_ip)>6) {$server_ip = $call_server_ip;}
		$stmt = "DELETE FROM parked_channels where server_ip='$server_ip' and channel='$channel';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$ACTION="Redirect";
	}
}

if ($ACTION=="RedirectName")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15)  or (strlen($extenName)<1)  or (strlen($ext_context)<1)  or (strlen($ext_priority)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "extenName $extenName est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nRedirectName Action pas envoyé\n";
	}
	else
	{
		$stmt="SELECT dialplan_number FROM phones where server_ip = '$server_ip' and extension='$extenName';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$name_count = mysql_num_rows($rslt);
		if ($name_count>0)
		{
		$row=mysql_fetch_row($rslt);
		$exten = $row[0];
		$ACTION="Redirect";
		}
	}
}

if ($ACTION=="RedirectNameVmail")
{
	if ( (strlen($channel)<3) or (strlen($queryCID)<15)  or (strlen($extenName)<1)  or (strlen($exten)<1)  or (strlen($ext_context)<1)  or (strlen($ext_priority)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "extenName $extenName est obligatoire\n";
		echo "exten $exten est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nRedirectNameVmail Action pas envoyé\n";
	}
	else
	{
		$stmt="SELECT voicemail_id FROM phones where server_ip = '$server_ip' and extension='$extenName';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$name_count = mysql_num_rows($rslt);
		if ($name_count>0)
		{
		$row=mysql_fetch_row($rslt);
		$exten = "$exten$row[0]";
		$ACTION="Redirect";
		}
	}
}

if ($ACTION=="RedirectXtraCX")
{
	$DBout='';
	$row='';   $rowx='';
	$channel_liveX=1;
	$channel_liveY=1;
	if ( (strlen($channel)<3) or (strlen($queryCID)<15) or (strlen($exten)<1) or (strlen($ext_context)<1) or (strlen($ext_priority)<1) or (strlen($extrachannel)<3) )
	{
		$channel_liveX=0;
		$channel_liveY=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "ExtraCanal $extrachannel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "exten $exten est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nRedirect Action pas envoyé\n";
		if (ereg("SECOND|FIRST|DEBUG",$filename))
			{
			if ($WeBRooTWritablE > 0)
				{
				$fp = fopen ("./vicidial_debug.txt", "a");
				fwrite ($fp, "$NOW_TIME|RDCXC|$filename|$user|$campaign|$channel|$extrachannel|$queryCID|$exten|$ext_context|ext_priority|\n");
				fclose($fp);
				}
			}
	}
	else
	{
		if (strlen($call_server_ip)<7) {$call_server_ip = $server_ip;}

		$stmt="SELECT count(*) FROM live_channels where server_ip = '$call_server_ip' and channel='$channel';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$row=mysql_fetch_row($rslt);
		if ($row[0]==0)
		{
			$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$call_server_ip' and channel='$channel';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			if ($rowx[0]==0)
			{
				$channel_liveX=0;
				echo "Canal $channel n'est pas en ligne sur $call_server_ip, Redirect commande non insérée\n";
				if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel n'est pas en ligne sur $call_server_ip";}
			}	
		}
		$stmt="SELECT count(*) FROM live_channels where server_ip = '$server_ip' and channel='$extrachannel';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$row=mysql_fetch_row($rslt);
		if ($row[0]==0)
		{
			$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$server_ip' and channel='$extrachannel';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			if ($rowx[0]==0)
			{
				$channel_liveY=0;
				echo "Canal $channel n'est pas en ligne sur $server_ip, Redirect commande non insérée\n";
				if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel n'est pas en ligne sur $server_ip";}
			}	
		}
		if ( ($channel_liveX==1) && ($channel_liveY==1) )
		{
			$stmt="SELECT count(*) FROM vicidial_live_agents where lead_id='$lead_id' and user!='$user';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			if ($rowx[0] < 1)
			{
				$channel_liveY=0;
				echo "No Local agent to send call to, Redirect commande non insérée\n";
				if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "No Local agent to send call to";}
			}	
			else
			{
				$stmt="SELECT server_ip,conf_exten,user FROM vicidial_live_agents where lead_id='$lead_id' and user!='$user';";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				$rowx=mysql_fetch_row($rslt);
				$dest_server_ip = $rowx[0];
				$dest_session_id = $rowx[1];
				$dest_user = $rowx[2];
				$S='*';

				$D_s_ip = explode('.', $dest_server_ip);
				if (strlen($D_s_ip[0])<2) {$D_s_ip[0] = "0$D_s_ip[0]";}
				if (strlen($D_s_ip[0])<3) {$D_s_ip[0] = "0$D_s_ip[0]";}
				if (strlen($D_s_ip[1])<2) {$D_s_ip[1] = "0$D_s_ip[1]";}
				if (strlen($D_s_ip[1])<3) {$D_s_ip[1] = "0$D_s_ip[1]";}
				if (strlen($D_s_ip[2])<2) {$D_s_ip[2] = "0$D_s_ip[2]";}
				if (strlen($D_s_ip[2])<3) {$D_s_ip[2] = "0$D_s_ip[2]";}
				if (strlen($D_s_ip[3])<2) {$D_s_ip[3] = "0$D_s_ip[3]";}
				if (strlen($D_s_ip[3])<3) {$D_s_ip[3] = "0$D_s_ip[3]";}
				$dest_dialstring = "$D_s_ip[0]$S$D_s_ip[1]$S$D_s_ip[2]$S$D_s_ip[3]$S$dest_session_id$S$lead_id$S$dest_user$S$phone_code$S$phone_number$S$campaign$S";

				$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$call_server_ip','','Redirect','$queryCID','Channel: $channel','Context: $ext_context','Exten: $dest_dialstring','Priority: $ext_priority','CallerID: $queryCID','','','','','');";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);

				$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Hangup','$queryCID','Channel: $extrachannel','','','','','','','','','');";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);

				echo "RedirectXtraCX commande envoyée pour Canal $channel sur $call_server_ip and \nHungup $extrachannel sur $server_ip\n";
				if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel sur $call_server_ip, Hungup $extrachannel sur $server_ip";}
			}
		}
		else
		{
			if ($channel_liveX==1)
			{$ACTION="Redirect";   $server_ip = $call_server_ip;}
			if ($channel_liveY==1)
			{$ACTION="Redirect";   $channel=$extrachannel;}
			if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "Changed to Redirect: $channel sur $server_ip";}
		}

	if (ereg("SECOND|FIRST|DEBUG",$filename))
		{
		if ($WeBRooTWritablE > 0)
			{
			$fp = fopen ("./vicidial_debug.txt", "a");
			fwrite ($fp, "$NOW_TIME|RDCXC|$filename|$user|$campaign|$DBout|\n");
			fclose($fp);
			}
		}

	}
}

if ($ACTION=="RedirectXtra")
{
	if ($channel=="$extrachannel")
	{$ACTION="Redirect";}
	else
	{
		$row='';   $rowx='';
		$channel_liveX=1;
		$channel_liveY=1;
		if ( (strlen($channel)<3) or (strlen($queryCID)<15) or (strlen($exten)<1) or (strlen($ext_context)<1) or (strlen($ext_priority)<1) or (strlen($extrachannel)<3) )
		{
			$channel_liveX=0;
			$channel_liveY=0;
			echo "Une de ces variables est invalide:\n";
			echo "Canal $channel doit avoir plus de 2 caractères \n";
			echo "ExtraCanal $extrachannel doit avoir plus de 2 caractères \n";
			echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
			echo "exten $exten est obligatoire\n";
			echo "ext_context $ext_context est obligatoire\n";
			echo "ext_priority $ext_priority est obligatoire\n";
			echo "\nRedirect Action pas envoyé\n";
			if (ereg("SECOND|FIRST|DEBUG",$filename))
				{
				if ($WeBRooTWritablE > 0)
					{
					$fp = fopen ("./vicidial_debug.txt", "a");
					fwrite ($fp, "$NOW_TIME|RDX|$filename|$user|$campaign|$$channel|$extrachannel|$queryCID|$exten|$ext_context|ext_priority|\n");
					fclose($fp);
					}
				}
		}
		else
		{
			if ($exten == "NEXTAVAILABLE")
			{
			$stmt="SELECT conf_exten FROM conferences where server_ip='$server_ip' and ((extension='') or (extension is null)) limit 1;";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$row=mysql_fetch_row($rslt);
				if (strlen($row[0]) > 3)
				{
				$stmt="UPDATE conferences set extension='$user' where server_ip='$server_ip' and conf_exten='$row[0]';";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				$exten = $row[0];
				}
				else
				{
				$channel_liveX=0;
				echo "Il n'y a pas de conférence disponible sur $server_ip, Redirect commande non insérée\n";
				if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "Il n'y a pas de conférence disponible sur $server_ip";}
				}
			}

		if (strlen($call_server_ip)<7) {$call_server_ip = $server_ip;}

			$stmt="SELECT count(*) FROM live_channels where server_ip = '$call_server_ip' and channel='$channel';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$row=mysql_fetch_row($rslt);
			if ( ($row[0]==0) && (!ereg("SECOND",$filename)) )
			{
				$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$call_server_ip' and channel='$channel';";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				$rowx=mysql_fetch_row($rslt);
				if ($rowx[0]==0)
				{
					$channel_liveX=0;
					echo "Canal $channel n'est pas en ligne sur $call_server_ip, Redirect commande non insérée\n";
					if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel n'est pas en ligne sur $call_server_ip";}
				}	
			}
			$stmt="SELECT count(*) FROM live_channels where server_ip = '$server_ip' and channel='$extrachannel';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$row=mysql_fetch_row($rslt);
			if ( ($row[0]==0) && (!ereg("SECOND",$filename)) )
			{
				$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$server_ip' and channel='$extrachannel';";
					if ($format=='debug') {echo "\n<!-- $stmt -->";}
				$rslt=mysql_query($stmt, $link);
				$rowx=mysql_fetch_row($rslt);
				if ($rowx[0]==0)
				{
					$channel_liveY=0;
					echo "Canal $channel n'est pas en ligne sur $server_ip, Redirect commande non insérée\n";
					if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel n'est pas en ligne sur $server_ip";}
				}	
			}
			if ( ($channel_liveX==1) && ($channel_liveY==1) )
			{
				if ( ($server_ip=="$call_server_ip") or (strlen($call_server_ip)<7) )
				{
					$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Redirect','$queryCID','Channel: $channel','ExtraChannel: $extrachannel','Context: $ext_context','Exten: $exten','Priority: $ext_priority','CallerID: $queryCID','','','','');";
						if ($format=='debug') {echo "\n<!-- $stmt -->";}
					$rslt=mysql_query($stmt, $link);

					echo "RedirectXtra commande envoyée pour Canal $channel and \nExtraCanal $extrachannel\n to $exten sur $server_ip\n";
					if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel and $extrachannel to $exten sur $server_ip";}
				}
				else
				{
					$S='*';
					$D_s_ip = explode('.', $server_ip);
					if (strlen($D_s_ip[0])<2) {$D_s_ip[0] = "0$D_s_ip[0]";}
					if (strlen($D_s_ip[0])<3) {$D_s_ip[0] = "0$D_s_ip[0]";}
					if (strlen($D_s_ip[1])<2) {$D_s_ip[1] = "0$D_s_ip[1]";}
					if (strlen($D_s_ip[1])<3) {$D_s_ip[1] = "0$D_s_ip[1]";}
					if (strlen($D_s_ip[2])<2) {$D_s_ip[2] = "0$D_s_ip[2]";}
					if (strlen($D_s_ip[2])<3) {$D_s_ip[2] = "0$D_s_ip[2]";}
					if (strlen($D_s_ip[3])<2) {$D_s_ip[3] = "0$D_s_ip[3]";}
					if (strlen($D_s_ip[3])<3) {$D_s_ip[3] = "0$D_s_ip[3]";}
					$dest_dialstring = "$D_s_ip[0]$S$D_s_ip[1]$S$D_s_ip[2]$S$D_s_ip[3]$S$exten";

					$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$call_server_ip','','Redirect','$queryCID','Channel: $channel','Context: $ext_context','Exten: $dest_dialstring','Priority: $ext_priority','CallerID: $queryCID','','','','','');";
						if ($format=='debug') {echo "\n<!-- $stmt -->";}
					$rslt=mysql_query($stmt, $link);

					$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Redirect','$queryCID','Channel: $extrachannel','Context: $ext_context','Exten: $exten','Priority: $ext_priority','CallerID: $queryCID','','','','','');";
						if ($format=='debug') {echo "\n<!-- $stmt -->";}
					$rslt=mysql_query($stmt, $link);

					echo "RedirectXtra commande envoyée pour Canal $channel sur $call_server_ip and \nExtraCanal $extrachannel\n to $exten sur $server_ip\n";
					if (ereg("SECOND|FIRST|DEBUG",$filename)) {$DBout .= "$channel/$call_server_ip and $extrachannel/$server_ip to $exten";}
				}
			}
			else
			{
				if ($channel_liveX==1)
				{$ACTION="Redirect";   $server_ip = $call_server_ip;}
				if ($channel_liveY==1)
				{$ACTION="Redirect";   $channel=$extrachannel;}

			}

		if (ereg("SECOND|FIRST|DEBUG",$filename))
			{
			if ($WeBRooTWritablE > 0)
				{
				$fp = fopen ("./vicidial_debug.txt", "a");
				fwrite ($fp, "$NOW_TIME|RDX|$filename|$user|$campaign|$DBout|\n");
				fclose($fp);
				}
			}

		}
	}
}


if ($ACTION=="Redirect")
{
	$row='';   $rowx='';
	$channel_live=1;
	if ( (strlen($channel)<3) or (strlen($queryCID)<15)  or (strlen($exten)<1)  or (strlen($ext_context)<1)  or (strlen($ext_priority)<1) )
	{
		$channel_live=0;
		echo "Une de ces variables est invalide:\n";
		echo "Canal $channel doit avoir plus de 2 caractères \n";
		echo "queryCID $queryCID doit avoir plus de 14 caractères \n";
		echo "exten $exten est obligatoire\n";
		echo "ext_context $ext_context est obligatoire\n";
		echo "ext_priority $ext_priority est obligatoire\n";
		echo "\nRedirect Action pas envoyé\n";
	}
	else
	{
		if (strlen($call_server_ip)>6) {$server_ip = $call_server_ip;}
		$stmt="SELECT count(*) FROM live_channels where server_ip = '$server_ip' and channel='$channel';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$row=mysql_fetch_row($rslt);
		if ($row[0]==0)
		{
			$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$server_ip' and channel='$channel';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			if ($rowx[0]==0)
			{
				$channel_live=0;
				echo "Canal $channel n'est pas en ligne sur $server_ip, Redirect commande non insérée\n";
			}	
		}
		if ($channel_live==1)
		{
		$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Redirect','$queryCID','Channel: $channel','Context: $ext_context','Exten: $exten','Priority: $ext_priority','CallerID: $queryCID','','','','','');";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);

		echo "Redirect commande envoyée pour Canal $channel sur $server_ip\n";
		}
	}
}



######################
# ACTION=Monitor or Stop Monitor  - insert Monitor/StopMonitor Manager statement to start recording on a channel
######################
if ( ($ACTION=="Monitor") || ($ACTION=="StopMonitor") )
{
	if ($ACTION=="StopMonitor")
		{$SQLfile = "";}
	else
		{$SQLfile = "File: $filename";}

	$row='';   $rowx='';
	$channel_live=1;
	if ( (strlen($channel)<3) or (strlen($queryCID)<15) or (strlen($filename)<15) )
	{
		$channel_live=0;
		echo "Canal $channel est invalide or queryCID $queryCID est invalide or filename: $filename est invalide, $ACTION commande non insérée\n";
	}
	else
	{
		$stmt="SELECT count(*) FROM live_channels where server_ip = '$server_ip' and channel='$channel';";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
		$row=mysql_fetch_row($rslt);
		if ($row[0]==0)
		{
			$stmt="SELECT count(*) FROM live_sip_channels where server_ip = '$server_ip' and channel='$channel';";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$rowx=mysql_fetch_row($rslt);
			if ($rowx[0]==0)
			{
				$channel_live=0;
				echo "Canal $channel n'est pas en ligne sur $server_ip, $ACTION commande non insérée\n";
			}	
		}
		if ($channel_live==1)
		{
		$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','$ACTION','$queryCID','Channel: $channel','$SQLfile','','','','','','','','');";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);

		if ($ACTION=="Monitor")
			{
			$stmt = "INSERT INTO recording_log (channel,server_ip,extension,start_time,start_epoch,filename,lead_id,user) values('$channel','$server_ip','$exten','$NOW_TIME','$StarTtime','$filename','$lead_id','$user')";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);

			$stmt="SELECT recording_id FROM recording_log where filename='$filename'";
			$rslt=mysql_query($stmt, $link);
			if ($DB) {echo "$stmt\n";}
			$row=mysql_fetch_row($rslt);
			$recording_id = $row[0];
			}
		else
			{
			$stmt="SELECT recording_id,start_epoch FROM recording_log where filename='$filename'";
			$rslt=mysql_query($stmt, $link);
			if ($DB) {echo "$stmt\n";}
			$rec_count = mysql_num_rows($rslt);
				if ($rec_count>0)
				{
				$row=mysql_fetch_row($rslt);
				$recording_id = $row[0];
				$start_time = $row[1];
				$length_in_sec = ($StarTtime - $start_time);
				$length_in_min = ($length_in_sec / 60);
				$length_in_min = sprintf("%8.2f", $length_in_min);

				$stmt = "UPDATE recording_log set end_time='$NOW_TIME',end_epoch='$StarTtime',length_in_sec=$length_in_sec,length_in_min='$length_in_min' where filename='$filename'";
					if ($DB) {echo "$stmt\n";}
				$rslt=mysql_query($stmt, $link);
				}

			}
		echo "$ACTION commande envoyée pour Canal $channel sur $server_ip\nFilename: $filename\nRecorDing_ID: $recording_id\n";
		}
	}
}






######################
# ACTION=MonitorConf or StopMonitorConf  - insert Monitor/StopMonitor Manager statement to start recording on a conference
######################
if ( ($ACTION=="MonitorConf") || ($ACTION=="StopMonitorConf") )
{
	$row='';   $rowx='';
	$channel_live=1;
	if ( (strlen($exten)<3) or (strlen($channel)<4) or (strlen($filename)<15) )
	{
		$channel_live=0;
		echo "Canal $channel est invalide or exten $exten est invalide or filename: $filename est invalide, $ACTION commande non insérée\n";
	}
	else
	{

	if ($ACTION=="MonitorConf")
		{
		$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Originate','$filename','Channel: $channel','Context: $ext_context','Exten: $exten','Priority: $ext_priority','Callerid: $filename','','','','','');";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);

		$stmt = "INSERT INTO recording_log (channel,server_ip,extension,start_time,start_epoch,filename,lead_id,user) values('$channel','$server_ip','$exten','$NOW_TIME','$StarTtime','$filename','$lead_id','$user')";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);

		$stmt="SELECT recording_id FROM recording_log where filename='$filename'";
		$rslt=mysql_query($stmt, $link);
		if ($DB) {echo "$stmt\n";}
		$row=mysql_fetch_row($rslt);
		$recording_id = $row[0];
		}
	else
		{
		$stmt="SELECT recording_id,start_epoch FROM recording_log where filename='$filename'";
		$rslt=mysql_query($stmt, $link);
		if ($DB) {echo "$stmt\n";}
		$rec_count = mysql_num_rows($rslt);
			if ($rec_count>0)
			{
			$row=mysql_fetch_row($rslt);
			$recording_id = $row[0];
			$start_time = $row[1];
			$length_in_sec = ($StarTtime - $start_time);
			$length_in_min = ($length_in_sec / 60);
			$length_in_min = sprintf("%8.2f", $length_in_min);

			$stmt = "UPDATE recording_log set end_time='$NOW_TIME',end_epoch='$StarTtime',length_in_sec=$length_in_sec,length_in_min='$length_in_min' where filename='$filename'";
				if ($DB) {echo "$stmt\n";}
			$rslt=mysql_query($stmt, $link);
			}

		# find and hang up all recordings going sur in this conference # and extension = '$exten' 
		$stmt="SELECT channel FROM live_sip_channels where server_ip = '$server_ip' and channel LIKE \"$channel%\" and channel LIKE \"%,1\";";
			if ($format=='debug') {echo "\n<!-- $stmt -->";}
		$rslt=mysql_query($stmt, $link);
	#	$rec_count = intval(mysql_num_rows($rslt) / 2);
		$rec_count = mysql_num_rows($rslt);
		$h=0;
			while ($rec_count>$h)
			{
			$rowx=mysql_fetch_row($rslt);
			$HUchannel[$h] = $rowx[0];
			$h++;
			}
		$i=0;
			while ($h>$i)
			{
			$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Hangup','RH12345$StarTtime$i','Channel: $HUchannel[$i]','','','','','','','','','');";
				if ($format=='debug') {echo "\n<!-- $stmt -->";}
			$rslt=mysql_query($stmt, $link);
			$i++;
			}

		}
		echo "$ACTION commande envoyée pour Canal $channel sur $server_ip\nFilename: $filename\nRecorDing_ID: $recording_id\n L'ENREGISTREMENT DURERA AU MAXIMUM 60 MINUTES\n";
	}
}





######################
# ACTION=VolumeControl  - raise or lower the volume of a meetme participant
######################
if ($ACTION=="VolumeControl")
{
	if ( (strlen($exten)<1) or (strlen($channel)<1) or (strlen($stage)<1) or (strlen($queryCID)<1) )
	{
		echo "Conférence $exten, Stage $stage est invalide or queryCID $queryCID est invalide, Originate commande non insérée\n";
	}
	else
	{
	$participant_number='XXYYXXYYXXYYXX';
	if (eregi('UP',$stage)) {$vol_prefix='4';}
	if (eregi('DOWN',$stage)) {$vol_prefix='3';}
	if (eregi('UNMUTE',$stage)) {$vol_prefix='2';}
	if (eregi('MUTING',$stage)) {$vol_prefix='1';}
	$local_DEF = 'Local/';
	$local_AMP = '@';
	$volume_local_channel = "$local_DEF$participant_number$vol_prefix$exten$local_AMP$ext_context";

	$stmt="INSERT INTO vicidial_manager values('','','$NOW_TIME','NEW','N','$server_ip','','Originate','$queryCID','Channel: $volume_local_channel','Context: $ext_context','Exten: 8300','Priority: 1','Callerid: $queryCID','','','','$channel','$exten');";
		if ($format=='debug') {echo "\n<!-- $stmt -->";}
	$rslt=mysql_query($stmt, $link);
	echo "Volume commande envoyée pour Conférence $exten, Stage $stage Canal $channel sur $server_ip\n";
	}
}












$ENDtime = date("U");
$RUNtime = ($ENDtime - $StarTtime);
if ($format=='debug') {echo "\n<!-- durée d'exécution du script: $RUNtime secondes -->";}
if ($format=='debug') {echo "\n</body>\n</html>\n";}
	
exit; 

?>





