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
		function alterar(id, servidor, host, port)
		{
			parent.cad.document.form1.id_server.value = id;
			parent.cad.document.form1.acao.value      = 'alterar';
			parent.cad.document.form1.servidor.value  = servidor;
			parent.cad.document.form1.host.value      = host;
			parent.cad.document.form1.port.value = port;
			parent.cad.document.form1.gravar.value    = "Alterar";
		}

		function excluir()
		{
			dados = trim(get_radio_value(document.lista.server)).split(",");
			id = parseInt(dados[0]);
			servidor = dados[1];
			msg = "Deseja excluir o servidor " + servidor + "?";
			if ( confirm(msg) )
			{
				parent.cad.document.form1.id_server.value = id;
				parent.cad.document.form1.acao.value = 'excluir';
				parent.cad.document.form1.submit();
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
	
	if ( isset($campo) && strlen(trim($campo)) > 0 )
	{
		$campo = trim($campo);
	} else
	{
		$campo = "servidor";
	}

	if ( isset($ordem) && strlen(trim($ordem)) > 0 )
	{
		$ordem = strtoupper(trim($ordem));
	} else
	{
		$ordem = "ASC";
	}

	$str_sql  = "SELECT p.id, p.servidor, p.host, p.port, s.status ";
	$str_sql .= "FROM proxy as p LEFT JOIN status as s ON ( p.id_status = s.id ) ";
	$str_sql .= "ORDER BY $campo $ordem";
	
	$rs = $db->db_query($str_sql);
	
	if ( $db->db_count($rs) <= 0 )
	{
		exit;
	}
?>
<body bgcolor="#ffffff" leftmargin="33" topmargin="0" marginwidth="0" marginheight="0">
<form action="man_proxy.php" method="post" name="lista">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td>
				<table width="100%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="3" align="right"><a href="javascript: excluir()"><img src="../imagens/delete.gif" border="0"></a></td>
					</tr>
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><font id="font_bold">Servidor</font></td>
						<td align="left"><font id="font_bold">Status</font></td>
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
		$servidor = trim($linha["servidor"]);
		$host     = trim($linha["host"]);
		$port	  = trim($linha["port"]);
		$status   = trim($linha["status"]);
		if ( strlen($status) == 0 ) $status="Indefinido";

		$chk="";
		if ( $first )
		{
			$chk = "checked";
		}
		$first=false;
?>
					<tr bgcolor="<?=$color?>">
						<td align="left"><input type="radio" <?=$chk?> name="server" value="<?=$id?>,<?=$servidor?>" onclick="alterar(<?=$id?>,'<?=$servidor?>','<?=$host?>', <?=$port?>);"></td>
						<td align="left"><font id="font"><?=$servidor?></font></td>
						<td align="left"><font id="font"><?=$status?></font></td>
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
<form action="lis_proxy.php" method="post" name="ordena">
	<input type="hidden" name="campo" value="">
	<input type="hidden" name="ordem" value="">
</form>
</body>
</html>
