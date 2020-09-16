function trim(str)
{
	pos = 0;
	aux = str.substring(pos, pos+1);
	rt_str = str;
	while ( aux == " " && pos <= rt_str.length )
	{
		pos++;
		rt_str = str.substring(pos, str.length);
		aux = str.substring(pos, pos+1);
	}
	str = rt_str;
	pos = str.length;
	aux = str.substring(pos-1, pos);
	while ( aux == " " && pos >= 0 )
	{
		pos--;
		rt_str = str.substring(0, pos);
		aux = str.substring(pos - 1, pos);
	}
	return rt_str;
}


function get_combo_value(combo)
{
	return combo.options[combo.selectedIndex].value;
}


function get_radio_value(radio)
{

	if ( !radio.length )
	{
		if (radio.checked)
		{
			return radio.value;
		}
	} else
	{
		for ( cont = 0; cont < radio.length; cont++ )
		{
			if ( radio[cont].checked )
			{
				return radio[cont].value;
				break;
			}
		}
	}
	return 0;
}

function pop_up(url)
{
	var pop=null;
	pop = window.open(url, "popup", "toolbar=no, location=no, directories=no, status=no, scrollbars=yes, resizable=no, width=400, height=300, top=30, left=30");
	if ( pop != null )
	{
		pop.location = url;
	}
	pop.blur;
	pop.focus();
}

function pop_upw(url, w, h)
{
	var pop=null;
	pop = window.open(url, "popup", "toolbar=no, location=no, directories=no, status=no, scrollbars=yes, resizable=no, width=" + w + ", height=" + h + ", top=30, left=30");
	if ( pop != null )
	{
		pop.location = url;
	}
	pop.blur;
	pop.focus();
}

function is_ip (IPvalue) 
{
	var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
	var ipArray = IPvalue.match(ipPattern); 

	if (IPvalue == "0.0.0.0") return(true);
	else if (IPvalue == "255.255.255.255") return(false);

	if (ipArray == null)
	{
		return(false);
	} else 
	{
		for (i = 0; i < 4; i++) 
		{
			thisSegment = ipArray[i];
			if (thisSegment > 255) 
			{
				return(false);
			}
			if ((i == 0) && (thisSegment > 255)) 
			{
				return(false);
		    }
   		}
   }
   return(true);
}

function subnet_calc(netmask)
{
	mask = netmask.split(".");
	mask[0] = snmcorrect(mask[0]); 
	if (mask[0] < 255)
		{
		mask[1] = 0;
		mask[2] = 0;
		mask[3] = 0;
		}
	else	
		{
		mask[1] = snmcorrect(mask[1]); 
		if (mask[1] < 255)
			{
			mask[0] = 255;
			mask[2] = 0;
			mask[3] = 0;
			}
		else
			{
			mask[2] = snmcorrect(mask[2]); 
			if (mask[2] < 255)
				{
				mask[0] = 255;
				mask[1] = 255;
				mask[3] = 0;
				}
			else
				{
				mask[3] = snmcorrect(mask[3]); 
				}
			}
		}
		
	bits=0;
	bits=bits+d2bits(mask[0]);
	bits=bits+d2bits(mask[1]);
	bits=bits+d2bits(mask[2]);
	bits=bits+d2bits(mask[3]);
	return(bits);
}

function snmcorrect(decimal)
{
	snmcorr = decimal;
	if (decimal > 255) snmcorr = 255;
	if (decimal == 253) snmcorr = 254;
	if ((decimal > 248)  && (decimal < 252)) snmcorr = 252;
	if ((decimal > 240)  && (decimal < 248)) snmcorr = 248;
	if ((decimal > 224)  && (decimal < 240)) snmcorr = 240;
	if ((decimal > 192)  && (decimal < 224)) snmcorr = 224;
	if ((decimal > 128)  && (decimal < 192)) snmcorr = 192;
	if ((decimal > 0)  && (decimal < 128)) snmcorr = 128;
	if (decimal < 0) snmcorr = 0;
	return (snmcorr);
}

function d2bits(decimal)
{		
	var bits=0;				
	if (decimal & 128) { bits = bits + 1 }		
	if (decimal & 64) { bits = bits + 1 }		
	if (decimal & 32) { bits = bits + 1 }		
	if (decimal & 16) { bits = bits + 1 }		
	if (decimal & 8) { bits = bits + 1 }		
	if (decimal & 4) { bits = bits + 1 }		
	if (decimal & 2) { bits = bits + 1 }		
	if (decimal & 1) { bits = bits + 1 }				
	return (bits);	
}

function get_network(form)
{
	if (form.oct1.value > 255) form.oct1.value=255;
	if (form.oct2.value > 255) form.oct2.value=255;
	if (form.oct3.value > 255) form.oct3.value=255;
	if (form.oct4.value > 255) form.oct4.value=255;
	if (form.mask1.value > 255) form.mask1.value=255;
	if (form.mask2.value > 255) form.mask2.value=255;
	if (form.mask3.value > 255) form.mask3.value=255;
	if (form.mask4.value > 255) form.mask4.value=255;
	
	form.net1.value = eval(form.mask1.value & form.oct1.value);
	form.net2.value = eval(form.mask2.value & form.oct2.value);
	form.net3.value = eval(form.mask3.value & form.oct3.value);
	form.net4.value = eval(form.mask4.value & form.oct4.value);
	form.cast1.value = ((form.net1.value) ^ (~ form.mask1.value) & 255);
	form.cast2.value = ((form.net2.value) ^ (~ form.mask2.value) & 255);
	form.cast3.value = ((form.net3.value) ^ (~ form.mask3.value) & 255);
	form.cast4.value = ((form.net4.value) ^ (~ form.mask4.value) & 255);
}
