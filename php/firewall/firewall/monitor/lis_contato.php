<?
	require("global.php");
	require("include/funcoes.php");
	require("include/db.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
	<script src="../include/funcoes.js"></script>
	<script>
		function alterar(id, nome, prefixo, celular, email, id_celular, id_email)
		{
			parent.cad.document.contato.id_contato.value = id;
			parent.cad.document.contato.acao.value      = 'alterar';
			parent.cad.document.contato.nome.value  = nome;
			parent.cad.document.contato.prefixo.value  = prefixo;
			parent.cad.document.contato.celular.value  = celular;
			parent.cad.document.contato.email.value  = email;
			parent.cad.document.contato.id_celular.checked  = id_celular;
			parent.cad.document.contato.id_email.checked  = id_email;
			parent.cad.document.contato.gravar.value    = "Alterar";
		}

		function excluir()
		{
			dados = trim(get_radio_value(document.lista.server)).split(",");
			id = parseInt(dados[0]);
			servidor = dados[1];
			msg = "Deseja excluir o servidor " + servidor + "?";
			if ( confirm(msg) )
			{
				parent.cad.document.contato.id_contato.value = id;
				parent.cad.document.contato.acao.value = 'excluir';
				parent.cad.document.contato.submit();
			}
		}

		function ord(campo, ordem)
		{
			document.ordena.campo.value=campo;
			document.ordena.ordem.value=ordem;
			document.ordena.submit();
		}
	</script>
</head>
<?
	$db = new database;
	
	$db->db_connect();
	
	$campo = "nome";
	$ordem = "ASC";

	$str_sql  = "SELECT * ";
	$str_sql .= "FROM contatos ";
	$str_sql .= "ORDER BY $campo $ordem";
	
	$rs = $db->db_query($str_sql);
	
	if ( $db->db_count($rs) <= 0 )
	{
		exit;
	}
?>
<body bgcolor="#ffffff" leftmargin="33" topmargin="0" marginwidth="0" marginheight="0">
<br>
<form action="man_contato.php" method="post" name="lista">
<table width="600" border=0 align="center" id="tabela">
<tr valign="top">
	<td align="center">
	<table border=0 width="100%" cellpadding=5 cellspacing=5>
	<tr>
		<td>
			<table border="0" width="100%" cellpadding="1" cellspacing="1">
					<tr>
						<td colspan="5" align="right"><a href="javascript: excluir()"><img src="../imagens/delete.gif" border="0"></a></td>
					</tr>
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><font id="font_bold">Nome</font></td>
						<td align="left"><font id="font_bold">Celular</font></td>
						<td align="left"><font id="font_bold">Email</font></td>
						<td align="left"><font id="font_bold">Recebe</font></td>
					</tr>
<?
	$first=true;
	while ( $linha = $db->db_read($rs) )
	{
		if ( isset($color) )
		{
			unset($color);
		} else
		{
			$color="#dfdfdf";
		}
		$id		  = trim($linha["id"]);
		$nome     = trim($linha["nome"]);
		$prefixo  = trim($linha["prefixo"]);
		$celular  = trim($linha["celular"]);
		$email	  = trim($linha["email"]);
		$id_celular = 0;
		$id_email   = 0;
		if ( intval($linha["id_celular"]) )
		{
			$id_celular = 1;
		}
		if ( intval($linha["id_email"]) )
		{
			$id_email = 1;
		}

		$recebe = "Nada";
		if ( $id_celular && $id_email )
		{
			$recebe = "SMS/Email";
		} else
		{
			if ( $id_celular && !$id_email )
			{
				$recebe = "SMS";
			} else
			{
				if ( !$id_celular && $id_email )
				{
					$recebe = "Email";
				}
			}
		}

		$chk="";
		if ( $first )
		{
			$chk = "checked";
		}
		$first=false;
?>
					<tr bgcolor="<?=$color?>">
						<td align="left"><input type="radio" <?=$chk?> name="server" value="<?=$id?>,<?=$servidor?>" onclick="alterar(<?=$id?>,'<?=$nome?>','<?=$prefixo?>', '<?=$celular?>', '<?=$email?>', <?=$id_celular?>, <?=$id_email?>);"></td>
						<td align="left"><font id="font"><?=$nome?></font></td>
						<td align="left"><font id="font"><?="(" . trim($linha["prefixo"]) . ") " . trim($linha["celular"])?></font></td>
						<td align="left"><font id="font"><?=$email?></font></td>
						<td align="left"><font id="font"><?=$recebe?></font></td>
					</tr>
<?
	}
?>
					</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
<form action="lis_contato.php" method="post" name="ordena">
	<input type="hidden" name="campo" value="">
	<input type="hidden" name="ordem" value="">
</form>
<?
	$db->db_close();
?>
</body>
</html>
