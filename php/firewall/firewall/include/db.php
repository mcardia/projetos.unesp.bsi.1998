<?
class database 
{
	var $conn;

	function connect()
	{
		global $DB_HOST, $DB_BASE, $DB_USER, $DB_PASS;
		$con_str="host=$DB_HOST dbname=$DB_BASE user=$DB_USER password=$DB_PASS";
		$this->conn=pg_pconnect($con_str) or die("Nao foi possivel conectar como banco de dados\n");
		$this->$num_query = 0;
	}
	
	function close()
	{
		pg_close($this->conn);
	}

	function query($str_sql)
	{
		return pg_exec($this->conn, $str_sql);
	}
	
	function read(&$rs)
	{
		return pg_fetch_array($rs);
	}

	function count(&$rs)
	{
		return pg_numrows($rs);
	}

	function affected(&$rs)
	{
		return pg_cmdtuples($rs);
	}

	function free(&$rs)
	{
		pg_freeresult($rs);
	}

	function first(&$rs)
	{
		pg_lo_seek($rs, 0);
	}

	function erro()
	{
		return 0;
	}

	function get_last_id(&$rs)
	{
		return pg_getlastoid($rs);
	}
}
?>
