<?
	require("global.php");
	require("include/db.php");
	require("include/style.css");
?>
<html>
<head>
<?
	$db = new database;
	$db->connect();
	
	$str_sql = "SELECT * FROM interfaces WHERE des_if='$des_if'";
	$rs = $db->query($str_sql);

	if ( $dados = $db->read($rs) )
	{
		$num_ip        = trim($dados["num_ip"]);
		$num_mask      = trim($dados["num_mask"]);
		$num_network   = trim($dados["num_network"]);
		$num_broadcast = trim($dados["num_broadcast"]);
		$num_gateway   = trim($dados["num_gateway"]);
		$ide_dhcp      = intval($dados["ide_dhcp"]);
		$ide_nat       = intval($dados["ide_nat"]);
		$ide_dhcp_serv      = intval($dados["ide_dhcp_serv"]);
	}
?>
	<title></title>
	<script language="javascript" src="include/funcoes.js"></script>
	<script language="JavaScript">

		function check_form(form)
		{
			ip = form.oct1.value + "." + form.oct2.value + "." + form.oct3.value + "." + form.oct4.value;
			mask = form.mask1.value + "." + form.mask2.value + "." + form.mask3.value + "." + form.mask4.value;
			net = form.net1.value + "." + form.net2.value + "." + form.net3.value + "." + form.net4.value;
			cast = form.cast1.value + "." + form.cast2.value + "." + form.cast3.value + "." + form.cast4.value;
			gate = form.gate1.value + "." + form.gate2.value + "." + form.gate3.value + "." + form.gate4.value;
			form.num_ip.value = ip;
			form.num_mask.value = mask;			
			form.num_net.value = net;
			form.num_broadcast.value = cast;
			form.num_gateway.value = gate;
<?
	if ( $des_if == "etho" )
	{
?>
			if ( ! form.ide_dhcp.checked )
			{
<?
	}
?>
				if ( ! is_ip(ip) ) 
					{
						alert('Número de IP inválido.');
						form.oct1.focus();
						return(false);
					}
				if ( ! is_ip(mask) ) 
					{
						alert('Número de Máscara de sub-rede inválido.');
						form.mask1.focus();
						return(false);
					}
				if ( ! is_ip(net) ) 
					{
						alert('Número da Rede inválido.');
						form.net1.focus();
						return(false);
					}
				if ( ! is_ip(cast) ) 
					{
						alert('Número de BroadCast inválido.');
						form.cast1.focus();
						return(false);
					}
				if ( (trim(gate) != "...") && (! is_ip(gate)) ) 
					{
						alert('Número de Gateway inválido.');
						form.gate1.focus();
						return(false);
					}
<?
	if ( $des_if == "etho" )
	{
?>
			}
<?
	}
?>
		}

		function next(atual, proximo)
		{
			form_name = atual.form.name;
			size = atual.value.length;
			muda = false;
			if ( atual.value.substr(size - 1, size) == "." )
			{
				atual.value = atual.value.substr(0, size - 1);
				muda = true;
			}
		    eval('proximo=document.' + form_name + '.' + proximo);
			calc_net(atual.form);
			if ( (atual.value.length > 2) || (muda) )
			{
				proximo.focus();
				if ( proximo.value.length > 0 )
				{
					proximo.select();
				}
			}
		}

		function calc_net(form)
		{
			ip = form.oct1.value + "." + form.oct2.value + "." + form.oct3.value + "." + form.oct4.value;
			mask = form.mask1.value + "." + form.mask2.value + "." + form.mask3.value + "." + form.mask4.value;
			if ( is_ip(ip) && is_ip(mask) )
			{
				get_network(form);
			}
		}
		
		function rearm(form)
		{
			ip   = form.oct1.value + "." + form.oct2.value + "." + form.oct3.value + "." + form.oct4.value;
			mask = form.mask1.value + "." + form.mask2.value + "." + form.mask3.value + "." + form.mask4.value;
			net  = form.net1.value + "." + form.net2.value + "." + form.net3.value + "." + form.net4.value;
			cast = form.cast1.value + "." + form.cast2.value + "." + form.cast3.value + "." + form.cast4.value;
			form.num_ip.value = ip;
			form.num_mask.value = mask;			
			form.num_net.value = net;
			form.num_broadcast.value = cast;
			calc_net(form);
		}
		
		function fill()
		{
			form = document.ifs_form;
		
			intf = form.des_if.value;
			
			ip = form.num_ip.value.split('.');
			for ( idx= 0; idx <=3; idx ++ )
			{
				if ( idx > (ip.length-1) ) ip[idx]='';
				eval('form.oct' + (idx+1) + '.value="' + ip[idx] + '"');
			}
			mask = form.num_mask.value.split('.');
			for ( idx= 0; idx <=3; idx ++ )
			{
				if ( idx > (mask.length-1) ) mask[idx]='';
				eval('form.mask' + (idx+1) + '.value="' + mask[idx] + '"');
			}
			net = form.num_net.value.split('.');
			for ( idx= 0; idx <=3; idx ++ )
			{
				if ( idx > (net.length-1) ) net[idx]='';
				eval('form.net' + (idx+1) + '.value="' + net[idx] + '"');
			}
			cast = form.num_broadcast.value.split('.');
			for ( idx= 0; idx <=3; idx ++ )
			{
				if ( idx > (cast.length-1) ) cast[idx]='';
				eval('form.cast' + (idx+1) + '.value="' + cast[idx] + '"');
			}
			gate = form.num_gateway.value.split('.');
			for ( idx= 0; idx <=3; idx ++ )
			{
				if ( idx > (gate.length-1) ) gate[idx]='';
				eval('form.gate' + (idx+1) + '.value="' + gate[idx] + '"');
			}
<?
	if ( $des_if == "eth0" )
	{
?>
			form.ide_dhcp.checked = <?=$ide_dhcp?>;
			dhcp(form);
<?
	}
?>			
		}

		function dhcp(form)
		{
			if ( form.ide_dhcp.checked )
			{
				form.oct1.disabled = true;
				form.oct2.disabled = true;
				form.oct3.disabled = true;
				form.oct4.disabled = true;

				form.mask1.disabled = true;
				form.mask2.disabled = true;
				form.mask3.disabled = true;
				form.mask4.disabled = true;

				form.net1.disabled = true;
				form.net2.disabled = true;
				form.net3.disabled = true;
				form.net4.disabled = true;

				form.cast1.disabled = true;
				form.cast2.disabled = true;
				form.cast3.disabled = true;
				form.cast4.disabled = true;

				form.gate1.disabled = true;
				form.gate2.disabled = true;
				form.gate3.disabled = true;
				form.gate4.disabled = true;
			}
		}
	</script>
</head>
<body bgcolor="#ffffff" onload="init(), fill()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_int_config.gif" width="313" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>

<form name="ifs_form" action="interfaces_exec.php" method="post" onsubmit="return check_form(this)">
<input type="hidden" name="id" value=0>
<input type="hidden" name="des_if"        value="<?=$des_if?>">
<input type="hidden" name="num_ip"        value="<?=$num_ip?>">
<input type="hidden" name="num_mask"      value="<?=$num_mask?>">
<input type="hidden" name="num_net"       value="<?=$num_network?>">
<input type="hidden" name="num_broadcast" value="<?=$num_broadcast?>">
<input type="hidden" name="num_gateway"   value="<?=$num_gateway?>">

<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
<? if ( trim($des_if) == "eth0" )
   {?>
				<tr>
					<td colspan="3"><input type="Checkbox" name="ide_dhcp" value=1 checked onclick="dhcp(this.form)">&nbsp;Utilizar configuração automática de IP (DHCP)</td>
				</tr>
				<tr>
					<td colspan="3"><input type="Checkbox" name="ide_nat" value=1 checked>&nbsp;Efetuar NAT nesta interface</td>
				</tr>
<? } else
   {
   		$ck = "";
		if ( intval($ide_dhcp_serv) ) $ck = "checked";
?>
				<tr>
					<td colspan="3"><input type="Checkbox" name="ide_dhcp_serv" value=1 <?=$ck?>>&nbsp;Habilitar o servidor DHCP para esta rede</td>
				</tr>
<? } ?>
				<tr>
					<td colspan="3">IP:</td>
				</tr>
				<tr>
					<td colspan="3"><img src="images/space.gif" width="30" height="1" border=0>
						<input type="text" onblur="rearm(this.form)" class="Text" name="oct1" value="" size="3" maxlength="3" onkeyup="next(this, 'oct2')">
						<input type="text" onblur="rearm(this.form)" class="Text" name="oct2" value="" size="3" maxlength="3" onkeyup="next(this, 'oct3')">
						<input type="text" onblur="rearm(this.form)" class="Text" name="oct3" value="" size="3" maxlength="3" onkeyup="next(this, 'oct4')">
						<input type="text" onblur="rearm(this.form)" class="Text" name="oct4" value="" size="3" maxlength="3" onkeyup="rearm(this.form)">
					</td>
				</tr>
				<tr>
					<td colspan="3">Máscara de Sub-rede:</td>
				</tr>
				<tr>
					<td colspan="3"><img src="images/space.gif" width="30" height="1" border=0>
						<input type="text" onblur="rearm(this.form)" class="Text"  name="mask1" value="" size="3" maxlength="3" onkeyup="next(this, 'mask2')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="mask2" value="" size="3" maxlength="3" onkeyup="next(this, 'mask3')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="mask3" value="" size="3" maxlength="3" onkeyup="next(this, 'mask4')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="mask4" value="" size="3" maxlength="3" onkeyup="rearm(this.form)">
					</td>
				</tr>
				<tr>
					<td colspan="3">Rede:</td>
				</tr>
				<tr>
					<td colspan="3"><img src="images/space.gif" width="30" height="1" border=0>
						<input type="text" onblur="rearm(this.form)" class="Text"  name="net1" value="" size="3" maxlength="3" onkeyup="next(this, 'net2')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="net2" value="" size="3" maxlength="3" onkeyup="next(this, 'net3')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="net3" value="" size="3" maxlength="3" onkeyup="next(this, 'net4')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="net4" value="" size="3" maxlength="3">
					</td>
				</tr>
				<tr>
					<td colspan="3">Broadcast:</td>
				</tr>
				<tr>
					<td colspan="3"><img src="images/space.gif" width="30" height="1" border=0>
						<input type="text" onblur="rearm(this.form)" class="Text"  name="cast1" value="" size="3" maxlength="3" onkeyup="next(this, 'cast2')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="cast2" value="" size="3" maxlength="3" onkeyup="next(this, 'cast3')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="cast3" value="" size="3" maxlength="3" onkeyup="next(this, 'cast4')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="cast4" value="" size="3" maxlength="3">
					</td>
				</tr>
				<tr>
					<td colspan="3">Gateway:</td>
				</tr>
				<tr>
					<td colspan="3"><img src="images/space.gif" width="30" height="1" border=0>
						<input type="text" onblur="rearm(this.form)" class="Text"  name="gate1" value="" size="3" maxlength="3" onkeyup="next(this, 'gate2')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="gate2" value="" size="3" maxlength="3" onkeyup="next(this, 'gate3')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="gate3" value="" size="3" maxlength="3" onkeyup="next(this, 'gate4')">
						<input type="text" onblur="rearm(this.form)" class="Text"  name="gate4" value="" size="3" maxlength="3">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><input class="Submit" type="submit" name="acao" value="Aplicar alterações"></td>
	</tr>
</table>
</form>
</body>
</html>