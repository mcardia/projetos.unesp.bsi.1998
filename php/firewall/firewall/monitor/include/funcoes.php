<?
	function space($size)
	{
?>
		<td width="<?=$size?>" rowspan="100"><img src="images/space.gif" width="<?=$size?>" hspace="0" vspace="0" height="0" alt="" border="0"></td>
<?
	}

	function show_message($texto, $action)
	{
?>
		<script>
			function redir()
			{
				alert('<?=$texto?>');
				document.form1.submit();
			}
			onload=redir;
		</script>
		<form action="<?=$action?>" method="post" name="form1">
		</form>
<?
	}
?>
