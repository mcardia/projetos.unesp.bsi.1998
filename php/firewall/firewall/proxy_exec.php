<?
        require("global.php");
        require("include/db.php");

		$db = new database;
		$db->connect();
		
        intval($ide_ativo)?$ide_ativo=1:$ide_ativo=0;
		
		if ( $ide_ativo )
		{
        	intval($ide_transparente)?$ide_transparente=1:$ide_transparente=0;
        	intval($ide_autenticado)?$ide_autenticado=1:$ide_autenticado=0;
		} else
		{
			$ide_transparente=0;
			$ide_autenticado=0;
		}
		
		$str_sql = "SELECT * FROM proxy_conf";
		$rs = $db->query($str_sql);
		$c = $db->count($rs);
		$db->free($rs);
		
        if ( strtolower($acao) == "salvar" )
        {
			if ( $c == 0 )
			{
				$str_sql = "INSERT INTO proxy_conf (ide_ativo, ide_autenticado, ide_transparente) VALUES($ide_ativo, $ide_autenticado, $ide_transparente)";
			} else
			{
				$str_sql = "UPDATE proxy_conf SET ide_ativo=$ide_ativo, ide_autenticado=$ide_autenticado, ide_transparente=$ide_transparente";
			}
			$db->query($str_sql);
			
			if ( $ide_transparente )
			{
				$tabela = "nat";
                $ordem = get_next_ord($tabela);
				$cmd_iptables  = "/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 80 ";
				$cmd_iptables .= "-j REDIRECT --to-ports 3128";
                $str_sql  = "INSERT INTO $tabela ";
                $str_sql .= "(num_portin, num_portout, des_chain, des_protocolo, des_acao, cmd_iptables, ordem, ide_proxy) ";
                $str_sql .= "VALUES ";
                $str_sql .= "(80, 3128, 'PREROUTING', 'tcp', 'REDIRECT', '$cmd_iptables', $ordem, 1) ";
				$db->query($str_sql);
			} else
			{
				$str_sql = "DELETE FROM nat WHERE ide_proxy=1";
				$db->query($str_sql);
			}
			
			
			$msg = "Configuração salva.";
			grava_conf($ide_autenticado);
			$action = "proxy_main.php";

			if ( $ide_ativo )
			{
				start_service("squid");
			} else
			{
				stop_service("squid");
			}

        }

        if ( strtolower($acao) == "excluir" )
        {
                $str_sql = "DELETE FROM proxy_users WHERE id=" . trim($id);
				$db->query($str_sql);
				$msg = "Usuário excluído com sucesso.";
				$action = "proxy_user.php";
				
				grava_usuarios();
        }

        if ( strtolower($acao) == "adicionar" )
        {
			$usuario = trim($usuario);
			$senha = trim($senha);

			$str_sql = "SELECT * FROM proxy_users WHERE usuario='$usuario'";
			$rs = $db->query($str_sql);
			if ( $db->count($rs) == 0 )
			{
			    $str_sql  = "INSERT INTO proxy_users ";
	            $str_sql .= "(usuario, senha, ide_novo) ";
	            $str_sql .= "VALUES ";
	            $str_sql .= "('$usuario', '$senha', 1 )";
				$db->query($str_sql);
				$msg = "Usuário inserido com sucesso.";
			} else
			{
				$msg = "Usuário já existe";
			}
			$action = "proxy_user.php";
			
			grava_usuarios();
		}
        $db->close();
		grava_firewall();
		reload_service("squid");
		restart_service("firewall");
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