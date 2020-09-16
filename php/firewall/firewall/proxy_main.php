<?
	require("global.php");
	require("include/db.php");
	require("include/style.css");
?>
<html>
<head>
	<title></title>
	<script>
		function exclui(id, tab)
		{
			document.proxy_form.id.value=id;
		}
		function check(campo)
		{
			form = document.proxy_form;

			if ( !form.ide_ativo.checked )
			{
				form.ide_autenticado.checked = false;
				form.ide_transparente.checked = false;
				alert('O proxy precisa ser habilitado para esta função');
				return;
			}
			
			if ( campo.name == "ide_autenticado" && form.ide_transparente.checked )
			{
				alert('O proxy autenticado não pode ser utilizado junto\n com o proxy tranasparente.');
				campo.checked = 0;
			}
			if ( campo.name == "ide_transparente" && form.ide_autenticado.checked )
			{
				alert('O proxy autenticado não pode ser utilizado junto\n com o proxy tranasparente.');
				campo.checked = 0;
			}
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
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_proxy_config.gif" width="254" height="17" alt="" border="0"></td>
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
				<? $ide_ativo?$checked="checked":$checked="";?>
						<td><input type="checkbox" name="ide_ativo" value="1" <?=$checked?>> Habilitar o serviço de proxy</td>
					</tr>
				<? $ide_autenticado?$checked="checked":$checked="";?>
					<tr>
						<td><input type="checkbox" name="ide_autenticado" value="1" <?=$checked?> onclick="check(this)"> Habilitar proxy autenticado</td>
					</tr>
				<? $ide_transparente?$checked="checked":$checked="";?>
					<tr>
						<td><input type="checkbox" name="ide_transparente" value="1" <?=$checked?> onclick="check(this)"> Habilitar transparente</td>
					</tr>
					<tr>
						<td align="right"><input class="Submit" type="submit" name="acao" value="Salvar"></td>
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