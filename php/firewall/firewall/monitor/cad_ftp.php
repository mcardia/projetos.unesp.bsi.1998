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
			document.ftp.id_server.value = 0;
			document.ftp.acao.value      = "incluir";
			document.ftp.gravar.value    = "Incluir";
			document.ftp.port.value      = "8080";
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
			if ( form.port.value.length == 0 )
			{
				alert("Preencha a porta servidor");
				form.port.focus();
				return false;
			}
			if ( isNaN(form.port.value) )
			{
				alert("A porta servidor deve ser um número inteiro");
				form.port.value="21";
				form.port.focus();
				return false;
			}
			return  true;
		}
	</script>
</head>
<?
	$db = new database;
	
	$db->db_connect();
?>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_ftps.gif" width="251" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form action="man_ftp.php" method="post" target="mainFrame" name="ftp" onsubmit="return check_form(this)">
	<input type="hidden" name="acao" value="incluir">
	<input type="hidden" name="id_server" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td width="30%"><font id="font_bold">Servidor</font></td>
				<td width="25%"><font id="font_bold">Host/IP</font></td>
				<td><font id="font_bold">Porta</font></td>
			</tr>
			<tr>
				<td><input type="text"   name="servidor" value="" class="Text"></td>
				<td><input type="text"   name="host"     value="" class="Text"></td>
				<td><input type="text"   name="port"     value="21" class="Text" size="3"></td>
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
