<?
$DB_HOST = "localhost";
$DB_BASE = "firewall";
$DB_USER = "sa";
$DB_PASS = "bdadmin";


function start_service($service)
{
	$db = new database;
	$db->connect();
	
	$str_sql = "INSERT INTO controle ( servico, acao ) VALUES ('$service', 'start')";
	$db->query($str_sql);
	
	$db->close();
}

function stop_service($service)
{
	$db = new database;
	$db->connect();
	
	$str_sql = "INSERT INTO controle ( servico, acao ) VALUES ('$service', 'stop')";
	$db->query($str_sql);
	
	$db->close();
}

function reload_service($service)
{
	$db = new database;
	$db->connect();
	
	$str_sql = "INSERT INTO controle ( servico, acao ) VALUES ('$service', 'reload')";
	$db->query($str_sql);
	
	$db->close();
}

function restart_service($service)
{
	$db = new database;
	$db->connect();
	
	$str_sql = "INSERT INTO controle ( servico, acao ) VALUES ('$service', 'restart')";
	$db->query($str_sql);
	
	$db->close();
}

function get_next_ord($tabela)
{
        global $db;

        $str_sql = "SELECT max(ordem) AS ordem FROM $tabela";
        $rs = $db->query($str_sql);

        if ( $linha = $db->read($rs) )
        {
                $nx = intval($linha["ordem"]);
        } else
        {
                $nx = 0;
        }
        $nx++;
        unset($str_sql);
        $db->free($rs);
        unset($rs);

        return $nx;
}

function get_max_ord($tabela)
{
	global $db;

    $str_sql = "SELECT max(ordem) AS ordem FROM $tabela";
    $rs = $db->query($str_sql);

    if ( $linha = $db->read($rs) )
    {
            $nx = intval($linha["ordem"]);
    } else
    {
            $nx = 0;
    }
    unset($str_sql);
    $db->free($rs);
    unset($rs);

    return $nx;
}

function grava_firewall()
{
	global $DB_USER, $DB_BASE, $DB_PASS, $DB_HOST;
	
		$db = new database;
		$db->connect();
		
		$str_sql = "SELECT cmd_iptables FROM regras ORDER BY ordem";
		$rs = $db->query($str_sql);

		$str_sql = "SELECT cmd_iptables FROM nat ORDER BY ordem";
		$rs_nat = $db->query($str_sql);

		$str_sql = "SELECT cmd_iptables FROM ctr_pais ORDER BY ordem";
		$rs_pais = $db->query($str_sql);
		
		if ( $file = fopen("/etc/sysconfig/firewall/functions", "w") )
		{
			fwrite($file, "clean() {\n");
			fwrite($file, "\t/usr/sbin/iptables -t nat -F\n");
			fwrite($file, "\t/usr/sbin/iptables -F\n");
			fwrite($file, "}\n\n");
#NAT
			fwrite($file, "nat() {\n");
			while ( $dados = $db->read($rs_nat) )
			{
				fwrite($file, "\t" . trim($dados["cmd_iptables"]). "\n");
			}
			while ( $dados = $db->read($rs_pais) )
			{
				fwrite($file, "\t" . trim($dados["cmd_iptables"]). "\n");
			}
			fwrite($file, "}\n\n");
			
#FIREWALL			
			fwrite($file, "firewall() {\n");
			while ( $dados = $db->read($rs) )
			{
				fwrite($file, "\t" . trim($dados["cmd_iptables"]). "\n");
			}
			if ( $db->count($rs) == 0 )
			{
				fwrite($file, "echo\n");
			}
			fwrite($file, "}\n\n");
			
			fclose($file);
			$db->free($rs);
			$db->free($rs_nat);
		}
		
		$db->close();
}

function grava_interfaces()
{
	global $DB_USER, $DB_BASE, $DB_PASS, $DB_HOST;
	
		$db = new database;
		$db->connect();

		$str_sql = "SELECT * FROM interfaces ORDER BY des_if";
		$rs = $db->query($str_sql);
		
		while ( $dados = $db->read($rs) )
		{
			$device = trim($dados["des_if"]);
			$ipaddr = trim($dados["num_ip"]);
			$netmask = trim($dados["num_mask"]);
			$gateway = trim($dados["num_gateway"]);
			
			if ( intval($dados["ide_dhcp"]) )
			{
				$buffer  = "DEVICE=$device\n";
				$buffer .= "ONBOOT=yes\n";
				$buffer .= "BOOTPROTO=dhcp\n";
			} else
			{
				$buffer = "DEVICE=$device\n";
				$buffer .= "ONBOOT=yes\n";
				$buffer .= "BOOTPROTO=static\n";
				$buffer .= "IPADDR=$ipaddr\n";
				$buffer .= "NETMASK=$netmask\n";
				if ( (strlen($gateway) > 0) && (trim($gateway) != "...") )
				{
					$buffer .= "GATEWAY=$gateway\n";
				}
			}
			$file_name = "/etc/sysconfig/network-scripts/ifcfg-$device";
			
			if ( $file = fopen($file_name, "w") )
			{
				fwrite( $file, $buffer );
				fclose( $file );
			}
		}
	$db->close();
}

function grava_conf($ide_auth)
{
	if ( intval($ide_auth) )
	{
		$file_name_in = "/etc/squid/squid.conf.auth";
	} else
	{
		$file_name_in = "/etc/squid/squid.conf.noauth";
	}
	$file_name_out = "/etc/squid/squid.conf";
	
	if ( ($file_in = fopen($file_name_in, "r")) && ($file_out = fopen($file_name_out, "w")) )
	{
		while ( ! feof($file_in) )
		{
			$buffer = trim(fgets($file_in, 1024)) . "\n";
			fwrite($file_out, $buffer);
		}
		fclose($file_in);
		fclose($file_out);
	}
}


function grava_usuarios()
{
	global $DB_USER, $DB_BASE, $DB_PASS, $DB_HOST;
	
	$db = new database;
	$db->connect();

	$str_sql = "SELECT * FROM proxy_users";
	$rs = $db->query($str_sql);
	$cont = 1;
	
	system("rm -f /etc/squid/auth/users*");
	$f_user = fopen("/etc/squid/auth/users", "w");
	while ( $dados = $db->read($rs) )
	{
		if ( $cont == 1 )
		{
			$cmd = "/home/httpd/bin/htpasswd -b -c /etc/squid/auth/users.pwd ";
			$cmd.= trim($dados["usuario"]) . " " . trim($dados["senha"]);
			$cont++;
		} else
		{
			$cmd = "/home/httpd/bin/htpasswd -b /etc/squid/auth/users.pwd ";
			$cmd.= trim($dados["usuario"]) . " " . trim($dados["senha"]);
		}
		fwrite($f_user, trim($dados["usuario"]) . "\n");
		system($cmd);
	}
	fclose($f_user);
	$db->close();
}

function grava_ids()
{
	global $DB_USER, $DB_BASE, $DB_PASS, $DB_HOST;
	
	$db = new database;
	$db->connect();

	if ( $file = fopen("/etc/snort/rules/local.rules", "w") )
	{
		$str_sql = "SELECT des_alert FROM ids ORDER by des_alert";
		$rs = $db->query($str_sql);
		while ( $linha = $db->read($rs) )
		{
			fwrite($file, trim($linha["des_alert"]) . "\n");
		}
		fclose($file);
		$db->free($rs);
	}
	
	$db->close();
}

function grava_dhcp()
{
	global $DB_USER, $DB_BASE, $DB_PASS, $DB_HOST;
	
	$db = new database;
	$db->connect();

	if ( $file = fopen("/etc/dhcpd.conf", "w") )
	{
		fwrite($file, "default-lease-time 600;\n");
		fwrite($file, "max-lease-time 7200;\n\n");
		$str_sql = "SELECT * FROM interfaces ORDER BY des_if";
		$rs = $db->query($str_sql);
		while ( $linha = $db->read($rs) )
		{
			$subnet = trim($linha["num_network"]);
			$netmask = trim($linha["num_mask"]);
			$broadcast = trim($linha["num_broadcast"]);
			$ip = trim($linha["num_ip"]);
			$ide_dhcp_serv = intval($linha["ide_dhcp_serv"]);

			$octetos = explode(".", $ip);
			$net_octetos = explode(".", $subnet);
			$cast_octetos = explode(".", $broadcast);
			
			$ip_first = "$net_octetos[0].$net_octetos[1].$net_octetos[2]." . (intval($net_octetos[3]) + 1);
			$first = ( intval($net_octetos[3]) + 1);
			$ip_last  = "$cast_octetos[0].$cast_octetos[1].$cast_octetos[2]." . (intval($cast_octetos[3]) - 1);
			$last  = ( intval($cast_octetos[3]) - 1);
			
			if ( intval($octetos[3]) == $first )
			{
				$range1 = "$octetos[0].$octetos[1].$octetos[2]." . ($first+1) . " $ip_last";
				$range2 = "";
			} else
			{
				if ( intval($octetos[3]) == $last )
				{
					$range1 = "$ip_first $octetos[0].$octetos[1].$octetos[2]." . ($last-1);
					$range2 = "";
				} else
				{
					$range1 = "$ip_first $octetos[0].$octetos[1].$octetos[2]." . (intval($octetos[3])-1);
					$range2 = "$octetos[0].$octetos[1].$octetos[2]." . (intval($octetos[3])+1) . " $ip_last";
				}
			}
			
			fwrite($file, "subnet $subnet netmask $netmask {\n");

			if ( $ide_dhcp_serv )
			{
			    fwrite($file,  "\trange $range1;\n");
				if ( strlen(trim($range2)) > 0 )
				{
					fwrite($file,  "\trange $range2;\n");
				}
	        	fwrite($file,  "\toption subnet-mask $netmask;\n");
	        	fwrite($file,  "\toption broadcast-address $broadcast;\n");
	        	fwrite($file,  "\toption routers $ip;\n");
	        	fwrite($file,  "\toption domain-name-servers $ip;\n");
	        	fwrite($file,  "\toption domain-name \"lan\";\n");
			}
			fwrite($file,  "}\n\n");
		}
		fclose($file);
		$db->free($rs);
	}
	
	$db->close();
}
?>
