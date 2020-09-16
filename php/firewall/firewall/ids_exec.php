<?
        require("global.php");
        require("include/db.php");

		$db = new database;
		$db->connect();
		
        intval($ide_ativo)?$ide_ativo=1:$ide_ativo=0;
        intval($num_maskin)?$num_maskin=intval($num_maskin):$num_maskin=0;
        intval($num_maskout)?$num_maskout=intval($num_maskout):$num_maskout=0;
		
		$str_sql = "SELECT * FROM ids_conf";
		$rs = $db->query($str_sql);
		$c = $db->count($rs);
		$db->free($rs);
		
        if ( strtolower($acao) == "ativar ids" )
        {
			if ( $c == 0 )
			{
				$str_sql = "INSERT INTO ids_conf VALUES(1)";
			} else
			{
				$str_sql = "UPDATE ids_conf SET ide_ativo=1";
			}
			$db->query($str_sql);
			$msg = "IDS Ativado";
			
			start_service("snortd");
        }

        if ( strtolower($acao) == "desativar ids" )
        {
			if ( $c == 0 )
			{
				$str_sql = "INSERT INTO ids_conf VALUES(0)";
			} else
			{
				$str_sql = "UPDATE ids_conf SET ide_ativo=0";
			}
			$db->query($str_sql);
			$msg = "IDS Desativado";

			stop_service("snortd");
        }
		
		
        if ( strtolower($acao) == "excluir" )
        {
            $str_sql = "DELETE FROM ids WHERE id=" . trim($id);
			$db->query($str_sql);
			$msg = "Regra excluída com sucesso.";
			$msg_erro = "Não foi possível excluir esta regra.";
			grava_ids();

			$str_sql = "SELECT ide_ativo FROM ids_conf";
			$rs = $db->query($str_sql);
			
			if ( $dados = $db->read($rs) )
			{
				if ( intval($dados["ide_ativo"]) )
				{
					restart_service("snortd");
				}
			}
			$db->free($rs);
        }

        if ( strtolower($acao) == "aplicar configurações" )
        {
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
			
			$i = 0;
			$flag = false;
			
			if ( $new_conf = fopen("snort.conf", "w") )
			{
				while ( $i < $idx )
				{
					if ( $flag && (strlen(trim($snort_conf[$i])) > 0) )
					{
						$v_regra = explode("/", $snort_conf[$i]);
						$regra = trim(str_replace(".rules", "", $v_regra[1]));
						$ignore = true;
						for ( $j = 0; $j < count($rules); $j++ )
						{
							if ( trim($rules[$j]) == trim($regra) )
							{
								$ignore = false;
								break;
							}
						}
						
						if ( $regra == "local" ) $ignore = false;
						
						if ( $ignore )
						{
							$snort_conf[$i] = "#" . $snort_conf[$i];
						} else
						{
							$snort_conf[$i] = str_replace("#", "", $snort_conf[$i]);
						}
					}
	
					fwrite($new_conf, $snort_conf[$i] . "\n");
	
					if ( strstr($snort_conf[$i], "classification.config") )
					{
						$flag = true;
					}
					$i++;
				}
			}
			if ( $new_conf ) 
			{
				fclose($new_conf);
			}
			if ( ! rename( "snort.conf", "/etc/snort/snort.conf" ) )
			{
				$msg = "Não foi possível aplicar as alterações";
			} else
			{
				$msg = "Alteração efetuada com sucesso.";
			}
			
			restart_service("snortd");
        }

        if ( strtolower($acao) == "inserir" )
        {
			$des_alert = "alert tcp $num_ipin";
			if ( intval($num_maskin) )
			{
				$des_alert .= "/$num_maskin";
			}
			$des_alert .= " $num_portin";
			$des_alert .= " -> ";
			$des_alert .= "$num_ipout";
			if ( intval($num_maskout) )
			{
				$des_alert .= "/$num_maskout";
			}
			$des_alert .= " $num_portout";
			$des_alert .= " (content:\"$conteudo\"; msg:\"$msg\";) ";
			
			if ( trim($num_portin) == "any" ) $num_portin=0;
			if ( trim($num_portout) == "any" ) $num_portout=0;
			
		    $str_sql  = "INSERT INTO ids ";
            $str_sql .= "(num_ipin, num_maskin, num_portin,";
            $str_sql .= " num_ipout, num_maskout, num_portout,";
            $str_sql .= " content, msg, des_alert)";
            $str_sql .= "VALUES ";
            $str_sql .= "('$num_ipin', $num_maskin, $num_portin,";
            $str_sql .= " '$num_ipout', $num_maskout, $num_portout,";
            $str_sql .= " '$conteudo', '$msg', '$des_alert')";
			$db->query($str_sql);
			$msg = "Regra inserida com sucesso.";
			grava_ids();

			$str_sql = "SELECT ide_ativo FROM ids_conf";
			$rs = $db->query($str_sql);
			
			if ( $dados = $db->read($rs) )
			{
				if ( intval($dados["ide_ativo"]) )
				{
					restart_service("snortd");
				}
			}
			$db->free($rs);
		}

        $db->close();
		
		$action="ids_main.php";
		if ( strtolower($acao) == "inserir" || strtolower($acao) == "excluir" )
		{
		   $action="ids.php";
		}
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