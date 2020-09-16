<? 
	require("include/style.css");
	require("global.php");
	require("include/db.php");
?>
<html>
<head>
	<title>Untitled</title>
	<script language="javascript" src="include/funcoes.js"></script>
	<script>
		function up(tab)
		{
			id_regra = trim(get_radio_value(document.form2.id_regra)).split(',');
			ordem = parseInt(id_regra[1]);
			document.form2.action = 'firewall_pais.php';
			document.form2.ordem.value = ordem;
			document.form2.op.value='up';
			document.form2.tabela.value=tab;			
			document.form2.submit();
		}
		function down(tab)
		{
			id_regra = trim(get_radio_value(document.form2.id_regra)).split(',');
			ordem = parseInt(id_regra[1]);
			document.form2.action = 'firewall_pais.php';
			document.form2.ordem.value = ordem;
			document.form2.op.value='down';
			document.form2.tabela.value=tab;			
			document.form2.submit();
		}
		function exclui(tab)
		{
			id_regra = trim(get_radio_value(document.form2.id_regra)).split(',');
			id = parseInt(id_regra[0]);
			document.form2.action = 'firewall_exec.php?acao=excluir&<?=SID?>';
			document.form2.id.value=id;
			document.form2.tabela.value=tab;
		}
	</script>
	<script>
		function check_form_redir(form)
		{
			if ( ! trim(form.des_url.value).length )
			{
				alert('Por favor, informe o site que deseja bloquear.\nEx.: www.dominio.com.br\n       111.222.333.444');
				form.des_url.focus();
				return false;
			}
			if ( form.des_url.value.indexOf('/') != -1 )
			{
				alert('Por favor, informe apenas o dominio principal do site.\nEx.: www.dominio.com.br\n     111.222.333.444');
				form.des_url.focus();
				return false;
			}
			return true;
		}
	</script>
</head>
<?
$db = new database;
$db->connect();

if ( isset($op) && (strlen(trim($op)) > 0) )
{
	if ( (trim($op) == "up") && (intval($ordem) > 1) )
	{
		$str_sql = "UPDATE $tabela SET ordem=0 WHERE ordem=".(intval($ordem) - 1);
		$db->query($str_sql);
		$str_sql = "UPDATE $tabela SET ordem=".(intval($ordem) - 1)." WHERE ordem = $ordem";
		$db->query($str_sql);
		$str_sql = "UPDATE $tabela SET ordem=".intval($ordem)." WHERE ordem = 0";
		$db->query($str_sql);
	} else if ( (trim($op) == "down")  && (intval($ordem) != get_max_ord($tabela)) )
	{
		$str_sql = "UPDATE $tabela SET ordem=0 WHERE ordem=".(intval($ordem) + 1);
		$db->query($str_sql);
		$str_sql = "UPDATE $tabela SET ordem=".(intval($ordem) + 1)." WHERE ordem = $ordem";
		$db->query($str_sql);
		$str_sql = "UPDATE $tabela SET ordem=".intval($ordem)." WHERE ordem = 0";
		$db->query($str_sql);
	}
}
$str_sql = "SELECT * FROM ctr_pais ORDER BY ordem";
$rs_nat = $db->query($str_sql);
?>

<body bgcolor="#ffffff" onload="init();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_firewall_controlepais.gif" width="238" height="17" alt="" border="0"></td>
	</tr>
</table>
<form name="form" action="firewall_exec.php" method="post" onsubmit="return check_form_redir(this)">
<input type="hidden" name="id" value=0>
<input type="hidden" name="tipo" value="crt_pais">
<? require("menu.html") ?>
<table width="600" border=0 height="100" id="tabela" align="center">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td colspan="2">
						<table border=0 cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td>Bloquear acesso ao site:</td>
							</tr>
							<tr>
								<td>http://<input type="text" class="Text_r" size="40" maxlength="40"  name="des_url" value=""></td>							
							<tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><input type="submit" name="acao" value="Bloquear Site" class="Submit"></td>
	</tr>
</table>
</form>
<form name="form2" action="firewall_exec.php" method="post">
<input type="hidden" name="id" value="0">
<input type="hidden" name="ordem" value="0">
<input type="hidden" name="op" value="">
<input type="hidden" name="tabela" value="ctr_pais">
<table width="600" border=0 height="100" id="tabela" align="center">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=1 cellspacing=1>
				<tr>
					<td align="right" colspan="2">
						<input type="image" src="imagens/delete.gif" name="acao" onclick="exclui('ctr_pais')">
						<img src="imagens/space.gif" width="15" height="1" alt="" border="0">
						<a href="javascript: up('ctr_pais')"><img src="imagens/seta_up.gif" width="20" height=21" alt="" border="0"></a>
						<a href="javascript: down('ctr_pais')"><img src="imagens/seta_down.gif" width="20" height="21" alt="" border="0"></a>
					</td>
				</tr>
				<tr>
					<td><font id="font_bold">&nbsp;</font></td>
					<td><font id="font_bold">Site</font></td>
				</tr>
<?
	$bg="#ffffff";
	$first = true;
	while ( $dados = $db->read($rs_nat) )
	{
		$site = trim($dados["des_url"]);
		$ordem = trim($dados["ordem"]);

		if ( $bg=="#ffffff" )
		{
			$bg="#dfdfdf";
		} else
		{
			$bg="#ffffff";
		}
		$chk = "";
		if ( $first )
		{
			$chk = "checked";
		}
		$first = false;
?>    
				<tr bgcolor="<?=$bg?>">
					<td align="center"><input type="radio" <?=$chk?> name="id_regra" value="<?=trim($dados["id"])?>,<?=trim($dados["ordem"])?>"></td>
					<td align="left" ><font id="font"><?=$site?></font></td>
				</tr>
<?
	}
?>
		</td>
	</tr>
</table>
</form>
<?
	$db->close();
?>
</body>
</html>
