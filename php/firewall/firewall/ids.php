<? 
	require("include/style.css");
	require("global.php");
	require("include/db.php");
?>
<html>
<head>
	<title></title>
	<script language="javascript" src="include/funcoes.js"></script>
	<script>
		function check_form(form)
		{
			usa_porta=false;
			
			ipin = trim(form.ipin1.value).length > 0 || trim(form.ipin2.value).length > 0 || trim(form.ipin3.value).length > 0 || trim(form.ipin4.value).length > 0;
			ipout = trim(form.ipout1.value).length > 0 || trim(form.ipout2.value).length > 0 || trim(form.ipout3.value).length > 0 || trim(form.ipout4.value).length > 0;
			portin = trim(form.num_portin.value).length > 0;
			portout = trim(form.num_portout.value).length > 0;
			form.num_ipin.value = form.ipin1.value + "." + form.ipin2.value + "." + form.ipin3.value + "." + form.ipin4.value;
			form.num_ipout.value = form.ipout1.value + "." + form.ipout2.value + "." + form.ipout3.value + "." + form.ipout4.value;
			
			if ( (!ipin) && (!ipout) && (!portin) && (!portout) )
			{
				alert('Por favor, defina a regra corretamente.');
				form.ipin1.focus();
				return false;
			}
			
			if ( ipin )
			{
				if ( ! is_ip(form.num_ipin.value) ) 
				{
					alert('Número de IP inválido.');
					form.ipin1.focus();
					return(false);
				}
			} 

			if ( ipout )
			{
				if ( ! is_ip(form.num_ipout.value) )
				{
					alert('Número de IP inválido.');
					form.ipout1.focus();
					return(false);
				}
			} 

			if ( trim(form.num_portin.value).length > 0 )
			{
				usa_porta=true;
				if ( isNaN(form.num_portin.value) && (form.num_portin.value != "any") )
				{
					alert('O valor da porta deve ser um número');
					form.num_portin.focus();
					return false;
				}
			}

			if ( trim(form.num_portout.value).length > 0 )
			{
				usa_porta=true;
				if ( isNaN(form.num_portout.value) && (form.num_portout.value != "any") )
				{
					alert('O valor da porta deve ser um número');
					form.num_portout.focus();
					return false;
				}
			}

			if ( trim(form.conteudo.value).length == 0 )
			{
				alert("Defina padrão/conteúdo daquilo que deseja bloquear");
				form.conteudo.focus();
				return(false);
			}
			
			if ( trim(form.msg.value).length == 0 )
			{
				alert("Defina uma identificação para a regra.");
				form.msg.focus();
				return(false);
			}
			
			
			if ( form.num_ipin.value == "0.0.0.0" || form.num_ipin.value == "..." ) form.num_ipin.value="any";
			if ( form.num_ipout.value == "0.0.0.0" || form.num_ipout.value == "..." ) form.num_ipout.value="any";

			return true;
		}

		function get_mask(campo)
		{
			pop_upw('get_mask.php?campo=' + campo, 300, 150);
		}

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

		function exclui()
		{
			id = parseInt(get_radio_value(document.ids_form2.id_regra));
			document.ids_form2.action = 'ids_exec.php?acao=excluir&<?=SID?>';
			document.ids_form2.id.value=id;
		}

	</script>
</head>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_ids_criaregra.gif" width="198" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form name="ids_form" action="ids_exec.php" method="post" onsubmit="return check_form(this)">
<input type="hidden" name="id" value=0>
<input type="hidden" name="num_ipin" value="">
<input type="hidden" name="num_ipout" value="">

<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td colspan="2">
						<table border=0 cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td width="28%">IP Origem:</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;Sub-rede:</td>
								<td>Porta Origem:</td>
							</tr>
							<tr>
								<td><input type="text" class="Text" name="ipin1" value="" size="3" maxlength="3" onkeyup="next(this, 'ipin2')">
									<input type="text" class="Text" name="ipin2" value="" size="3" maxlength="3" onkeyup="next(this, 'ipin3')">
									<input type="text" class="Text"  name="ipin3" value="" size="3" maxlength="3" onkeyup="next(this, 'ipin4')">
									<input type="text" class="Text"  name="ipin4" value="" size="3" maxlength="3" onkeyup="next(this, 'num_maskin')"></td>
								<td>
									/&nbsp;<input type="text" class="Text"  name="num_maskin" value="" size="3">
									<a href="javascript: get_mask('num_maskin')" >Calcular</a>
								</td>
								<td><input type="text" class="Text"  name="num_portin" value="any" size="3" maxlength="5"></td>							
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table border=0 cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td width="28%">IP Destino:</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;Sub-rede:</td>
								<td>Porta Destino:</td>
							</tr>
							<tr>
								<td><input type="text" class="Text"  name="ipout1" value="" size="3" maxlength="3" onkeyup="next(this, 'ipout2')">
									<input type="text" class="Text"  name="ipout2" value="" size="3" maxlength="3" onkeyup="next(this, 'ipout3')">
									<input type="text" class="Text"  name="ipout3" value="" size="3" maxlength="3" onkeyup="next(this, 'ipout4')">
									<input type="text" class="Text"  name="ipout4" value="" size="3" maxlength="3" onkeyup="next(this, 'num_maskout')"></td>
								<td>
									/&nbsp;<input type="text" class="Text"  name="num_maskout" value="" size="3">
									<a href="javascript: get_mask('num_maskout')" >Calcular</a>
								</td>
								<td><input type="text" class="Text"  name="num_portout" value="any" size="3" maxlength="5"></td>							
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">Contendo:</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" class="Text"  name="conteudo" value="" size="50"></td>
				</tr>
				<tr>
					<td colspan="2">Identificação da Regra:</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" class="Text"  name="msg" value="" size="50"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input class="Submit" type="submit" name="acao" value="Inserir"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<form name="ids_form2" action="ids_exec.php" method="post">
<input type="hidden" name="id" value=0>
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td>
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
						<tr>
							<td align="right" colspan="7">
								<input type="image" src="imagens/delete.gif" name="acao" onclick="exclui()">
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><font id="font_bold">Identificação</font></td>
							<td><font id="font_bold">Origem</font></td>
							<td><font id="font_bold">Porta</font></td>
							<td><font id="font_bold">Destino</font></td>
							<td><font id="font_bold">Porta</font></td>
							<td><font id="font_bold">Conteudo</font></td>
						</tr>
<?
	$bgcolor="#ffffff";
	$first=true;
	
	$db = new database;
	$db->connect();
	
	$str_sql = "SELECT * FROM ids";
	$rs = $db->query($str_sql);

	while ( $dados = $db->read($rs) )
	{
		unset($origem); unset($destino); unset($portin); unset($portout);
		
		$identificacao = trim($dados["msg"]);
		
		$origem = trim($dados["num_ipin"]);
		if ( intval($dados["num_maskin"]) )
		{
			$origem .= "/". trim($dados["num_maskin"]);
		}

		$portin = "any";
	    if ( intval($dados["num_portin"]) )
		{
			$portin = trim($dados["num_portin"]);
		}
		
		$destino = trim($dados["num_ipout"]);
		if ( intval($dados["num_maskout"]) )
		{
			$destino .= "/". trim($dados["num_maskout"]);
		}
		
		$portout="any";
	    if ( intval($dados["num_portout"]) )
		{
			$portout = trim($dados["num_portout"]);
		}

		$content = trim($dados["content"]);

		if ( $bgcolor=="#ffffff" )
		{
			$bgcolor="#dfdfdf";
		} else
		{
			$bgcolor="#ffffff";
		}
		$chk = "";
		if ( $first )
		{
			$chk = "checked";
		}
		$first = false;
?>    
						<tr bgcolor="<?=$bgcolor?>">
							<td align="center"><input type="radio" <?=$chk?> name="id_regra" value="<?=trim($dados["id"])?>"></td>
							<td><font id="font_blue"><?=$identificacao?></font></td>
							<td><font id="font_blue"><?=$origem?></font></td>
							<td><font id="font_blue"><?=$portin?></font></td>
							<td><font id="font_blue"><?=$destino?></font></td>
							<td><font id="font_blue"><?=$portout?></font></td>
							<td><font id="font_blue"><?=$content?></font></td>
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
<table width="600" align="center" border="0" cellpadding="1" cellspacing="1">
<tr>
	<td align="right"><a href="http://www.snort.org" target="_blank">Powered by SNORT</a></td>
</tr>
</table>
</form>
<?
	$db->close();
?>
</body>
</html>