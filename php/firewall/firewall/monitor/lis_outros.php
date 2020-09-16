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
		function alterar(id, servidor, host, port, id_tcp)
		{
			parent.cad.document.outros.id_server.value = id;
			parent.cad.document.outros.acao.value      = 'alterar';
			parent.cad.document.outros.servidor.value  = servidor;
			parent.cad.document.outros.host.value      = host;
			if ( port == 0 )
				parent.cad.document.outros.port.value = '';
			else
				parent.cad.document.outros.port.value = port;
				
			parent.cad.document.outros.gravar.value    = "Alterar";
			parent.cad.document.outros.id_tcp.checked = false;
			if ( id_tcp )
			{
				parent.cad.document.outros.id_tcp.checked = true;	
			}			 
		}

		function excluir()
		{
			dados = trim(get_radio_value(document.lista.server)).split(",");
			id = parseInt(dados[0]);
			servidor = dados[1];
			msg = "Deseja excluir o servidor " + servidor + "?";
			if ( confirm(msg) )
			{
				parent.cad.document.outros.id_server.value = id;
				parent.cad.document.outros.acao.value = 'excluir';
				parent.cad.document.outros.submit();
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

	$str_sql  = "SELECT p.id, p.servidor, p.host, p.port, p.id_tcp, s.status ";
	$str_sql .= "FROM outros as p LEFT JOIN status as s ON ( p.id_status = s.id ) ";
	$str_sql .= "ORDER BY $campo $ordem";
	
	$rs = $db->db_query($str_sql);
	
	if ( $db->db_count($rs) <= 0 )
	{
		exit;
	}
?>
<body bgcolor="#ffffff" leftmargin="33" topmargin="0" marginwidth="0" marginheight="0">
<form action="man_outros.php" method="post" name="lista">
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
		$id_tcp   = trim($linha["id_tcp"]);
		$status   = trim($linha["status"]);
		
		if ( intval($id_tcp) )
		{
			$tcp = "SIM";
		}else
		{
			$tcp = "NÃO";
		}
		
		if ( strlen($status) == 0 ) $status="Indefinido";

		$chk="";
		if ( $first )
		{
			$chk = "checked";
		}
		$first=false;
?>
					<tr bgcolor="<?=$color?>">
						<td align="left"><input type="radio" <?=$chk?> name="server" value="<?=$id?>,<?=$servidor?>" onclick="alterar(<?=$id?>,'<?=$servidor?>','<?=$host?>', <?=$port?>, <?=$id_tcp?>);"></td>
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
<form action="lis_outros.php" method="post" name="ordena">
	<input type="hidden" name="campo" value="">
	<input type="hidden" name="ordem" value="">
</form>
</body>
</html>
