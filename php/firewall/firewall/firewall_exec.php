<?
        require("global.php");
        require("include/db.php");

        $db = new database;
        $db->connect();
		
        intval($ide_ipin)?$ide_ipin=1:$ide_ipin=0;
        intval($ide_portin)?$ide_portin=1:$ide_portin=0;
        intval($num_portin)?$num_portin=intval($num_portin):$num_portin=0;
        intval($ide_iif)?$ide_iif=1:$ide_iif=0;
        intval($ide_protocolo)?$ide_protocolo=1:$ide_protocolo=0;
        intval($ide_oif)?$ide_oif=1:$ide_oif=0;
        intval($ide_ipout)?$ide_ipout=1:$ide_ipout=0;
        intval($ide_portout)?$ide_portout=1:$ide_portout=0;
        intval($num_portout)?$num_portout=intval($num_portout):$num_portout=0;
        intval($ide_log)?$ide_log=1:$ide_log=0;
        intval($num_maskin)?$num_maskin=intval($num_maskin):$num_maskin=0;
        intval($num_maskout)?$num_maskout=intval($num_maskout):$num_maskout=0;

		
		$ide_nat = 0;
		
		if ( trim($tipo) == "simple" )
		{
			$des_chain = "INPUT";
			if ( $num_portin || $num_portout )
			{
				$des_protocolo = "TCP";
			}
		}
		if ( trim($num_ipin) == "..." ) 
		{
			$num_ipin="";
		}
		if ( trim($num_ipout) == "..." ) 
		{
			$num_ipout="";
		}
		
        $cmd_iptables = "/usr/sbin/iptables ";

		if ( (trim($des_acao) != "ACCEPT") && (trim($des_acao) != "DROP") && (trim($des_acao) != "LOG") )
		{
				$cmd_iptables .= "-t nat ";
				$ide_nat = 1;
		}
        if ( strlen(trim($des_chain)) > 0 )
        {
                $cmd_iptables .= "-A $des_chain ";
        }
        if ( strlen(trim($des_protocolo)) > 0 )
        {
                $cmd_iptables .= "-p ";
        	if ( $ide_protocolo )
        	{
             	   $cmd_iptables .= "! ";
        	}
                $cmd_iptables .= strtolower("$des_protocolo ");
        }
        if ( count($des_estado) > 0 )
        {
                $temp="";
                $cmd_iptables .= "-m state --state ";
                for ( $i=0; $i < count($des_estado); $i++ )
                {
                        $cmd_iptables .= "$des_estado[$i]";
                        $temp         .= "$des_estado[$i]";
                        if ( ($i+1) < count($des_estado) )
                        {
                                $cmd_iptables .= ",";
                                $temp .= ",";
                        }
                }
                $des_estado = $temp;
                unset($temp);
                $cmd_iptables .= " ";
        }
        if ( strlen(trim($num_ipin)) > 0 )
        {
                $cmd_iptables .= "-s ";
        	if ( $ide_ipin )
        	{
             	   $cmd_iptables .= "! ";
        	}
                $cmd_iptables .= "$num_ipin";
                if ( strlen(trim($num_maskin)) > 0 )
                {
                        $cmd_iptables .= "/$num_maskin";
                }
                $cmd_iptables .= " ";
        }
        if ( $num_portin )
        {
                $cmd_iptables .= "--sport ";
        	if ( $ide_portin )
        	{
             	   $cmd_iptables .= "! ";
        	}
                $cmd_iptables .= "$num_portin ";
        }
        if ( strlen(trim($des_iif)) > 0 )
        {
                $cmd_iptables .= "-i ";
                if ( $ide_iif )
                {
                   $cmd_iptables .= "! ";
                }
                $cmd_iptables .= "$des_iif ";
        }
        if ( strlen(trim($des_oif)) > 0 )
        {
                $cmd_iptables .= "-o ";
                if ( $ide_oif )
                {
                   $cmd_iptables .= "! ";
                }
                $cmd_iptables .= "$des_oif ";
        }
        if ( strlen(trim($num_ipout)) > 0 )
        {
                $cmd_iptables .= "-d ";
        	if ( $ide_ipout )
        	{
             	   $cmd_iptables .= "! ";
        	}
                $cmd_iptables .= "$num_ipout";
                if ( strlen(trim($num_maskout)) > 0 )
                {
                        $cmd_iptables .= "/$num_maskout";
                }
                $cmd_iptables .= " ";
        }
        if ( $num_portout )
        {
                $cmd_iptables .= "--dport ";
        	if ( $ide_portout )
        	{
             	   $cmd_iptables .= "! ";
        	}
                $cmd_iptables .= "$num_portout ";
        }
        $cmd_iptables .= "-j $des_acao";

		unset($action);
		
		if ( strtolower($acao) == "redirecionar" )
		{
			$ide_nat = 1;
			$num_ipin = trim($nat_ipin);
			$num_ipout = trim($nat_ipout);
			intval($nat_portin)?$num_portin=intval($nat_portin):$num_portin=0;
			intval($nat_portout)?$num_portout=intval($nat_portout):$num_portout=0;
			$des_chain = "PREROUTING";
			
			$cmd_iptables  = "/usr/sbin/iptables -t nat -A $des_chain ";
			$cmd_iptables .= "-d $num_ipin ";
			if ( (strlen(trim($nat_portin)) > 0) || (strlen(trim($nat_portout)) > 0) )
			{
				$des_protocolo = "tcp";
				$cmd_iptables .= "-p $des_protocolo ";
			}
			if ( strlen(trim($nat_portin)) > 0 )
			{
				$cmd_iptables .= "--dport $num_portin ";
			}
			if ( strlen(trim($nat_portout)) > 0 )
			{
				$des_acao = "REDIRECT";
				$cmd_iptables .= "-j $des_acao ";
				$cmd_iptables .= "--to $num_ipout ";
 				$cmd_iptables .= "--to-port $num_portout";
			} else
			{
				$des_acao = "DNAT";
				$cmd_iptables .= "-j $des_acao ";
				$cmd_iptables .= "--to $num_ipout ";
			}
			$acao = "inserir";
			$action = "firewall_nat.php";
		}

		if ( strtolower($acao) == "bloquear site" )
		{
			$ide_nat = 0;
			$des_url = trim($des_url);

			$tabela = "ctr_pais";
			$cmd_iptables  = "/usr/sbin/iptables -t nat -A OUTPUT -p tcp ";
			$cmd_iptables .= "-d $des_url -j DNAT --to 127.0.0.1:92";

			$ordem = get_next_ord("ctr_pais");
			$str_sql  = "INSERT INTO $tabela (des_url, cmd_iptables, ordem) ";
			$str_sql .= "VALUES ('$des_url', '$cmd_iptables', $ordem)";
			$db->query($str_sql);
			$msg = "Site bloqueado com sucesso";
			$action = "firewall_pais.php";
		}

        if ( strtolower($acao) == "excluir" )
        {
				$str_sql = "SELECT id, ordem FROM $tabela WHERE ordem > (SELECT ordem FROM $tabela WHERE id=" . trim($id) . ") ORDER BY ordem";				
				$rs = $db->query($str_sql);

                $str_sql = "DELETE FROM $tabela WHERE id=" . trim($id);
				$db->query($str_sql);

				while ( $dados = $db->read($rs) )
				{
					$str_sql = "UPDATE $tabela SET ordem=" . (intval($dados["ordem"])-1) . " WHERE id=" . $dados["id"];
					$db->query($str_sql);
				}
				if ( $tabela == "nat" )
				{
					$msg = "NAT excluída com sucesso.";
					$action = "firewall_nat.php";
				} else if ( $tabela == "ctr_pais" )
				{
					$msg = "Bloqueio de site excluído com sucesso.";
					$action = "firewall_pais.php";
				} else
				{
					$msg = "Regra excluída com sucesso.";
					$action = "firewall_main.php";
				}
        }

        if ( strtolower($acao) == "inserir" )
        {
				if ( $ide_nat )
				{
					$tabela = "nat";
	                $ordem = get_next_ord($tabela);
	                $str_sql  = "INSERT INTO $tabela ";
	                $str_sql .= "(ide_ipin, num_ipin, num_maskin, ide_portin, num_portin,";
	                $str_sql .= " ide_ipout, num_ipout, num_maskout, ide_portout, num_portout,";
	                $str_sql .= " ide_iif, des_iif, ide_oif, des_oif,";
	                $str_sql .= " des_chain, ide_protocolo, des_protocolo, des_acao, cmd_iptables, ordem) ";
	                $str_sql .= "VALUES ";
	                $str_sql .= "($ide_ipin, '$num_ipin', $num_maskin, $ide_portin, $num_portin,";
	                $str_sql .= " $ide_ipout, '$num_ipout', $num_maskout, $ide_portout, $num_portout,";
	                $str_sql .= " $ide_iif, '$des_iif', $ide_oif, '$des_oif',";
	                $str_sql .= " '$des_chain', $ide_protocolo, '$des_protocolo', '$des_acao', '$cmd_iptables', $ordem) ";
				} else
				{
					$tabela = "regras";
                    $ordem = get_next_ord($tabela);
				    $str_sql  = "INSERT INTO $tabela ";
	                $str_sql .= "(ide_ipin, num_ipin, num_maskin, ide_portin, num_portin,";
	                $str_sql .= " ide_ipout, num_ipout, num_maskout, ide_portout, num_portout,";
	                $str_sql .= " ide_iif, des_iif, ide_oif, des_oif,";
	                $str_sql .= " des_chain, ide_protocolo, des_protocolo, des_estado, des_acao, ide_log, cmd_iptables, ordem) ";
	                $str_sql .= "VALUES ";
	                $str_sql .= "($ide_ipin, '$num_ipin', $num_maskin, $ide_portin, $num_portin,";
	                $str_sql .= " $ide_ipout, '$num_ipout', $num_maskout, $ide_portout, $num_portout,";
	                $str_sql .= " $ide_iif, '$des_iif', $ide_oif, '$des_oif',";
	                $str_sql .= " '$des_chain', $ide_protocolo, '$des_protocolo', '$des_estado', '$des_acao', $ide_log, '$cmd_iptables', $ordem) ";
				}
				$db->query($str_sql);
				$msg = "Regra inserida com sucesso.";
				$msg_erro = "Não foi possível inserir esta regra.";
				if ( !isset($action) )
				{
					$action = "firewall_main.php";
				}
        }

        $db->close();

		grava_firewall();
		restart_service("firewall");
		if ( strlen(trim($action)) == 0 )
		{
			$action = "firewall_main.php";
		}
?>
<html>
	<head>
		<script>
			function redir()
			{
				alert('<?=$msg?>');
				document.form1.submit();
			}
			onload=redir;
		</script>
	</head>
	<body bgcolor="#ffffff">
	<form action="<?=$action?>" method="post" name="form1">
	</form>
	</body>
</html>