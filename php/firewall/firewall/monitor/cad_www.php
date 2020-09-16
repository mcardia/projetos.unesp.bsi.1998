<?
	require("./include/funcoes.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
	<script>
		function limpa()
		{
			document.web.id_server.value = 0;
			document.web.acao.value      = "incluir";
			document.web.gravar.value    = "Incluir";
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
				alert("Preencha porta de conexão com servidor");
				form.port.focus();
				return false;
			}
			if ( isNaN(form.port.value) )
			{
				alert("A porta servidor deve ser um número inteiro");
				form.port.value="80";
				form.port.focus();
				return false;
			}
			if ( form.id_ssl.checked )
			{
				if ( form.port_ssl.value.length == 0 )
				{
					alert("Preencha a porta de conexão servidor SSL");
					form.port_ssl.focus();
					return false;
				}
				if ( isNaN(form.port_ssl.value) )
				{
					alert("A porta servidor deve ser um número inteiro");
					form.port_ssl.value="443";
					form.port_ssl.focus();
					return false;
				}
			}
			return  true;
		}
	</script>
</head>

<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_webs.gif" width="258" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form action="man_www.php" method="post" target="mainFrame" name="web" onsubmit="return check_form(this)">
	<input type="hidden" name="acao" value="incluir">
	<input type="hidden" name="id_server" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td><font id="font_bold">Servidor:</font></td>
					<td><font id="font_bold">Host/IP:</font></td>
					<td><font id="font_bold">Porta:</font></td>
					<td><font id="font_bold">Porta SSL:</font></td>
				</tr>
				<tr>
					<td><input type="text" name="servidor" value="" class="Text"></td>
					<td><input type="text" name="host"     value="" class="Text"></td>
					<td><input type="text" name="port"     value="80" class="Text" size="3"></td>
					<td><input type="text" name="port_ssl" value="443" class="Text" size="3"></td>
				</tr>
				<tr>
					<td colspan="4"><input type="checkbox" name="id_ssl" value="1">&nbsp;<font id="font_bold">Habilitar o teste do protocolo SSL neste servidor</font></td>
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
