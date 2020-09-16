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
			document.mail.id_server.value = 0;
			document.mail.acao.value      = "incluir";
			document.mail.gravar.value    = "Incluir";
		}

		function check_form(form)
		{
			if ( form.servidor.value.length == 0 )
			{
				alert("Preencha o nome do servidor");
				form.servidor.focus();
				return false;
			}
			if ( form.host_pop3.value.length == 0 && form.host_smtp.value.length == 0 )
			{
				alert("Preencha o endereço ( host ou IP ) do servidor POP3 ou SMTP");
				form.host.focus();
				return false;
			}
			if ( form.host_pop3.value.length > 0 )
			{
				if ( form.port_pop3.value.length == 0 )
				{
					alert("Preencha porta do servidor POP3 ( padrão: 110 )");
					form.port_pop3.focus();
					return false;
				}
			}
			if ( form.host_smtp.value.length > 0 )
			{
				if ( form.port_smtp.value.length == 0 )
				{
					alert("Preencha porta do servidor SMTP ( padrão: 25 )");
					form.port_smtp.focus();
					return false;
				}
			}
			if ( isNaN(form.port_pop3.value) )
			{
				alert("A porta servidor deve ser um número inteiro");
				form.port_pop3.value="110";
				form.port_pop3.focus();
				return false;
			}
			if ( isNaN(form.port_smtp.value) )
			{
				alert("A porta servidor deve ser um número inteiro");
				form.port_smtp.value="25";
				form.port_smtp.focus();
				return false;
			}

			return  true;
		}
		
		function equal()
		{
			form = document.mail;
			len = form.host_pop3.value.length - 1;
			if ( form.host_pop3.value.substr(0, len) == form.host_smtp.value )
			{
				form.host_smtp.value = form.host_pop3.value
			};
			return;
		}
	</script>
</head>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_mails.gif" width="254" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form action="man_mail.php" method="post" target="mainFrame" name="mailFrame" onsubmit="return check_form(this)">
	<input type="hidden" name="acao" value="incluir">
	<input type="hidden" name="id_server" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td>
					<table border=0 width="100%" cellpadding=1 cellspacing=1>
					<tr>
						<td width="30%"><font id="font_bold">Servidor</font></td>
						<td width="25%"><font id="font_bold">Host/IP</font></td>
						<td><font id="font_bold">Porta</font></td>
					</tr>
					<tr>
						<td><input type="text"   name="servidor"  value="" class="Text"></td>
						<td><font id="font_bold">POP3:</font>&nbsp;<input type="text" name="host_pop3" value="" class="Text" onkeyup="equal()"></td>
						<td><input type="text"   name="port_pop3" value="110" class="Text" size="3"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font id="font_bold">SMTP:</font>&nbsp;<input type="text"   name="host_smtp"      value="" class="Text"></td>
						<td><input type="text"   name="port_smtp" value="25" class="Text" size="3"></td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<input type="submit" name="gravar"    value="Incluir" class="Submit">
			<input type="reset"  name="limpar"    value="Limpar"  class="Submit" onclick="limpa();">
		</td>
	</tr>
</table>
</form>
</body>
</html>
