<?
require("global.php");
require("include/db.php");

$db = new database;
$db->connect();
		
if ( strtolower(trim($acao)) == "inserir" )
{
		$tipo = trim($tipo);

		$dia = trim($dia);
		if ( $dia != "*" )
			$dia  = substr("0$dia", -2);

		$mes = trim($mes);
		if ( $mes != "*" )
			$mes  = substr("0$mes", -2);
			
		$hora = trim($hora);
		if ( $hora != "*" )
			$hora  = substr("0$hora", -2);

		$min = trim($min);
		if ( $min != "*" )
			$min  = substr("0$min", -2);
		
		$sem = "*";
		
		if ( !intval($repete) )
		{
			if ( intval($repete_semana) && count($repete_dia_semana) > 0 )
			{
				$dia="*";
				if ( count($repete_dia_semana) == 7 )
				{
					$sem="*";
				} else
				{
					$sem="";
					for ( $i = 0; $i < count($repete_dia_semana); $i++ )
					{
						$sem .= $repete_dia_semana[$i];
						if ( ($i + 1 ) < count($repete_dia_semana) )
						{
							$sem .= ",";
						}
					}
				}
			}

			if ( intval($repete_mes) && count($repete_num_mes) > 0 )
			{
				if ( count($repete_num_mes) == 12 )
				{
					$mes="*";
				} else
				{
					$mes="";
					for ( $i = 0; $i < count($repete_num_mes); $i++ )
					{
						$mes .= intval($repete_num_mes[$i]);
						if ( ($i + 1 ) < count($repete_num_mes) )
						{
							$mes .= ",";
						}
					}
				}
			}

			if ( intval($repete_dia) )
			{
				$dia="1-31/" . intval($repete_num_dia);
			}

			if ( intval($repete_hora) )
			{
				$hora="0-23/" . intval($repete_num_hora);
			}

			if ( intval($repete_min) )
			{
				$min="0-59/" . intval($repete_num_min);
			}

		}
		
		$str_sql  = "INSERT INTO cron (minutos, horas, dias, meses, semanas, programa)";
		$str_sql .="VALUES ('$min','$hora','$dia','$mes','$sem', '/usr/local/netmon -$tipo')";
		
		$db->query($str_sql);
		
		$msg = "Tarefa agendada com sucesso";
		$action="agenda.php";
}

if ( strtolower(trim($acao)) == "excluir" )
{
		$str_sql  = "DELETE FROM cron WHERE id=". intval($id);
		$db->query($str_sql);
		$msg = "Tarefa excluída com sucesso";
		$action="agenda_main.php";
}


$str_sql = "SELECT * FROM cron";
$rs = $db->query($str_sql);

$f_in = fopen("/etc/crontab", "r");
$crontab = Array();
$idx = 0;

while ( ! feof($f_in) )
{
	$crontab[$idx++] = fgets($f_in, 1024);
}
fclose($f_in);

$f_out = fopen("/etc/crontab", "w");
for ( $idx = 0; $idx < count($crontab); $idx++ )
{
	if ( ! strstr($crontab[$idx], "#Monitoramento") )
	{
		if ( strlen(trim($crontab[$idx])) > 0 )
		{
			fwrite($f_out, trim($crontab[$idx]) . "\n");
		}
	}
}
fwrite($f_out, "\n");

while ( $dados = $db->read($rs) )
{
	$min  = trim($dados["minutos"]);
	$hora = trim($dados["horas"]);
	$dia  = trim($dados["dias"]);
	$mes  = trim($dados["meses"]);
	$sem  = trim($dados["semanas"]);
	$prog = trim($dados["programa"]);

	$cron = "$min $hora $dia $mes $sem root $prog\t#Monitoramento";
	fwrite($f_out, $cron . "\n");
}

fclose($f_out);
?>
<html>
	<head>
		<script>
			function redir()
			{
				alert('<?=$msg?>');
				document.form1.submit();
			}
			onload=redir;
		</script>
	</head>
	<body bgcolor="#ffffff">
	<form action="<?=$action?>" method="post" name="form1">
	</form>
	</body>
</html>