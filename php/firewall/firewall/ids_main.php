<?
	require("global.php");
	require("include/db.php");
	require("include/style.css");
?>
<html>
<head>
	<title></title>
	<script>
		function sel_all(bit)
		{
			form = document.ids_form;

			if ( bit ) form.nenhum.checked = false;
			if ( !bit ) form.todos.checked = false;

			for ( i = 0; i <= (form.length -1 ); i++ )
			{
				if ( form[i].type == "checkbox" && form[i].name.substr(0,5) == "rules" )
				{
					form[i].checked = bit;
				}
			}
		}
		function limpa(form)
		{
			form.todos.checked=false
			form.nenhum.checked=false
		}
	</script>


	<?
		$db = new database;
		$db->connect();

		$str_sql = "SELECT * FROM ids_conf";
		$rs = $db->query($str_sql);

		$ide_ativo = 0;
		if ( $dados = $db->read($rs) )
		{
			$ide_ativo = intval($dados["ide_ativo"]);
			$db->free($rs);
		}

		$str_sql = "SELECT * FROM ids";
		$rs = $db->query($str_sql);
	?>
</head>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="imagens/tp_ids_config.gif" width="175" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form name="ids_form" action="ids_exec.php" method="post">
<input type="hidden" name="id" value="0">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
<?
	if ( $ide_ativo )
	{
?>
			<tr>
				<td>O sistema de detecção de intruso atualmente está <font id="font_red">ativado.&nbsp;&nbsp;</font></td>
			</tr>
			<tr>
				<td><input class="Submit" type="submit" name="acao" value="Desativar IDS"></td>
			</tr>
			<tr>
				<td>Proteção contra:&nbsp;
				    <input type="checkbox" name="todos" value=1 onclick="sel_all(1)">&nbsp;Selecionar todos&nbsp;
					<input type="checkbox" name="nenhum" value=1 onclick="sel_all(0)">&nbsp;Limpar
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" width="100%" cellpadding="1" cellspacing="1">
<?
					$dir = opendir("/etc/snort/rules");
					
					$snort_conf = array();
					
					if ( $file = fopen("/etc/snort/snort.conf", "r") )
					{
						$idx=0;
						while ( ! feof($file) )
						{
							$snort_conf[$idx++] = trim(fgets($file, 1024));
						}
					}
					fclose($file);
					unset($file);

					$count = 1;
					while ( $file = readdir($dir) )
					{
						if ( ! strstr($file, ".rules") ) continue;
						
						for ( $i = 0; $i < $idx; $i++ )
						{
							if ( strstr($snort_conf[$i], $file) )
							{
								if ( substr($snort_conf[$i], 0, 1) == "#" )
								{
									$checked = "";
								} else
								{
									$checked = "checked";
								}
								break;
							}
						}
						if ( trim($file) == "local.rules" ) continue;
						$file = trim(str_replace(".rules", "", $file));
						if ( $count == 1 )
						{
?>
						<tr>
<?
						}
						$count++;
?>
							<td><input type="checkbox" name="rules[]" onclick="limpa(this.form)" value="<?=$file?>" <?=$checked?>><?=$file?></td>
<?
						if ( $count == 4 )
						{
?>
						</tr>
<?
						$count=1;
						}
					}
					closedir($dir);
					unset($file);
					unset($dir);
?>					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><input class="Submit" type="submit" name="acao" value="Aplicar Configurações"></td>
			</tr>
<?
	} else
	{
?>
			<tr>
				<td>O sistema de detecção de intruso atualmente está <font id="font_red">desativado.&nbsp;&nbsp;</font>
			</tr>
			<tr>
				<td><input class="Submit" type="submit" name="acao" value="Ativar IDS"></td>
			</tr>
<?
	}
?>
		</table>
	</td>
</tr>
</table>
</form>
<?
	$db->close();
?>
</body>
</html>