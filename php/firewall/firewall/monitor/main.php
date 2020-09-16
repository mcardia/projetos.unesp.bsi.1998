<?
	require("global.php");
	require("include/funcoes.php");
	require("include/db.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
</head>

<?
function get_status($table)
{
        $db = new database;
        $db->db_connect();

        $str_sql  = "SELECT max(data) from estatistica LEFT JOIN tipo_servidor ON ( tipo_servidor.id = estatistica.id_tipo )";
        $str_sql .= " WHERE tipo_servidor.tipo='$table'";
        $rs = $db->db_query($str_sql);

        if ( $dados = $db->db_read($rs) )
        {
                $v_datahora = explode(" ", $dados[0]);
                $v_data = explode("-", $v_datahora[0]);
                $v_hora = explode(":", $v_datahora[1]);

                $data = "$v_data[2]/$v_data[1]/$v_data[0]";
                $hora = "$v_hora[0]:$v_hora[1]";
                unset($v_datahora); unset($v_data); unset($v_hora);
        }
        $db->db_free($rs);

        $str_sql = "SELECT id FROM $table";
        $rs = $db->db_query($str_sql);
        $cont = $db->db_count($rs);
        $db->db_free($rs);


        $str_sql = "SELECT id FROM $table WHERE id_status <> 1";
        if ( $table = "mail" )
        {
        	$str_sql = "SELECT id FROM $table WHERE id_status_smtp <> 1 OR id_status_pop3 <> 1";
        }

        $rs = $db->db_query($str_sql);
        $cont_err = $db->db_count($rs);
        $db->db_free($rs);

        $return = array("data" => "$data", "hora" => "$hora", "total" => "$cont", "total_erro" => "$cont_err");

        return $return;
}
?>

<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_webs.gif" width="258" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("../menu.html") ?>
<br>
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td>
					<table border=0 width="100%" cellpadding=1 cellspacing=1>
						<tr>
							<td width="365"><a href="frame.php?link=www">Web Servers</a></td>
							<td width="365"><a href="frame.php?link=base">DataBase Servers</a></td>
						</tr>
						<tr>
							<td>
						<?# Informações sobre o Web Server?>
						<?
						        $dados = get_status('http');
						?>
								<table id="tabela">
									<tr>
										<td><font id="font_black_b">Última análise em:</font></td>
										<td><font id="font_black"><?=$dados["data"]?> <?=$dados["hora"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Nº de Servidores:</font></td>
										<td><font id="font_black"><?=$dados["total"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Servidores com problemas:</font></td>
										<td><font id="font_red_b"><?=$dados["total_erro"]?></font></td>
									</tr>
								</table>
							</td>
							<td>
						<?# Informações sobre o DataBase Server?>
						<?
						        $dados = get_status('bases');
						?>
								<table id="tabela">
									<tr>
										<td><font id="font_black_b">Última análise em:</font></td>
										<td><font id="font_black"><?=$dados["data"]?> <?=$dados["hora"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Nº de Servidores:</font></td>
										<td><font id="font_black"><?=$dados["total"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Servidores com problemas:</font></td>
										<td><font id="font_red_b"><?=$dados["total_erro"]?></font></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td><a href="frame.php?link=mail">Mail Servers</a></td>
							<td><a href="frame.php?link=proxy">Proxy Servers</a></td>
						</tr>
						<tr>
							<td>
						<?# Informações sobre o Mail Server?>
						<?
						        $dados = get_status('mail');
						?>
								<table id="tabela">
									<tr>
										<td><font id="font_black_b">Última análise em:</font></td>
										<td><font id="font_black"><?=$dados["data"]?> <?=$dados["hora"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Nº de Servidores:</font></td>
										<td><font id="font_black"><?=$dados["total"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Servidores com problemas:</font></td>
										<td><font id="font_red_b"><?=$dados["total_erro"]?></font></td>
									</tr>
								</table>
							</td>
							<td>
						<?# Informações sobre o Proxy Server?>
						<?
						        $dados = get_status('proxy');
						?>
								<table id="tabela">
									<tr>
										<td><font id="font_black_b">Última análise em:</font></td>
										<td><font id="font_black"><?=$dados["data"]?> <?=$dados["hora"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Nº de Servidores:</font></td>
										<td><font id="font_black"><?=$dados["total"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Servidores com problemas:</font></td>
										<td><font id="font_red_b"><?=$dados["total_erro"]?></font></td>
									</tr>
								</table>
							</td>
							</td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td><a href="frame.php?link=ftp">FTP Servers</a></td>
							<td><a href="frame.php?link=outros">Outros Servidores</a></td>
						</tr>
						<tr>
							<td>
						<?# Informações sobre o FTP Server?>
						<?
						        $dados = get_status('ftp');
						?>
								<table id="tabela">
									<tr>
										<td><font id="font_black_b">Última análise em:</font></td>
										<td><font id="font_black"><?=$dados["data"]?> <?=$dados["hora"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Nº de Servidores:</font></td>
										<td><font id="font_black"><?=$dados["total"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Servidores com problemas:</font></td>
										<td><font id="font_red_b"><?=$dados["total_erro"]?></font></td>
									</tr>
								</table>
							</td>
							</td>
							<td>
						<?# Informações sobre outros servidores?>
						<?
						        $dados = get_status('outros');
						?>
								<table id="tabela">
									<tr>
										<td><font id="font_black_b">Última análise em:</font></td>
										<td><font id="font_black"><?=$dados["data"]?> <?=$dados["hora"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Nº de Servidores:</font></td>
										<td><font id="font_black"><?=$dados["total"]?></font></td>
									</tr>
									<tr>
										<td><font id="font_black_b">Servidores com problemas:</font></td>
										<td><font id="font_red_b"><?=$dados["total_erro"]?></font></td>
									</tr>
								</table>
							</td>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>

		</td>
	</tr>
</table>
</body>
</html>
