function Graph(width, height, num_objects) 
{
	this.count_row = 0;
    this.width = width || 400;
    this.height = height || 200;
	this.num_objects = num_objects || 1;
    this.addRow = _addRowGraph;
	this.show = _showGraph;
	this.rows = new Array();
	
    return this;
}

function _addRowGraph(valor) 
{
	if ( this.count_row <=3 )
	{
		h = parseInt((this.height * valor) / 100);
		this.rows[this.count_row] = '<img src="images/' + (this.count_row + 1) + '.gif" width="_wth" height="' + h + '" alt="" border="0">';
		this.count_row++;
	}
}

function _showGraph()
{
	w = parseInt(this.width / this.num_objects / this.count_row);

	if ( this.num_objects > 1 && this.num_objects < 15)
	{
		w+=20;
	} else if ( this.num_objects > 15 ) 
	{
		w += 5;
	}
	document.writeln('<table border=0 align="center" heigth="' + this.height + '" cellpadding="0" cellspacing="0">\n');
	document.writeln('<tr>\n');
	document.writeln('<td valign="bottom"><img border="0" src="images/space.gif" width="1" height="' + this.height + '" alt="" border="0"></td>\n');
	for ( i = 0 ; i <= this.rows.length-1; i++ )
	{
		img = this.rows[i].substring(0, this.rows[i].indexOf("_wth")) + w + this.rows[i].substring( (this.rows[i].indexOf("_wth")+4), this.rows[i].length );
		document.writeln('<td valign="bottom">' + img + '</td>\n');
	}
	document.writeln('</tr>\n');
	document.writeln('</table>\n');
}
