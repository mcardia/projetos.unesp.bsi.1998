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
		function next(atual, proximo)
		{
			form_name = atual.form.name;
			size = atual.value.length;
			muda = false;
			if ( atual.value.substr(size - 1, size) == "." )
			{
				atual.value = atual.value.substr(0, size - 1);
				muda = true;
			}
		    eval('proximo=document.' + form_name + '.' + proximo);
			if ( (atual.value.length > 2) || (muda) )
			{
				proximo.focus();
			}
		}

		function up(tab)
		{
			id_regra = trim(get_radio_value(document.form2.id_regra)).split(',');
			ordem = parseInt(id_regra[1]);
			document.form2.action = 'firewall_nat.php';
			document.form2.ordem.value = ordem;
			document.form2.op.value='up';
			document.form2.tabela.value=tab;			
			document.form2.submit();
		}
		function down(tab)
		{
			id_regra = trim(get_radio_value(document.form2.id_regra)).split(',');
			ordem = parseInt(id_regra[1]);
			document.form2.action = 'firewall_nat.php';
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
			nat_ipin = trim(form.nat_ipin1.value).length > 0 || trim(form.nat_ipin2.value).length > 0 || trim(form.nat_ipin3.value).length > 0 || trim(form.nat_ipin4.value).length > 0;
			nat_ipout = trim(form.nat_ipout1.value).length > 0 || trim(form.nat_ipout2.value).length > 0 || trim(form.nat_ipout3.value).length > 0 || trim(form.nat_ipout4.value).length > 0;

			form.nat_ipin.value = form.nat_ipin1.value + "." + form.nat_ipin2.value + "." + form.nat_ipin3.value + "." + form.nat_ipin4.value;
			form.nat_ipout.value = form.nat_ipout1.value + "." + form.nat_ipout2.value + "." + form.nat_ipout3.value + "." + form.nat_ipout4.value;

			if ( ! nat_ipin )
			{
				alert('O IP origem é obrigatório para o redirecionamento');
				form.nat_ipin1.focus();
				return false;
			}
			
			if ( (! nat_ipout) && (trim(form.nat_portout.value).length == 0) )
			{
				alert('O destino deve ser um IP ou uma porta ou ambos.');
				form.nat_ipout1.focus();
				return false;
			}

			if ( nat_ipin )
			{
				if ( ! is_ip(form.nat_ipin.value) ) 
				{
					alert('Número de IP inválido.');
					form.nat_ipin1.focus();
					return(false);
				}
			} 

			if ( nat_ipout )
			{
				if ( ! is_ip(form.nat_ipout.value) )
				{
					alert('Número de IP inválido.');
					form.nat_ipout1.focus();
					return(false);
				}
			} 

			if ( trim(form.nat_portin.value).length > 0 )
			{
				usa_porta=true;
				if ( isNaN(form.nat_portin.value) )
				{
					alert('O valor da porta deve ser um número');
					form.nat_portin.focus();
					return false;
				}
			}

			if ( trim(form.nat_portout.value).length > 0 )
			{
				usa_porta=true;
				if ( isNaN(form.nat_portout.value) )
				{
					alert('O valor da porta deve ser um número');
					form.nat_portout.focus();
					return false;
				}
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
$str_sql = "SELECT * FROM nat WHERE ide_masq <> 1 AND ide_proxy <> 1 ORDER BY ordem";
$rs_nat = $db->query($str_sql);
?>

<body bgcolor="#ffffff" onload="init();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_firewall_nat.gif" width="124" height="17" alt="" border="0"></td>
	</tr>
</table>
<form name="form" action="firewall_exec.php" method="post" onsubmit="return check_form_redir(this)">
<input type="hidden" name="id" value=0>
<input type="hidden" name="tipo" value="simple">
<input type="hidden" name="nat_ipin" value="">
<input type="hidden" name="nat_ipout" value="">
<? require("menu.html") ?>
<table width="600" border=0 height="100" id="tabela" align="center">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td colspan="2">
						<table border=0 cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td width="35%">IP Origem:</td>
								<td>Porta Origem:</td>
							</tr>
							<tr>
								<td><input type="text" class="Text"  name="nat_ipin1"   value="" size="3" maxlength="3" onkeyup="next(this, 'nat_ipin2')">
								    <input type="text" class="Text"  name="nat_ipin2" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_ipin3')">
								    <input type="text" class="Text"  name="nat_ipin3" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_ipin4')">
								    <input type="text" class="Text"  name="nat_ipin4" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_portin')"></td>
								<td><input type="text" class="Text"  name="nat_portin"  value="" size="3" maxlength="5"></td>							
							<tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td width="35%">IP Destino:</td>
								<td>Porta Destino:</td>
							</tr>
							</tr>
								<td><input type="text" class="Text"  name="nat_ipout1" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_ipout2')">
								    <input type="text" class="Text"  name="nat_ipout2" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_ipout3')">
									<input type="text" class="Text"  name="nat_ipout3" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_ipout4')">
									<input type="text" class="Text"  name="nat_ipout4" value="" size="3" maxlength="3" onkeyup="next(this, 'nat_portout')"></td>
								<td><input type="text" class="Text"  name="nat_portout" value="" size="3" maxlength="5"></td>							
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><input type="submit" name="acao" value="Redirecionar" class="Submit"></td>
	</tr>
</table>
</form>
<form name="form2" action="firewall_exec.php" method="post" onsubmit="return check_form_redir(this)">
<input type="hidden" name="id" value="0">
<input type="hidden" name="ordem" value="0">
<input type="hidden" name="op" value="">
<input type="hidden" name="tabela" value="regras">
<table width="600" border=0 height="100" id="tabela" align="center">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=1 cellspacing=1>
				<tr>
					<td colspan="6" align="right">
						<input type="image" src="imagens/delete.gif" name="acao" onclick="exclui('nat')">
						<img src="imagens/space.gif" width="15" height="1" alt="" border="0">
						<a href="javascript: up('nat')"><img src="imagens/seta_up.gif" width="20" height="21" alt="" border="0"></a>
						<a href="javascript: down('nat')"><img src="imagens/seta_down.gif" width="20" height="21" alt="" border="0"></a>
					</td>
				</tr>
				<tr>
					<td><font id="font_bold">&nbsp;</font></td>
					<td><font id="font_bold">Origem</font></td>
					<td><font id="font_bold">Porta</font></td>
					<td><font id="font_bold">Destino</font></td>
					<td><font id="font_bold">Porta</font></td>
					<td><font id="font_bold">Ação</font></td>
				</tr>
<?
	$bg="#ffffff";
	$first = true;
	while ( $dados = $db->read($rs_nat) )
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

		$acao = trim($dados["des_acao"]);
		$ordem = trim($dados["ordem"]);
		
		if ( (strlen(trim($origem))==0) || ($origem=="0.0.0.0") )   $origem="any";
		if ( (strlen(trim($destino))==0) || ($destino=="0.0.0.0") )  $destino="any";
		if ( strlen(trim($acao))==0 )     $acao="&nbsp;";
		if ( strlen(trim($portin))==0 )   $portin="&nbsp;";
		if ( strlen(trim($portout))==0 )  $portout="&nbsp;";

		$font = "font";
		
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
					<td align="left" ><font id="<?=$font?>"><?=$origem?></font></td>
					<td align="left" ><font id="<?=$font?>"><?=$portin?></font></td>
					<td align="left" ><font id="<?=$font?>"><?=$destino?></font></td>
					<td align="left" ><font id="<?=$font?>"><?=$portout?></font></td>
					<td align="leftr"><font id="<?=$font?>"><?=$acao?></font></td>
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
