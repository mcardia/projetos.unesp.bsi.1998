<?
	require("global.php");
	require("./include/db.php");
	require("./include/funcoes.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
	<script>
		function limpa()
		{
			document.base.id_server.value = 0;
			document.base.acao.value      = "incluir";
			document.base.gravar.value    = "Incluir";
		}

		function check_form(form)
		{
			if ( form.servidor.value.length == 0 )
			{
				alert("Preencha o nome do servidor");
				form.servidor.focus();
				return false;
			}
			if ( form.host.value.length == 0 )
			{
				alert("Preencha o endereço ( host ou IP ) do servidor");
				form.host.focus();
				return false;
			}
			if ( form.id_tipo.options.selectedIndex == -1 )
			{
				alert("Escolha o tipo do servidor");
				form.id_tipo.focus();
				return false;
			}
			return  true;
		}
	</script>
</head>
<?
	$db = new database;
	
	$db->db_connect();
	
	$str_sql = "SELECT * FROM bases_tipo ORDER BY tipo";
	
	$rs = $db->db_query($str_sql);
?>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_datab.gif" width="305" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form action="man_base.php" method="post" target="mainFrame" name="base" onsubmit="return check_form(this)">
	<input type="hidden" name="acao" value="incluir">
	<input type="hidden" name="id_server" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td><font id="font_black_b">Servidor</font></td>
					<td><font id="font_black_b">Host/IP</font></td>
					<td><font id="font_black_b">Tipo</font></td>
				</tr>
				<tr>
					<td><input type="text"   name="servidor" value="" class="Text"></td>
					<td><input type="text"   name="host"     value="" class="Text"></td>
					<td><select name="id_tipo" class="Text">
	<?
			while ( $linha = $db->db_read($rs) )
			{
	?>
			<option value="<?=trim($linha["id"])?>"><?=trim($linha["tipo"])?></option>
	<?
			}
			$db->db_free($rs);
			$db->db_close();
	?>
		</select>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="submit" name="gravar"   value="Incluir" class="Submit">
				<input type="reset"  name="limpar"   value="Limpar"  class="Submit" onclick="limpa();">
			</td>

		</tr>
</table>
</form>
</body>
</html>
