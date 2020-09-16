<?
	require("global.php");
	require("./include/db.php");
	require("./include/funcoes.php");
	require("../include/style.css");
?>
<html>
<head>
	<title>Untitled</title>
	<script language="JavaScript1.2" src="include/funcoes.js"></script>
	<script>
		function ver()
		{
			document.estat.target="lis";
			document.estat.action="lis_estat.php";
			if ( check_form(document.estat) )
			{
				document.estat.submit();
			}
		}
		function atualiza()
		{
			document.estat.target="cad";
			document.estat.action="cad_estat.php";
			document.estat.submit();
		}
		function check_form(form)
		{
			idx = form.id_tipo.options.selectedIndex;
			id_tipo = parseInt(form.id_tipo.options[idx].value);
			idx = form.id_servidor.options.selectedIndex;
			id_servidor = parseInt(form.id_servidor.options[idx].value);

			if ( ! id_tipo ) 
			{
				alert("Escolha o Tipo do Servidor");
				return(false);
			}
			if ( ! id_servidor )
			{
				alert("Escolha o Servidor");
				return(false);
			}
			
			if ( form.data.value.length > 0 )
			{
				data = form.data.value.split("/");
				if ( data[0].length == 1 ) data[0] = "0" + data[0];
				if ( data[1].length == 1 ) data[1] = "0" + data[1];
				if ( data[2].length == 1 ) data[2] = "0" + data[2];
				form.data.value = data[0] + "/" + data[1] + "/" + data[2];
			}
   		    if ( ! is_data(form.data) )
			{
				return(false);
			}
			return(true);
		}
		
	</script>
</head>
<?
	$db = new database;
	
	$db->db_connect();
	
	$str_sql = "SELECT * FROM tipo_servidor ORDER BY id";
	$rs_tipo = $db->db_query($str_sql);

	switch (trim($id_tipo))
	{
		case 1 : $tabela = "http"; break;
		case 2 : $tabela = "mail"; break;
		case 3 : $tabela = "proxy"; break;
		case 4 : $tabela = "bases"; break;
		case 5 : $tabela = "ftp"; break;
                case 6 : $tabela = "outros"; break;
		default: break;
	}

	if ( isset($id_tipo) )
	{
		$str_sql = "SELECT id, servidor FROM $tabela ORDER BY servidor";
		$rs_serv = $db->db_query($str_sql);
	}
?>
<body bgcolor="#ffffff" onload="init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="#CC0033">
		<td bgcolor="#CC0033" align="right"><img src="../imagens/tp_monitor_estatist.gif" width="248" height="17" alt="" border="0"></td>
	</tr>
</table>
<? require("menu.html") ?>
<form action="cad_estat.php" method="post" name="estat">
<table width="600" border=0 align="center" id="tabela">
	<tr valign="top">
		<td align="center">
			<table border=0 width="100%" cellpadding=5 cellspacing=5>
			<tr>
				<td width="30%"><font id="font_bold">Tipo</font></td>
				<td width="25%"><font id="font_bold">Servidor</font></td>
				<td><font id="font_bold">Data</font></td>
			</tr>
			<tr>
				<td><select class="Text" name="id_tipo" onchange="atualiza()">
					<option value=0></option>
	<?
			while ( $linha = $db->db_read($rs_tipo) )
			{
				switch (trim($linha["tipo"]))
				{
					case "bases" : $tipo = "DataBase Servers"; break;
					case "mail"    : $tipo = "Mail Servers"; break;
					case "ftp"      : $tipo = "FTP Servers"; break;
					case "http"     : $tipo = "Web Servers"; break;
					case "proxy"    : $tipo = "Proxy Servers"; break;
                                        case "outros"   : $tipo = "Outros Servidores"; break;
					default: break;
				}
				if ( trim($linha["id"]) == $id_tipo )
				{
					$sel = "selected ";
				} else
				{
					unset($sel);
				}
	?>
					<option <?=$sel?>value="<?=trim($linha["id"])?>"><?=$tipo?></option>
	<?
			}
			$db->db_free($rs_tipo);
	?>
					</select>
				</td>
				<td><select class="Text" name="id_servidor">
						<option value=0></option>
	<?
		if ( isset($id_tipo) )
		{
			while ( $linha = $db->db_read($rs_serv) )
			{
	?>
						<option value="<?=trim($linha["id"])?>"><?=trim($linha["servidor"])?></option>
	<?
			}
			$db->db_free($rs_serv);
		}
			$db->db_close();
	?>
					</select>
				</td>
				<td><input type="text" name="data" value="" class="Text" size="15"></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><input type="button" name="visualizar"   value="Mostrar Estatística" class="Submit" onclick="ver()"></td>
	</tr>
</table>
</form>
</body>
</html>
