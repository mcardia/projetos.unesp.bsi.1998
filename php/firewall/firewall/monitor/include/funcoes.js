function is_email (emailStr) {
	var Mensagem = "Email";
    var emailPat=/^(.+)@(.+)$/;
    var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
    var validChars="\[^\\s" + specialChars + "\]";
    var quotedUser="(\"[^\"]*\")";
    var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
    var atom=validChars + '+';
    var word="(" + atom + "|" + quotedUser + ")";
    var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
    var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
    var matchArray=emailStr.match(emailPat);
    if (matchArray==null) {
        alert(Mensagem + ' incorreto. Por favor, digite novamente.');
        return false;
    }
    var user=matchArray[1];
    var domain=matchArray[2];
    if (user.match(userPat)==null) {
        alert(Mensagem + ' incorreto. Por favor, digite novamente.')
        return false;
    }
    var IPArray=domain.match(ipDomainPat);
    if (IPArray!=null) {
        for (var i=1;i<=4;i++) {
            if (IPArray[i]>255) {
                alert(Mensagem + ' incorreto. Por favor, digite novamente.');
                return false;
            }
        }
        return true;
    }
    var domainArray=domain.match(domainPat);
    if (domainArray==null) {
        alert(Mensagem + ' incorreto. Por favor, digite novamente.');
        return false;
    }
    var atomPat=new RegExp(atom,"g");
    var domArr=domain.match(atomPat);
    var len=domArr.length;
    if (domArr[domArr.length-1].length<2 || domArr[domArr.length-1].length>3) {
       alert(Mensagem + ' incorreto. Por favor, digite novamente.');
       return false;
    }
    if (len<2) {
        var errStr=Mensagem + ' incorreto. Por favor, digite novamente.';
        alert(errStr);
        return false;
    }
    return true;
}

function is_data(data1)
{
	desData = "Data";
	formato = "dd/mm/aaaa";
    data = data1.value;
    Erro = '';
    barra1 = data.substring(2,3);
    barra2 = data.substring(5,6);

	if ( data.length == 0 ) return(true);
	    
    if ( (barra1 != '/') || (barra2 != '/'))
    {
        alert('Formato inválido para ' + desData + '. Por favor, digite novamente.');
        data1.value = '';
        data1.focus();
        return false; 
    }
    
    if (formato == 'dd/mm/aaaa') 
    {
        dia = data.substring (0, 2);
        mes = data.substring (3, 5);
        ano = data.substring (6, 10);
    }
    else
    {
        dia = data.substring (3, 5);
        mes = data.substring (0, 2);
        ano = data.substring (6, 10);
    }
    if ( (isNaN(dia)) || (isNaN(mes)) || (isNaN(ano))) 
    {
        alert(desData + ' inválida. Por favor, digite novamente.');
        data1.value = '';
        data1.focus();
        return false;
    }
    if ( !((dia == "") && (mes == "") && (ano == "")) ) 
    { 
        if ( (dia == "") || (mes == "") || (ano == "") ) 
        {
            alert('Formato inválido para ' + desData + '. Por favor, digite novamente.');
            data1.value = '';
            data1.focus();
            return false;
        } 
        else
        {
            if (((dia)>31)||((dia)<1))
            {
                alert('Dia inválido na ' + desData + '. Por favor, preencha corretamente');
                data1.value = '';
                data1.focus();
                return false;
            }
            if ((mes>12) || (mes<1))
            {
                alert('Mês inválido na ' + desData + '. Por favor, preencha corretamente');
                data1.value = '';
                data1.focus();
                return false;
            }
            if (ano.length < 4) 
            {
                alert('Ano inválido na ' + desData + '. Por favor, preencha corretamente');
                data1.value = '';
                data1.focus();
                return false;
            } 
            if (mes == 2)
            {
                if ((dia > 29) || (dia == '29' && ((ano%4) != 0)))
                {
                    alert('Dia inválido na ' + desData + '. Por favor, preencha corretamente');
                    data1.value = '';
                    data1.focus();
                    return false;
                }
            }
        
            if (((mes == 4) || (mes == 6) || (mes == 9) || (mes == 11)) && (dia > 30)) 
            {
                alert('Dia inválido na ' + desData + '. Por favor, preencha corretamente');
                data1.value = '';
                data1.focus();
                return false;
            } 
        } 
    }
    return true; 
}
