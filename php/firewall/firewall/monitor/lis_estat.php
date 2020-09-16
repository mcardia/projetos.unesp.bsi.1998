<?
	require("global.php");
	require("include/funcoes.php");
	require("include/db.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
	<script src="include/graph.js"></script>
</head>
<?
$db = new database;

$db->db_connect();

$mes_ext = Array ("", "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro");

if ( isset($data) && strlen(trim($data)) > 0 )
{
	$v_data = explode("/", $data);
	$dia = trim($v_data[0]);
	$mes = trim($v_data[1]);
	$ano = trim($v_data[2]);
	$data_hoje = date("Y-m-d", mktime(0,0,0,$mes, $dia, $ano));
} else
{
	$data_hoje = date("Y-m-d");
	$dia = date("d");
	$mes = date("m");
	$ano = date("Y");
}
if ( !isset($id_tipo) || !isset($id_servidor) )
{
?>
	<body bgcolor="#ffffff" leftmargin="33" topmargin="0" marginwidth="0" marginheight="0">
	</body>
<?
} else
{
		
	$erro = 0;
	$ok   = 0;

	$achou = false;
	
	while ( ! $achou )
	{
		$data_base = date ("Y-m-d", mktime (0,0,0,$mes,$dia-7,$ano));
		$str_sql  = "SELECT * FROM estatistica ";
		$str_sql .= "WHERE id_tipo=$id_tipo";
		$str_sql .= "  AND id_servidor=$id_servidor";
		$str_sql .= "  AND data > '$data_base'";
		$str_sql .= "  AND data <= '$data_hoje'";
		$str_sql .= "  ORDER BY data ASC";
		$rs_semana = $db->db_query($str_sql);
		if ( $db->db_count($rs_semana) == 0 )
		{
			$dia--;
			if ( $dia == 0 )
			{
				$dia = 31;
				$mes--;
			}
			$db->db_free($rs_semana);
		} else
		{
			$achou = true;
		}
	}
	$data_base = date ("Y-m-d", mktime (0,0,0,$mes,1,$ano));
	$str_sql  = "SELECT * FROM estatistica ";
	$str_sql .= "WHERE id_tipo=$id_tipo";
	$str_sql .= "  AND id_servidor=$id_servidor";
	$str_sql .= "  AND data > '$data_base'";
	$str_sql .= "  AND data <= '$data_hoje'";
	$str_sql .= "  ORDER BY data ASC";
	$rs_mes = $db->db_query($str_sql);
?>

<body bgcolor="#ffffff" leftmargin="33" topmargin="0" marginwidth="0" marginheight="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
<?

if ( ($db->db_count($rs_semana) == 0) || ($db->db_count($rs_mes) == 0) )
{
?>
			<tr>
				<td colspan="7" align="center">
					<font id="font_black_b">Nenhum Registro encontrado</font>
				</td>
			</tr>
<?
} else
{
?>
			<tr>
				<td colspan="7">
					<img src="images/space.gif" width="20" height="1" alt="" border="0"><font id="font_black_b">Legenda:</font>
				</td>
			</tr>
			<tr>
				<td colspan="7">
					<img src="images/space.gif" width="30" height="1" alt="" border="0"><img src="images/1.gif" width="9" height="9" alt="" border="0"><font id="font_black"> - Normal</font>
					<img src="images/2.gif" width="9" height="9" alt="" border="0"><font id="font_black"> - Erro</font>
				</td>
			</tr>
			<tr>
				<td colspan="7" align="center"><font id="font_black_b">Estatística Diária: Mês de <?=$mes_ext[intval($mes)]?></font></td>
			</tr>
			<tr>
<?
	$sem_erro = 0; $sem_ok = 0;
	while ( $linha = $db->db_read($rs_semana) )
	{
		$v_data = explode("-", trim($linha["data"]));
		$ano = $v_data[0];
		$mes = $v_data[1];
		$v_dia = explode(" ", trim($v_data[2]));
		$dia = trim($v_dia[0]);

		$sem_erro += $linha["erros"];
		$sem_ok   += $linha["ok"];

		$erro = $linha["erros"];
		$ok   = $linha["ok"];
		
		$total = $erro + $ok;
		$erro_semana = intval(round(($erro / $total) * 100));
		$ok_semana   = intval(round(($ok / $total) * 100));
?>
				<td align="left">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left">
								<script>
									g = new Graph(50, 100, 7);
									g.addRow(<?=$ok_semana?>);
									g.addRow(<?=$erro_semana?>);
									g.show();
								</script>
							</td>
						</tr>
						<tr align="left">
							<td><img src="images/space.gif" width="7" height="1" alt="" border="0"><font id="font_black_b">Dia:</font><font id="font_black"><?=$dia?></font></td>
						</tr>
						<tr align="left">
							<td><img src="images/space.gif" width="7" height="1" alt="" border="0"><img src="images/1.gif" width="9" height="9" alt="" border="0"><font id="font_black"><?=$ok_semana?>%</font></td>
						</tr>
						<tr align="left">
							<td><img src="images/space.gif" width="7" height="1" alt="" border="0"><img src="images/2.gif" width="9" height="9" alt="" border="0"><font id="font_black"><?=$erro_semana?>%</font></td>
						</tr>
					</table>
				</td>
<?
	}
?>
			</tr>
			<tr>
				<td colspan="7">&nbsp;</td>
			</tr>
			<tr>
<?
	$erro = $sem_erro;
	$ok = $sem_ok;
	
	
	$db->db_free($rs_semana);
	
	$total = $erro + $ok;
	$erro_semana = intval(round(($erro / $total) * 100));
	$ok_semana   = intval(round(($ok / $total) * 100));

	$erro = 0; $ok = 0;
	while ( $linha = $db->db_read($rs_mes) )
	{
		$erro += $linha["erros"];
		$ok   += $linha["ok"];
	}
	$db->db_free($rs_mes);
	$total = $erro + $ok;
	$erro_mes = intval(round(($erro / $total) * 100));
	$ok_mes   = intval(round(($ok / $total) * 100));
?>
				<td align="center" colspan="7">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><font id="font_black_b">Estatística da Semana</font></td>
							<td align="center"><font id="font_black_b">Estatística do Mês</font></td>
						</tr>
						<tr>
						<td align="center"><script>
								g = new Graph(100, 100, 1)
								g.addRow(<?=$ok_semana?>);
								g.addRow(<?=$erro_semana?>);
								g.show();
							</script>
						</td>
						<td align="center"><script>
								g = new Graph(100, 100, 1)
								g.addRow(<?=$ok_mes?>);
								g.addRow(<?=$erro_mes?>);
								g.show();
							</script>
						</td>
					</tr>
					<tr align="left">
						<td><img src="images/space.gif" width="150" height="1" alt="" border="0"><img src="images/1.gif" width="9" height="9" alt="" border="0"><font id="font_black"><?=$ok_semana?>%</font></td>
						<td><img src="images/space.gif" width="150" height="1" alt="" border="0"><img src="images/1.gif" width="9" height="9" alt="" border="0"><font id="font_black"><?=$ok_mes?>%</font></td>
					</tr>
					<tr align="left">
						<td><img src="images/space.gif" width="150" height="1" alt="" border="0"><img src="images/2.gif" width="9" height="9" alt="" border="0"><font id="font_black"><?=$erro_semana?>%</font></td>
						<td><img src="images/space.gif" width="150" height="1" alt="" border="0"><img src="images/2.gif" width="9" height="9" alt="" border="0"><font id="font_black"><?=$erro_mes?>%</font></td>
					</tr>
				</table>
			</td>
			</tr>
<?
}
?>
		</table>
	</td>
</tr>
</table>
</body>
<?
}
?>
</html>
