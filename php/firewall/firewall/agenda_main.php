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
		function exclui()
		{
			id = trim(get_radio_value(document.form.id_cron));
			document.form.acao.value="excluir";
			document.form.action = 'agenda_exec.php';
			document.form.id.value=id;
		}
	</script>
<?
$db = new database;
$db->connect();

$str_sql = "SELECT * FROM cron";
$rs = $db->query($str_sql);
?>
</head>
<body bgcolor="#ffffff" onload="init();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_monitor_agenda.gif" width="220" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form name="form" action="agenda_exec.php" method="post">
<input type="hidden" name="id" value="0">
<input type="hidden" name="acao" value="">
<table width="640" border=0 height="100" id="tabela" align="center">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=1 cellspacing=1>
				<tr>
					<td colspan="8" align="right">
						<a href="agenda.php"><img src="imagens/novo.gif" width="22" height="22" alt="" border="0"></a>
						<img src="imagens/space.gif" width="15" height="1" alt="" border="0">
						<input type="image" src="imagens/delete.gif" name="acao" onclick="exclui()">
					</td>
				</tr>
				<tr>
					<td><font id="font_bold">&nbsp;</font></td>
					<td><font id="font_bold">Agendado para:</font></td>
					<td><font id="font_bold">Executar teste em:</font></td>
				</tr>
<?
	$bgcolor="#ffffff";
	$first = true;
	while ( $dados = $db->read($rs) )
	{
		$min = trim($dados["minutos"]);
		$hora = trim($dados["horas"]);
		$dia = trim($dados["dias"]);
		$mes = trim($dados["meses"]);
		$sem = trim($dados["semanas"]);
		
		if ( strstr($min, "/") )
		{
			$aux = explode("/", $min);
			$min = "a cada " . intval($aux[1]) . " minuto(s)";
		} else
		{
			if ( intval($min) )
			{
				$min = "e " . intval($min) . " minuto(s)";
			} else
			{
				unset($min);
			}
		}

		if ( strstr($hora, "/") )
		{
			$aux = explode("/", $hora);
			$hora = "a cada " . trim($aux[1]) ." hora(s)";
		} else
		{
			if ( $hora == "*" )
			{
				$hora = "toda hora";
			} else
			{
				$hora = "à(s) " . intval($hora) . " horas";
			}
		}

		if ( strstr($dia, "/") )
		{
			$aux = explode("/", $dia);
			$dia = "A cada " . trim($aux[1]) ." dia(s)";
		} else
		{
			if ( $dia == "*" )
			{
				$dia = "Todo dia";
			} else
			{
				$dia = "Todo dia " . intval($dia);
			}
		}
		
		if ( strstr($mes, ",") )
		{
			$aux = explode(",", $mes);
			$mes = "";
			for ( $i = 0 ; $i < count($aux) ; $i++ )
			{
				switch (intval($aux[$i]))
				{
					case 0  : $aux[$i] = "Janeiro"; break;
					case 1  : $aux[$i] = "Fevereiro"; break;
					case 2  : $aux[$i] = "Março"; break;
					case 3  : $aux[$i] = "Abril"; break;
					case 4  : $aux[$i] = "Maio"; break;
					case 5  : $aux[$i] = "Junho"; break;
					case 6  : $aux[$i] = "Julho"; break;
					case 7  : $aux[$i] = "Agosto"; break;
					case 8  : $aux[$i] = "Setembro"; break;
					case 9  : $aux[$i] = "Outubro"; break;
					case 10 : $aux[$i] = "Novembro"; break;
					case 11 : $aux[$i] = "Dezembro"; break;
					default : $aux[$i] = "Janeiro"; break;
				}
				$mes .= $aux[$i];
				if ( ($i + 1 ) < count($aux) )
				{
					if ( ($i + 1) == (count($aux)-1) )
					{
						$mes .= " e ";
					} else
					{
						$mes .= ", ";
					}
				}
			}
			$mes = "nos meses $mes";
		} else
		{
			if ( $mes == "*" )
			{
				unset($mes);
			} else
			{
				switch (intval($mes))
				{
					case 0  : $mes = "Janeiro"; break;
					case 1  : $mes = "Fevereiro"; break;
					case 2  : $mes = "Março"; break;
					case 3  : $mes = "Abril"; break;
					case 4  : $mes = "Maio"; break;
					case 5  : $mes = "Junho"; break;
					case 6  : $mes = "Julho"; break;
					case 7  : $mes = "Agosto"; break;
					case 8  : $mes = "Setembro"; break;
					case 9  : $mes = "Outubro"; break;
					case 10 : $mes = "Novembro"; break;
					case 11 : $mes = "Dezembro"; break;
					default : $mes = "Janeiro"; break;
				}
				$mes = "no mês de $mes";
			}
		}
		
		if ( $sem != "*" )
		{
			if ( strstr($sem, ",") )
			{
				$aux = explode(",", $sem);
				$sem = "";
				for ( $i = 0 ; $i < count($aux) ; $i++ )
				{
					switch (intval($aux[$i]))
					{
						case 0 : $aux[$i] = "Domingo"; break;
						case 1 : $aux[$i] = "Segunda-feira"; break;
						case 2 : $aux[$i] = "Terça-feira"; break;
						case 3 : $aux[$i] = "Quarta-feira"; break;
						case 4 : $aux[$i] = "Quinta-feria"; break;
						case 5 : $aux[$i] = "Sexta-feira"; break;
						case 6 : $aux[$i] = "Sábado"; break;
						default : $aux[$i] = "Domingo"; break;
					}
					if ( $aux[$i] == "Sábado" || $aux[$i] == "Domingo" )
					{
						$sem .= "Todo " . $aux[$i];
					} else
					{
						$sem .= "Toda " . $aux[$i];
					}

					if ( ($i + 1 ) < count($aux) )
					{
						if ( ($i + 1) == (count($aux)-1) )
						{
							$sem .= " e ";
						} else
						{
							$sem .= ", ";
						}
					}
				}
			} else
			{
				switch (intval($sem))
				{
					case 0 : $sem = "Domingo"; break;
					case 1 : $sem = "Segunda-feira"; break;
					case 2 : $sem = "Terça-feira"; break;
					case 3 : $sem = "Quarta-feira"; break;
					case 4 : $sem = "Quinta-feria"; break;
					case 5 : $sem = "Sexta-feira"; break;
					case 6 : $sem = "Sábado"; break;
					default : $sem = "Domingo"; break;
				}
				if ( $sem == "Sábado" || $sem == "Domingo" )
				{
					$sem = "Todo " . $sem;
				} else
				{
					$sem = "Toda " . $sem;
				}
			}
		} else
		{
			unset($sem);
		}
		

		if ( strlen(trim($sem)) > 0 )
		{
			$data = "$sem, ";
		} else
		{
			$data = "$dia, ";
		}

		if ( ! strstr($min, "a cada") )
		{
			$data .= $hora;
		}
		if ( strlen(trim($min)) > 0 )
		{
			$data .= " $min";
		}
		if ( strlen(trim($mes)) > 0 )
		{
			$data .= ", $mes";
		}

		$data = substr($data, 0, 1) . strtolower(substr($data, 1, strlen($data))) . ".";
		
		$programa = trim($dados["programa"]);		
		switch (substr($programa, -2))
		{
			case "-H" : $programa = "Web Servers"; break;
			case "-B" : $programa = "Database Servers"; break;
			case "-M" : $programa = "Mail Servers"; break;
			case "-P" : $programa = "Proxy Servers"; break;
			case "-F" : $programa = "FTP Servers"; break;
			case "-O" : $programa = "Outros Servidores"; break;
			default   : $programa = "Todos Servidores"; break;
		}
		
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
				<tr bgcolor=<?=$bgcolor?>>
				    <td align="center"><input type="radio" <?=$chk?> name="id_cron" value="<?=trim($dados["id"])?>"></td>
					<td align="left"><font id="font"><?=$data?></font></td>
					<td align="left" width="25%"><font id="font"><?=$programa?></font></td>
				</tr>
<?
	}
?>
			</table>
		</td>
	</tr>
<table>
</form>
<?
	$db->close();
?>
</body>
</html>
