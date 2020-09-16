<? require("include/style.css")?>
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
			
			if ( (!ipin) && (!ipout) && (!portin) && (!portout) && 
			     (get_radio_value(form.des_acao)=='') )
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
				if ( isNaN(form.num_portin.value) )
				{
					alert('O valor da porta deve ser um número');
					form.num_portin.focus();
					return false;
				}
			}

			if ( trim(form.num_portout.value).length > 0 )
			{
				usa_porta=true;
				if ( isNaN(form.num_portout.value) )
				{
					alert('O valor da porta deve ser um número');
					form.num_portout.focus();
					return false;
				}
			}
			
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

	</script>

</head>
<body bgcolor="#ffffff" onload="init();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_firewall_adicionar.gif" width="221" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form name="form" action="firewall_exec.php" method="post" onsubmit="return check_form(this)">
<input type="hidden" name="id" value=0>
<input type="hidden" name="tipo" value="simple">
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
								<td width="25%">&nbsp;&nbsp;&nbsp;Sub-rede:</td>
								<td>Porta Origem:</td>
							</tr>
							<tr>
								<td><input type="text" class="Text"  name="ipin1" value="" size="3" maxlength="3" onkeyup="next(this, 'ipin2')">
								    <input type="text" class="Text"  name="ipin2" value="" size="3" maxlength="3" onkeyup="next(this, 'ipin3')">
									<input type="text" class="Text"  name="ipin3" value="" size="3" maxlength="3" onkeyup="next(this, 'ipin4')">
									<input type="text" class="Text"  name="ipin4" value="" size="3" maxlength="3" onkeyup="next(this, 'num_maskin')"></td>
								<td>
									/&nbsp;<input type="text" class="Text"  name="num_maskin" value="" size="3">
									<a href="javascript: get_mask('num_maskin')" >Calcular</a>
								</td>
								<td><input type="text" class="Text"  name="num_portin" value="" size="3" maxlength="5"></td>							
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table border=0 cellpadding=0 cellspacing=0 width="100%">
							<tr>
								<td width="28%">IP Destino:</td>
								<td width="25%">&nbsp;&nbsp;&nbsp;Sub-rede:</td>
								<td>Porta Destino:</td>
							</tr>
							<tr>
								<td><input type="text" class="Text"  name="ipout1" value="" size="3" maxlength="3" onkeyup="next(this, 'ipout2')">
								    <input type="text" class="Text"  name="ipout2" value="" size="3" maxlength="3" onkeyup="next(this, 'ipout3')">
									<input type="text" class="Text"  name="ipout3" value="" size="3" maxlength="3" onkeyup="next(this, 'ipout4')">
									<input type="text" class="Text"  name="ipout4" value="" size="3" maxlength="3" onkeyup="next(this, 'num_portout')"></td>
								<td>
									/&nbsp;<input type="text" class="Text"  name="num_maskout" value="" size="3">
									<a href="javascript: get_mask('num_maskout')" >Calcular</a>
								</td>
								<td><input type="text" class="Text"  name="num_portout" value="" size="3" maxlength="5"></td>							
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">Ação:</td>
				</tr>
				<tr>
					<td>
				    	<table align="left" cellpadding=1 cellspacing=1 border=0>
							<tr>
								<td><input type="radio" name="des_acao" value="ACCEPT"><font id="font_bold">PERMITIR</font></td>
								<td><input type="radio" name="des_acao" value="DROP"><font id="font_bold">BLOQUEAR</font></td>
							</tr>
						</table>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><input type="submit" name="acao" value="Inserir" class="Submit"></td>
	</tr>
</table>
</form>
</body>
</html>