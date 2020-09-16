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
		case 1 : show_message("Este registro já está cadastrado"   , "frame.php?link=outros"); break;
		case 2 : show_message("Não foi possível $acao o registro"  , "frame.php?link=outros"); break;
		default: show_message("Operação realizada com sucesso"  , "frame.php?link=outros"); break;
	}

	$db->db_close();
?>
</body>
</html>
<?
	function incluir()
	{
		global $servidor, $host, $port, $id_tcp, $db;
		
		$servidor = trim($servidor);
		$host = trim($host);
		$port = trim($port);
		$id_tcp = trim($id_tcp);
		
		if ( $id_tcp != "1" ) 
		{
			$id_tcp = 0;
		} else
		{
			$id_tcp = 1;
		}	

		if ( strlen($port) == 0 ) $port = 0;
		
		$str_sql = "SELECT id FROM outros WHERE host = '$host' OR servidor='$servidor'";
		$rs = $db->db_query($str_sql);
		
		$erro = 0;
		
		if ( $db->db_count($rs) > 0 )
		{
			$db->db_free($rs);
			$erro = 1;
		}
		
		if ( ! $erro )
		{
			$str_sql  = "INSERT INTO outros (servidor, host, port, id_tcp, id_status) ";
			$str_sql .= "VALUES ('$servidor', '$host', $port, $id_tcp, 0)";
			$rs = $db->db_query($str_sql);
			if ( $db->db_affected($rs) <> 1 )
			{
				$erro = 2;
			}
		}
		
		return($erro);
	}
?>

<?
	function alterar()
	{
		global $id_server, $servidor, $host, $port, $id_tcp, $db;
		
		$id_server = trim($id_server);
		$servidor = trim($servidor);
		$host = trim($host);
		$port = trim($port);
		$id_tcp = trim($id_tcp);
		
		if ( $id_tcp != "1" ) 
		{
			$id_tcp = 0;
		} else
		{
			$id_tcp = 1;
		}	

		if ( strlen($port) == 0 ) $port = 0;

		$erro = 0;

		$str_sql  = "UPDATE outros SET ";
		$str_sql .= "servidor = '$servidor', ";
		$str_sql .= "host     = '$host', ";
		$str_sql .= "port     = $port, ";
		$str_sql .= "id_tcp   = $id_tcp ";
		$str_sql .= "WHERE id=$id_server";
		
		$db->db_query($str_sql);
			
		if ( $db->db_erro() == 1 )
		{
			$erro = 2;
		}

		return($erro);
	}
?>

<?
	function excluir()
	{
		global $id_server, $db;

		$id_server = trim($id_server);

		$erro = 0;

		$str_sql = "DELETE FROM outros WHERE id=$id_server";
		$rs = $db->db_query($str_sql);

		if ( $db->db_affected($rs) <> 1 )
		{
			$erro = 2;
		}

		return($erro);
	}
?>
