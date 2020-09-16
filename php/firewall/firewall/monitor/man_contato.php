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
		default   : break;
	}
	
	switch ( $erro )
	{
		case 1 : show_message("Este registro já está cadastrado"   , "frame.php?link=contato"); break;
		case 2 : show_message("Não foi possível $acao o registro"  , "frame.php?link=contato"); break;
		default: show_message("Operação realizada com sucesso"  , "frame.php?link=contato"); break;
	}

	$db->db_close();
?>
</body>
</html>
<?
	function incluir()
	{
		global $nome, $prefixo, $celular, $email, $id_celular, $id_email, $db;
		
		$nome = trim($nome);
		$celular = trim($celular);
		$prefixo = trim($prefixo);
		$email = trim($email);
		$id_celular = intval($id_celular);
		$id_email = intval($id_email);
		
		$id_celular==1?$id_celular=1:$id_celular=0;
		$id_email==1?$id_email=1:$id_email=0;

		$str_sql = "SELECT id FROM contatos WHERE nome = '$nome'";
		$rs = $db->db_query($str_sql);
		
		$erro = 0;
		
		if ( $db->db_count($rs) > 0 )
		{
			$db->db_free($rs);
			$erro = 1;
		}
		
		if ( ! $erro )
		{
			$str_sql  = "INSERT INTO contatos (nome, prefixo, celular, email, id_celular, is_email)";
			$str_sql .= "VALUES ('$nome', '$prefixo', '$celular', '$email', $id_celular, $id_email)";
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
		global $id_contato, $nome, $prefixo, $celular, $email, $id_celular, $id_email, $db;
		
		$id_contato = intval($id_contato);
		$nome = trim($nome);
		$celular = trim($celular);
		$prefixo = trim($prefixo);
		$email = trim($email);
		$id_celular = intval($id_celular);
		$id_email = intval($id_email);
		
		$id_celular==1?$id_celular=1:$id_celular=0;
		$id_email==1?$id_email=1:$id_email=0;

		$erro = 0;

		$str_sql  = "UPDATE contatos SET ";
		$str_sql .= "nome = '$nome', ";
		$str_sql .= "prefixo = '$prefixo', ";
		$str_sql .= "celular = '$celular', ";
		$str_sql .= "email = '$email', ";
		$str_sql .= "id_celular = $id_celular, ";
		$str_sql .= "id_email = $id_email ";
		$str_sql .= "WHERE id=$id_contato";
		
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
		global $id_contato, $db;

		$id_contato = intval($id_contato);

		$erro = 0;

		$str_sql = "DELETE FROM contatos WHERE id=$id_contato";
		$rs = $db->db_query($str_sql);

		if ( $db->db_affected($rs) <> 1 )
		{
			$erro = 2;
		}

		return($erro);
	}
?>