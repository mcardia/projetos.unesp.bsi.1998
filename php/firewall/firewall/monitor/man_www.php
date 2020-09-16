<?
	require("global.php");
	require("include/db.php");
	require("include/funcoes.php");
?>
<html>
<head>
	<title>Untitled</title>
	<link href="include/style.css" rel="stylesheet">
</head>

<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" marginheight="0" marginwidth="0">
<?
	$db = new database;
	$db->db_connect();
	
	switch ( trim($acao) )
	{
		case "incluir" : $erro = incluir(); break;
		case "alterar" : $erro = alterar(); break;
		case "excluir" : $erro = excluir(); break;
		case "config"  : $erro = config(); break;
		default   : break;
	}
	
	switch ( $erro )
	{
		case 1 : show_message("Este registro já está cadastrado"   , "frame.php?link=www"); break;
		case 2 : show_message("Não foi possível $acao o registro"  , "frame.php?link=www"); break;
		default: show_message("Operação realizada com sucesso"  , "frame.php?link=www"); break;
	}

	$db->db_close();
?>
</body>
</html>
<?
	function incluir()
	{
		global $servidor, $host, $port, $db, $id_ssl, $port_ssl;
		
		$servidor = trim($servidor);
		$host = trim($host);
		$port = trim($port);
		trim($id_ssl)!="1"?$id_ssl=0:$id_ssl=1;
		$port_ssl = trim($port_ssl);
				
		$str_sql = "SELECT id FROM http WHERE host = '$host' OR servidor='$servidor'";
		
		$rs = $db->db_query($str_sql);
		
		$erro = 0;
		
		if ( $db->db_count($rs) > 0 )
		{
			$db->db_free($rs);
			$erro = 1;
		}
		
		if ( ! $erro )
		{
			$str_sql  = "INSERT INTO http (servidor, host, port, id_ssl, port_ssl, id_status) ";
			$str_sql .= "VALUES ('$servidor', '$host', $port, $id_ssl, $port_ssl, 0)";
			$rs = $db->db_query($str_sql);
			if ( $db->db_affected($rs) <> 1 )
			{
				$erro = 2;
			}
			unset($rs);
		}
		
		return($erro);
	}

	function alterar()
	{
		global $id_server, $servidor, $host, $port, $id_ssl, $port_ssl, $db;
		
		$id_server = trim($id_server);
		$servidor = trim($servidor);
		$host = trim($host);
		$port = trim($port);
		$port_ssl = trim($port_ssl);
		trim($id_ssl)!="1"?$id_ssl=0:$id_ssl=1;
		
		$erro = 0;

		$str_sql  = "UPDATE http SET ";
		$str_sql .= "servidor = '$servidor', ";
		$str_sql .= "host     = '$host', ";
		$str_sql .= "port     = $port, ";
		$str_sql .= "id_ssl   = $id_ssl, ";
		$str_sql .= "port_ssl = $port_ssl ";
		$str_sql .= "WHERE id=$id_server";
		
		$db->db_query($str_sql);
			
		if ( $db->db_erro() == 1 )
		{
			$erro = 2;
		}

		return($erro);
	}

	function excluir()
	{
		global $id_server, $db;

		$id_server = trim($id_server);

		$erro = 0;

		$str_sql = "DELETE FROM http WHERE id=$id_server";
		$rs = $db->db_query($str_sql);

		if ( $db->db_affected($rs) <> 1 )
		{
			$erro = 2;
		}

		return($erro);
	}
?>