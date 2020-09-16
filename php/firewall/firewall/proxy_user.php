<?
	require("global.php");
	require("include/db.php");
	require("include/style.css");
?>
<html>
<head>
	<title></title>
	<script src="include/funcoes.js"></script>
	<script>
		function exclui()
		{
			id = parseInt(get_radio_value(document.proxy_form.id_user));
			document.proxy_form.action = 'proxy_exec.php?acao=excluir&<?=SID?>';
			document.proxy_form.id.value=id;
		}
		
		function valid_char(texto)
		{
			if ( (i=texto.indexOf(" ")) != -1 ) return i;
			if ( (i=texto.indexOf(".")) != -1 ) return i;
			if ( (i=texto.indexOf(",")) != -1 ) return i;
			if ( (i=texto.indexOf(":")) != -1 ) return i;
			if ( (i=texto.indexOf(";")) != -1 ) return i;
			if ( (i=texto.indexOf("/")) != -1 ) return i;
			if ( (i=texto.indexOf("\"")) != -1 ) return i;
			if ( (i=texto.indexOf("\\")) != -1 ) return i;
			if ( (i=texto.indexOf("'")) != -1 ) return i;
			if ( (i=texto.indexOf("@")) != -1 ) return i;
			if ( (i=texto.indexOf("^")) != -1 ) return i;
			if ( (i=texto.indexOf("~")) != -1 ) return i;
			if ( (i=texto.indexOf("+")) != -1 ) return i;
			if ( (i=texto.indexOf("-")) != -1 ) return i;
			if ( (i=texto.indexOf("*")) != -1 ) return i;
			if ( (i=texto.indexOf("|")) != -1 ) return i;
			return (-1);
		}

		function check_form(form)
		{
			if ( trim(form.usuario.value).length == 0 )
			{
				alert("Por favor, informe o nome do usuário");
				form.usuario.focus();
				return false;
			}
			if ( trim(form.senha.value).length == 0 )
			{
				alert("Por favor, informe a senha do usuário");
				form.senha.focus();
				return false;
			}
            aux = valid_char(form.usuario.value);
			if ( aux != -1 )
			{
				if ( form.usuario.value.substr(aux,1) == " " )
				{
					msg = "Não é permitido espaços no nome do usuário";
				} else
				{
					msg = "O Caracter '" + form.usuario.value.substr(aux,1) + "' não é permitido";
				}
				alert(msg);
				form.usuario.focus();
				return false;
			}
            aux = valid_char(form.senha.value);
			if ( aux != -1 )
			{
				if ( form.senha.value.substr(aux,1) == " " )
				{
					msg = "Não é permitido espaços na senha";
				} else
				{
					msg = "O Caracter '" + form.senha.value.substr(aux,1) + "' não é permitido";
				}
				alert(msg);
				form.senha.focus();
				return false;
			}
			return true;
		}
	</script>
</head>
	<?
		$db = new database;
		$db->connect();

		$str_sql = "SELECT * FROM proxy_users";
		$rs_users = $db->query($str_sql);

		$str_sql = "SELECT * FROM proxy_conf";
		$rs_conf = $db->query($str_sql);
		
		if  ( $dados = $db->read($rs_conf) )
		{
			$ide_ativo = intval($dados["ide_ativo"]);
			$ide_autenticado = intval($dados["ide_autenticado"]);
			$ide_transparente = intval($dados["ide_transparente"]);
			$db->free($rs_conf);
		} else
		{
			$ide_ativo = 0;
			$ide_autenticado = 0;
			$ide_transparente = 0;
		}
	?>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_proxy_users.gif" width="149" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form name="proxy_form" action="proxy_exec.php" method="post">
<input type="hidden" name="id" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td>Usuário</td>
					<td>Senha:</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><input type="text" name="usuario" value="" maxlength="8"></td>
					<td><input type="text" name="senha" value="" maxlength="8"></td>
					<td><input type="submit" name="acao" value="Adicionar" onclick="return check_form(this.form)"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" colspan="3">
							<input type="image" src="imagens/delete.gif" name="acao" onclick="exclui()">
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font id="font_bold">Usuario</font></td>
						<td><font id="font_bold">Senha</font></td>
					</tr>
<?
	$bgcolor="#ffffff";
	$first=true;
	while ( $dados = $db->read($rs_users) )
	{
		$usuario = trim($dados["usuario"]);
		$senha = trim($dados["senha"]);

		if ( $bgcolor=="#ffffff" )
		{
			$bgcolor="#dfdfdf";
		} else
		{
			$bgcolor="#ffffff";
		}
		$chk = "";
		if ( $first )
		{
			$chk = "checked";
		}
		$first = false;
?>    
					<tr bgcolor="<?=$bgcolor?>">
						<td align="center"><input type="radio" <?=$chk?> name="id_user" value="<?=trim($dados["id"])?>"></td>
						<td width="50%"><font id="font"><?=$usuario?></font></td>
						<td width="40%"><font id="font"><?=$senha?></font></td>
					</tr>
<?
	}
?>
					</table>
				</td>
			</tr>
		</td>
	</tr>
<table>
</form>
<?
	$db->close();
?>
</body>
</html>