<?
	require("global.php");
	require("include/db.php");
	require("include/style.css");
?>
<html>
<head>
	<title></title>
	<script src="include/funcoes.js"></script>
	<script>
		function up(tab)
		{
			id_regra = trim(get_radio_value(document.form.id_regra)).split(',');
			ordem = parseInt(id_regra[1]);
			document.form.action = 'firewall_main.php';
			document.form.ordem.value = ordem;
			document.form.op.value='up';
			document.form.tabela.value=tab;			
			document.form.submit();
		}
		function down(tab)
		{
			id_regra = trim(get_radio_value(document.form.id_regra)).split(',');
			ordem = parseInt(id_regra[1]);
			document.form.action = 'firewall_main.php';
			document.form.ordem.value = ordem;
			document.form.op.value='down';
			document.form.tabela.value=tab;			
			document.form.submit();
		}
		function exclui(tab)
		{
			id_regra = trim(get_radio_value(document.form.id_regra)).split(',');
			id = parseInt(id_regra[0]);
			document.form.action = 'firewall_exec.php?acao=excluir&<?=SID?>';
			document.form.id.value=id;
			document.form.tabela.value=tab;
		}
	</script>


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
				$ord = intval($ordem)-1;
			} else if ( (trim($op) == "down")  && (intval($ordem) != get_max_ord($tabela)) )
			{
				$str_sql = "UPDATE $tabela SET ordem=0 WHERE ordem=".(intval($ordem) + 1);
				$db->query($str_sql);
				$str_sql = "UPDATE $tabela SET ordem=".(intval($ordem) + 1)." WHERE ordem = $ordem";
				$db->query($str_sql);
				$str_sql = "UPDATE $tabela SET ordem=".intval($ordem)." WHERE ordem = 0";
				$db->query($str_sql);
				$ord = intval($ordem)-1;
			}
		}

		
		if ( strtolower(trim($acao))=="atualizar regras" )
		{
			grava_firewall();
			restart_service("firewall");
		}
		
		$str_sql = "SELECT * FROM regras ORDER BY ordem";
		$rs = $db->query($str_sql);
	?>
</head>
<body bgcolor="#ffffff" onload="init();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_firewall_regras.gif" width="240" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form name="form" action="firewall_exec.php" method="post">
<input type="hidden" name="id" value="0">
<input type="hidden" name="ordem" value="0">
<input type="hidden" name="op" value="">
<input type="hidden" name="tabela" value="regras">

<table width="640" border=0 height="100" id="tabela" align="center">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=1 cellspacing=1>
				<tr>
					<td colspan="8" align="right">
						<a href="firewall_simp.php"><img src="imagens/novo.gif" width="22" height="22" alt="" border="0"></a>
						<img src="imagens/space.gif" width="15" height="1" alt="" border="0">
						<input type="image" src="imagens/delete.gif" name="acao" onclick="exclui('regras')">
						<img src="imagens/space.gif" width="15" height="1" alt="" border="0">
						<a href="javascript: up('regras')"><img src="imagens/seta_up.gif" width="20" height="21" alt="" border="0"></a>
						<a href="javascript: down('regras')"><img src="imagens/seta_down.gif" width="20" height="21" alt="" border="0"></a>
					</td>
				</tr>
				<tr>
					<td><font id="font_bold">&nbsp;</font></td>
					<td><font id="font_bold">Origem</font></td>
					<td><font id="font_bold">Porta</font></td>
					<td><font id="font_bold">Destino</font></td>
					<td><font id="font_bold">Porta</font></td>
					<td><font id="font_bold">Estado</font></td>
					<td><font id="font_bold">Interface</font></td>
					<td><font id="font_bold">Ação</font></td>
				</tr>
<?
	$bgcolor="#ffffff";
	$first = true;
	while ( $dados = $db->read($rs) )
	{
		unset($origem); unset($destino); unset($portin); unset($portout);
		
		intval($dados["ide_ipin"])?$origem="<font id=\"font_red\">!</font>":$origem="";
		$origem .= trim($dados["num_ipin"]);
		if ( intval($dados["num_maskin"]) )
		{
			$origem .= "/". trim($dados["num_maskin"]);
		}
	    if ( intval($dados["num_portin"]) )
		{
			intval($dados["ide_portin"])?$portin="<font id=\"font_red\">!</font>":$portin="";
			$portin .= trim($dados["num_portin"]);
		}
		
		intval($dados["ide_ipout"])?$destino="<font id=\"font_red\">!</font>":$destino="";
		$destino .= trim($dados["num_ipout"]);
		if ( intval($dados["num_maskout"]) )
		{
			$destino .= "/". trim($dados["num_maskout"]);
		}
	    if ( intval($dados["num_portout"]) )
		{
			intval($dados["ide_portout"])?$portout="<font id=\"font_red\">!</font>":$portout="";
			$portout .= trim($dados["num_portout"]);
		}
		
		$iif = false;
		$des_if="";
		if ( strlen(trim($dados["des_iif"])) > 0 )
		{
			intval($dados["ide_iif"])?$des_if="<font id=\"font_red\">!</font>":$des_if="";
			$des_if .= "<font id=\"font_green\">In:&nbsp;</font>" . trim($dados["des_iif"]);
			$iif = true;
		}

		if ( strlen(trim($dados["des_oif"])) > 0 )
		{
			if ( $iif )
			{
				$des_if .= "<br>";
			} else
			{
				$des_if="";
			}
			intval($dados["ide_oif"])?$des_if.="<font id=\"font_red\">!</font>":$des_if.="";
			$des_if .= "<font id=\"font_blue\">Out:&nbsp;</font>" . trim($dados["des_oif"]);
		}
		
		
		$estado = trim($dados["des_estado"]);
		$acao = trim($dados["des_acao"]);
		$ordem = trim($dados["ordem"]);
		
		if ( (strlen(trim($origem))==0) || ($origem=="0.0.0.0") )   $origem="any";
		if ( (strlen(trim($destino))==0) || ($destino=="0.0.0.0") )  $destino="any";
		if ( strlen(trim($acao))==0 )     $acao="&nbsp;";
		if ( strlen(trim($estado))==0 )   $estado="any";
		if ( strlen(trim($des_if))==0 )   $des_if="any";
		if ( strlen(trim($portin))==0 )   $portin="any";
		if ( strlen(trim($portout))==0 )  $portout="any";

		$estado = str_replace(",", "<br>", $estado);
		if ( $bgcolor=="#ffffff" )
		{
			$bgcolor="#dfdfdf";
		} else
		{
			$bgcolor="#ffffff";
		}
		
		$chk = "";
		if ( intval($ord) == intval($ordem) )
		{
			$chk = "checked";
		} else if ( $first )
		{
			$chk = "checked";
		}
		$first = false;
?>    
				<tr bgcolor=<?=$bgcolor?>>
				    <td align="center"><input type="radio" <?=$chk?> name="id_regra" value="<?=trim($dados["id"])?>,<?=trim($dados["ordem"])?>"></td>
					<td align="left"><font id="font"><?=$origem?></font></td>
					<td align="left"><font id="font"><?=$portin?></font></td>
					<td align="left"><font id="font"><?=$destino?></font></td>
					<td align="left"><font id="font"><?=$portout?></font></td>
					<td align="left"><font id="font"><?=$estado?></font></td>
					<td align="left"><font id="font"><?=$des_if?></font></td>
					<td align="left"><font id="font"><?=$acao?></font></td>
				</tr>
<?
	}
?>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><input class="Submit" type="submit" name="acao" value="Atualizar regras" onclick="this.form.action='firewall_main.php'"></td>
	</tr>
<table>
</form>
<?
	$db->close();
?>
</body>
</html>
