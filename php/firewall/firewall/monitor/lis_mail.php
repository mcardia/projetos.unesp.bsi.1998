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
		function alterar(id, servidor, host_pop3, host_smtp, port_pop3, port_smtp)
		{
			parent.cad.document.mailFrame.id_server.value = id;
			parent.cad.document.mailFrame.acao.value      = 'alterar';
			parent.cad.document.mailFrame.servidor.value  = servidor;
			parent.cad.document.mailFrame.host_pop3.value = host_pop3;
			parent.cad.document.mailFrame.host_smtp.value = host_smtp;
			parent.cad.document.mailFrame.port_pop3.value = port_pop3;
			parent.cad.document.mailFrame.port_smtp.value = port_smtp;

			parent.cad.document.mailFrame.gravar.value    = "Alterar";
		}

		function excluir()
		{
			dados = trim(get_radio_value(document.lista.server)).split(",");
			id = parseInt(dados[0]);
			servidor = dados[1];
			msg = "Deseja excluir o servidor " + servidor + "?";
			if ( confirm(msg) )
			{
				parent.cad.document.mailFrame.id_server.value = id;
				parent.cad.document.mailFrame.acao.value = 'excluir';
				parent.cad.document.mailFrame.submit();
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
	
	$campo = "servidor";
	$ordem = "ASC";

	$str_sql  = "SELECT * ";
	$str_sql .= "FROM mail ";
	$str_sql .= "ORDER BY $campo $ordem";
	$rs = $db->db_query($str_sql);

	if ( $db->db_count($rs) <= 0 )
	{
		exit;
	}
?>
<body bgcolor="#ffffff" leftmargin="33" topmargin="0" marginwidth="0" marginheight="0">
<form action="man_mail.php" method="post" name="lista">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td>
				<table width="100%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="4" align="right"><a href="javascript: excluir()"><img src="../imagens/delete.gif" border="0"></a></td>
					</tr>
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><font id="font_bold">Servidor<br>&nbsp;</font></td>
						<td align="left"><font id="font_bold">Status POP3</font></td>
						<td align="left"><font id="font_bold">Status SMTP</font></td>
					</tr>
<?
	$first = true;
	while ( $linha = $db->db_read($rs) )
	{
		if ( isset($color) )
		{
			unset($color);
		} else
		{
			$color="#dfdfdf";
		}
		$id = trim($linha["id"]);
		$servidor = trim($linha["servidor"]);
		$host_pop3  = trim($linha["host_pop3"]);
		$host_smtp  = trim($linha["host_smtp"]);
		$port_pop3  = trim($linha["port_pop3"]);
		$port_smtp  = trim($linha["port_smtp"]);

		$id_status_pop3 = trim($linha["id_status_pop3"]);
		$id_status_smtp = trim($linha["id_status_smtp"]);
		if ( $id_status_pop3 == 0 ) $id_status_pop3 = 1;
		if ( $id_status_smtp == 0 ) $id_status_smtp = 1;
		
		$str_sql  = "SELECT status ";
		$str_sql .= "FROM status ";
		$str_sql .= "WHERE id = $id_status_pop3";
		$rs_pop3 = $db->db_query($str_sql);
		$st = $db->db_read($rs_pop3);
		$status_pop3   = trim($st["status"]);
		$db->db_free($rs_pop3);

		$str_sql  = "SELECT status ";
		$str_sql .= "FROM status ";
		$str_sql .= "WHERE id = $id_status_smtp";
		$rs_smtp = $db->db_query($str_sql);
		$st = $db->db_read($rs_smtp);
		$status_smtp   = trim($st["status"]);
		$db->db_free($rs_smtp);

		$color_pop3 = "black";
		if ( $id_status_pop3 == 2 ) $color_pop3 = "red";
		$color_smtp = "black";
		if ( $id_status_smtp == 2 ) $color_smtp = "red";

		$chk="";
		if ( $first )
		{
			$chk = "checked";
		}
		$first=false;

?>
					<tr bgcolor="<?=$color?>">
						<td align="left"><input type="radio" <?=$chk?> name="server" value="<?=$id?>,<?=$servidor?>" onclick="alterar(<?=$id?>,'<?=$servidor?>','<?=$host_pop3?>', '<?=$host_smtp?>', '<?=$port_pop3?>', '<?=$port_smtp?>');"></td>
						<td align="left"><font  id="font"><?=$servidor?></font></td>
						<td align="left"><font  id="font"><?=$status_pop3?></font></td>
						<td align="left"><font  id="font"><?=$status_smtp?></font></td>
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
</form>
<?
	$db->db_close();
?>
<form action="lis_mail.php" method="post" name="ordena">
	<input type="hidden" name="campo" value="">
	<input type="hidden" name="ordem" value="">
</form>
</body>
</html>
