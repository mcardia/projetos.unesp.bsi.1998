<? 
	require("include/style.css");
	require("global.php");
	require("include/db.php");
?>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
function check_form(form)
{
	return(true);
}

function verify_hora_min(fd)
{
	if ( fd.name=="repete_hora" )
	{
		if (fd.checked) fd.form.repete_min.checked = !fd.checked;
		fd.form.min.disabled=false;
	}
	if ( fd.name=="repete_min" )
	{
		if (fd.checked) fd.form.repete_hora.checked =! fd.checked;
		fd.form.hora.disabled=false;
	}
}

function verify()
{
	form = document.agenda;
	if ( form.repete.checked )
	{
		dis = true;
	} else
	{
		dis = false;
	}
	for ( i = 0; i <= (form.length -1 ); i++ )
	{
		if ( form[i].name.substr(0,7) == "repete_" )
		{
			form[i].disabled = dis;
		}
	}
}
</script>
</head>

<body bgcolor="#FFFFFF" onload="init(), verify()" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#CC0033">
      <div align="right"><img src="imagens/tp_monitor_agenda.gif" width="220" height="17" alt="" border="0"></div>
    </td>
  </tr>
</table>
<? require("menu.html") ?>
<form name="agenda" action="agenda_exec.php" method="post" onsubmit="return check_form(this)">
<input type="hidden" name="id" value=0>
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
				<tr>
					<td colspan="2">
						<table border=0 cellpadding=1 cellspacing=1 width="100%">
							<tr>
								<td>Agendar teste para:</td>
							</tr>
							<tr>
								<td><select name="tipo" class="Text">
									<option value="A">Todos</option>
									<option value="H">Web Servers</option>
									<option value="B">Database Servers</option>
									<option value="M">Mail Servers</option>
									<option value="P">Proxy Servers</option>
									<option value="F">FTP Servers</option>
									<option value="O">Outros Servidores</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>Data da execução:</td>
							</tr>
							<tr>
								<td>
									<table cellpadding="1" cellspacing="1">
										<tr>
											<td>Dia:</td>
											<td><select name="dia" class="Text">
													<option value="*">Todos</option>
			<?									for ( $i = 1; $i <=31; $i++ )
												{?>
													<option value="<?=$i?>"><?=substr("0$i", -2)?></option>
			<?									}?>									
												</select>
											</td>
											<td>Mês</td>
											<td><select name="mes" class="Text">
													<option value="*">Todos</option>
			<?
												$mes = array("Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
												              "Jul","Ago", "Set", "Out", "Nov", "Dez");
												for ( $i = 1; $i <=12; $i++ )
												{?>
													<option value="<?=$i?>"><?=$mes[$i-1]?></option>
			<?									}?>									
												</select>
											</td>
											<td>Hora:</td>
											<td><select name="hora" class="Text">
													<option value="*">Todos</option>
			<?									for ( $i = 0; $i <=23; $i++ )
												{?>
													<option value="<?=$i?>"><?=substr("0$i", -2)?></option>
			<?									}?>									
												</select>
											</td>
											<td>Minuto:</td>
											<td><select name="min" class="Text">
			<?
												for ( $i = 0; $i <=59; $i++ )
												{?>
													<option value="<?=$i?>"><?=substr("0$i", -2)?></option>
			<?									}?>									
												</select>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2" align="center"><img src="imagens/linha_preta.gif" width="580" height="1" alt="" border="0"></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="repete" value="1" checked onclick="verify()"> Não repetir</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="repete_semana" value="1" onclick="verify(), this.form.dia.disabled = this.checked"> Repetir durante a semana nos dias:</td>
							</tr>
							<tr>
								<td colspan="2">
								<table cellpadding="1" cellspacing="1">
									<tr>
										<td><img src="imagens/space.gif" width="15" height="1" alt="" border="0"></td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="0" onclick="verify(), this.form.repete_semana.checked=true">Dom</td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="1" onclick="verify(), this.form.repete_semana.checked=true">Seg</td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="2" onclick="verify(), this.form.repete_semana.checked=true">Ter</td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="3" onclick="verify(), this.form.repete_semana.checked=true">Qua</td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="4" onclick="verify(), this.form.repete_semana.checked=true">Qui</td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="5" onclick="verify(), this.form.repete_semana.checked=true">Sex</td>
										<td><input type="checkbox" name="repete_dia_semana[]" value="6" onclick="verify(), this.form.repete_semana.checked=true">Sab</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="repete_mes" value="1" onclick="verify(), this.form.mes.disabled = this.checked"> Repetir durande o ano nos meses:</td>
							</tr>
							<tr>
								<td colspan="2">
								<table cellpadding="1" cellspacing="1">
									<tr>
										<td><img src="imagens/space.gif" width="15" height="1" alt="" border="0"></td>
										<td><input type="checkbox" name="repete_num_mes[]" value="00" onclick="verify(), this.form.repete_mes.checked=true">Jan</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="01" onclick="verify(), this.form.repete_mes.checked=true">Fev</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="02" onclick="verify(), this.form.repete_mes.checked=true">Mar</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="03" onclick="verify(), this.form.repete_mes.checked=true">Abr</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="04" onclick="verify(), this.form.repete_mes.checked=true">Mai</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="05" onclick="verify(), this.form.repete_mes.checked=true">Jun</td>
									</tr>
									<tr>
										<td><img src="imagens/space.gif" width="15" height="1" alt="" border="0"></td>
										<td><input type="checkbox" name="repete_num_mes[]" value="06" onclick="verify(), this.form.repete_mes.checked=true">Jul</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="07" onclick="verify(), this.form.repete_mes.checked=true">Ago</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="08" onclick="verify(), this.form.repete_mes.checked=true">Set</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="09" onclick="verify(), this.form.repete_mes.checked=true">Out</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="10" onclick="verify(), this.form.repete_mes.checked=true">Nov</td>
										<td><input type="checkbox" name="repete_num_mes[]" value="11" onclick="verify(), this.form.repete_mes.checked=true">Dez</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="repete_dia" value="1" onclick="verify(), this.form.dia.disabled = this.checked">
									Repetir a cada <input type="Text" class="Text" name="repete_num_dia" value="1" size=2> dia(s).
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="repete_hora" value="1" onclick="verify(), this.form.hora.disabled = this.checked, verify_hora_min(this)">
									Repetir a cada <input type="Text" class="Text" name="repete_num_hora" value="1" size=2> hora(s).
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="repete_min" value="1" onclick="verify(), this.form.min.disabled = this.checked, verify_hora_min(this)">
									Repetir a cada <input type="Text" class="Text" name="repete_num_min" value="10" size=2> minuto(s).
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="right">
						<input type="Button" name="volta" value="Voltar" class="Submit" onclick="location.href='agenda_main.php'">
						<input type="Submit" name="acao" value="Inserir" class="Submit">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
