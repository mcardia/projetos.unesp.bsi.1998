<?
	require("global.php");
	require("./include/db.php");
	require("./include/funcoes.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
	<script src="include/funcoes.js"></script>
	<script>
		function limpa()
		{
			document.contato.id_contato.value = 0;
			document.contato.acao.value      = "incluir";
			document.contato.gravar.value    = "Incluir";
		}

		function check_form(form)
		{
			if ( form.nome.value.length == 0 )
			{
				alert("Preencha o nome do contato");
				form.nome.focus();
				return false;
			}

			if ( !form.id_celular.checked && !form.id_email.checked)
			{
				alert("O contato deve receber pelo menos o email ou o SMS.");
				form.nome.focus();
				return false;
			}
			
			if ( form.id_celular.checked )
			{
				if ( form.prefixo.value.length == 0 )
				{
					alert("Preencha o prefixo do celular");
					form.prefixo.focus();
					return false;
				}
				if ( isNaN(form.prefixo.value) )
				{
					alert("Preencha o prefixo do celular somente com numeros");
					form.prefixo.focus();
					return false;
				}
				if ( form.celular.value.length == 0 )
				{
					alert("Preencha o número do celular");
					form.celular.focus();
					return false;
				}
				if ( isNaN(form.celular.value) )
				{
					alert("Preencha o número do celular somente com numeros");
					form.celular.focus();
					return false;
				}
			}

			if ( form.id_email.checked )
			{
				if ( ! is_email(form.email.value) )
				{
					form.prefixo.focus();
					return false;
				}
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
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_contatos.gif" width="233" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?><br>
<form action="man_contato.php" method="post" target="mainFrame" name="contato" onsubmit="return check_form(this)">
	<input type="hidden" name="acao" value="incluir">
	<input type="hidden" name="id_contato" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=4 cellspacing=4>
			<tr>
				<td>
					<table border=0 width="100%" cellpadding=0 cellspacing=0>
						<tr>
							<td><font id="font_black_b">Nome:</font></td>
							<td><font id="font_black_b">SMS/Celular:</font></td>
							<td><font id="font_black_b">Email:</font></td>
						</tr>
						<tr>
							<td><input type="text"   name="nome" value="" class="Text"></td>
							<td><input type="text"   name="prefixo"  value="" class="Text" size="3"> - <input type="text"   name="celular"  value="" class="Text" size="7"></td>
							<td><input type="text"   name="email"    value="" class="Text" size="30"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><font id="font_dica">(DDD)</font> - <font id="font_dica">(celular)</font></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="5">
								<input type="Checkbox" name="id_celular" value="1" checked> 
								<font id="font_black_b">Enviar SMS</font>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<input type="Checkbox" name="id_email" value="1" checked>
								<font id="font_black_b">Enviar Email</font>
							</td>
						</tr>
					</table>
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
