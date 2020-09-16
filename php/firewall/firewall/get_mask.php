<html>
<head>
	<title>Untitled</title>
	<link href="include/style.css" rel="stylesheet">
	<script src="include/funcoes.js" language="JavaScript"></script>
	<script>
		function set_mask(form)
		{
			mask  = form.mask1.value + ".";
			mask += form.mask2.value + ".";
			mask += form.mask3.value + ".";
			mask += form.mask4.value;
			opener.document.form.<?=trim($campo)?>.value = subnet_calc(mask);
			window.close();
		}
		
		function next(atual, proximo)
		{
			form_name = atual.form.name;
			size = atual.value.length;
			muda = false;
			if ( atual.value.substr(size - 1, size) == "." )
			{
				atual.value = atual.value.substr(0, size - 1);
				muda = true;
			}
		    eval('proximo=document.' + form_name + '.' + proximo);
			if ( (atual.value.length > 2) || (muda) )
			{
				proximo.focus();
			}
		}
	</script>
</head>

<body>
<form name="get_mask">
<table width="100%" align="center">
<tr>
	<td align="center">Digite a máscara da rede:</td>
</tr>
<tr>
	<td align="center"><input type="text" name="mask1" value="255" onkeyup="next(this, 'mask2')" size="4"><input type="text" name="mask2" value="255" onkeyup="next(this, 'mask3')" size="4"><input type="text" name="mask3" value="255" onkeyup="next(this, 'mask4')" size="4"><input type="text" name="mask4" value="255" onkeyup="next()" size="4"></td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td align="center"><input type="Button" name="set_" value="&nbsp;&nbsp;OK&nbsp;&nbsp;" onclick="set_mask(this.form)"></td>
</tr>
</table>
</form>
</body>
</html>
