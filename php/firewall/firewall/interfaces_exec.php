<?
        require("global.php");
        require("include/db.php");

        $db = new database;
        $db->connect();

		$str_sql = "SELECT id FROM interfaces WHERE des_if = '" . trim($des_if) . "'";
		$rs = $db->query($str_sql);
		
		if ( $db->count($rs) == 0 )
		{
			$str_sql  = "INSERT INTO interfaces (des_if, num_ip, num_mask, num_network, num_broadcast, num_gateway, ide_dhcp, ide_nat) ";
			$str_sql .= "VALUES ('" . trim($des_if) . "', '', '', '', '', '', 0, 0)";
			$db->query($str_sql);
		}
		$db->free($rs);
		
		if ( trim($des_if) != 'eth0' )
		{
			$ide_nat = 0;
			$ide_dhcp = 0;
			intval($ide_dhcp_serv)?$ide_dhcp_serv=1:$ide_dhcp_serv=0;			
		} else
		{
			intval($ide_dhcp)?$ide_dhcp=1:$ide_dhcp=0;
			intval($ide_nat)?$ide_nat=1:$ide_nat=0;
			$ide_dhcp_serv=0;
		}
		
		$str_sql  = "DELETE FROM nat WHERE ide_masq=1 ";
		$db->query($str_sql);

		if ( $ide_nat )
		{
			$str_sql = "UPDATE interfaces SET ide_nat=0";
			$db->query($str_sql);

			$ide_nat = 1;
			$des_chain = "POSTROUTING";
			$des_oif = "eth0";
			$des_acao = "MASQUERADE";
			$cmd_iptables  = "/usr/sbin/iptables -A $des_chain -t nat ";
			$cmd_iptables .= "-o $des_oif ";
			$cmd_iptables .= "-j $des_acao ";

			$tabela = "nat";
			$ordem = get_next_ord($tabela);
			
			$str_sql  = "INSERT INTO $tabela (des_chain, des_oif, des_acao, cmd_iptables, ordem, ide_masq) ";
			$str_sql .= "VALUES ('$des_chain', '$des_oif', '$des_acao', '$cmd_iptables', $ordem, 1)";
			$db->query($str_sql);
		}

        $str_sql  = "UPDATE interfaces SET ";
        $str_sql .= "	num_ip        = '$num_ip', ";
        $str_sql .= "	num_mask      = '$num_mask', ";
        $str_sql .= "	num_network   = '$num_net', ";
        $str_sql .= "	num_broadcast = '$num_broadcast', ";
        $str_sql .= "	num_gateway   = '$num_gateway', ";
        $str_sql .= "	ide_dhcp      = $ide_dhcp, ";
        $str_sql .= "	ide_nat       = $ide_nat, ";
        $str_sql .= "	ide_dhcp_serv = $ide_dhcp_serv ";
        $str_sql .= "WHERE des_if = '" . trim($des_if) . "'";
		$db->query($str_sql);


		$msg = "Interface alterada com sucesso.";

        $db->close();
		
		grava_firewall();
		grava_interfaces();
		grava_dhcp();
		
		restart_service("network");
		restart_service("dhcpd");
?>
<html>
	<head>
		<script>
			function redir()
			{
				alert('<?=$msg?>');
				document.form1.submit();
			}
			function contagem()
			{
				tempo = parseInt(document.form1.tempo.value);
				tempo--;
				if ( tempo == 0 )
				{
					redir();
				} else
				{
					document.form1.tempo.value=tempo;
					t = setTimeout("contagem()", 1000);
				}
			}
		</script>
	</head>
<? require("include/style.css") ?>	
<body bgcolor="#ffffff" onload="init(), contagem()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_int_config.gif" width="313" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form action="interfaces.php" name="form1" method="post">
	<input type="Hidden" name="des_if" value="<?=$des_if?>">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td align="center">Reiniciando interfaces de rede. Aguarde...</td>
				</tr>
				<tr>
					<td align="center">Faltando <input type="text" size="2" name="tempo" value="20" class="Text_noborder"> segundos para completar a tarefa.</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>