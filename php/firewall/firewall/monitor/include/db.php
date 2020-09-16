<?
class database 
{
	var $conn;

	function db_connect()
	{
		global $DB_HOST, $DB_BASE, $DB_USER, $DB_PASS;
		$con_str="host=$DB_HOST dbname=$DB_BASE user=$DB_USER password=$DB_PASS";
		$this->conn=pg_pconnect($con_str) or die("Nao foi possivel conectar como banco de dados\n");
		$this->$num_query = 0;
	}
	
	function db_close()
	{
		pg_close($this->conn);
	}

	function db_query($str_sql)
	{
		return pg_exec($this->conn, $str_sql);
	}
	
	function db_read(&$rs)
	{
		return pg_fetch_array($rs);
	}

	function db_count(&$rs)
	{
		return pg_numrows($rs);
	}

	function db_affected(&$rs)
	{
		return pg_cmdtuples($rs);
	}

	function db_free(&$rs)
	{
		pg_freeresult($rs);
	}

	function db_first(&$rs)
	{
		pg_seek($rs, 0);
	}

	function db_erro()
	{
		return 0;
	}

	function db_get_last_id()
	{
		return pg_getlastoid($this->conn);
	}
}
?>
