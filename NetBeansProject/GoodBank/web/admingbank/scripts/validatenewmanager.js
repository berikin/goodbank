function validateDate(val) {
	var regExp = /(0[1-9]|[12][0-9]|3[01])[- \/.](0[1-9]|1[012])[- \/.](19|20)\d\d/;
	if (val.match(regExp)) {
		return true;
	} else {
		return false;
	}
}

function validatePassword(val){
	var regExp = /(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/;
	if (val.match(regExp)) {
		return true;
	} else {
		return false;
	}
}

function validatePhone(val){
	var regExp= /^\+?\d{1,3}?[- .]?\(?(?:\d{2,3})\)?[- .]?\d\d\d[- .]?\d\d\d\d$/;
	if (val.match(regExp)) {
		return true;
	} else {
		return false;
	}
}

function validateRepeatedDNI(value) {
	var returnVal = true;
	$.ajax({
				async: false,
				url: "jQuerySelectManagers.jsp",
				type: "POST",
				data: "dni="+value,
				success: function(result) {
					var wee="hola";
					var values=result.split("$");
					var dni=values[0];
				    var managers = values[1].split("#");
				    var managerinfo = [];
				    for (i = 0; i < managers.length; i++)
				    {
					var dataA = managers[i].split(",");
					    managerinfo[i]=dataA;
				    }
				    for (i = 0; i < managerinfo.length; i++)
				    {
				    	//alert((managerinfo[i][1]==(dni.trim())))
						if(managerinfo[i][1]==(dni.trim()))
						{
							returnVal=false;
						}
				    }
				}
			    });
	return returnVal;
}

function validateNDI(value) { 
		var cadenadni="TRWAGMYFPDXBNJZSQVHLCKET";
		var let = value.substr(value.length-1,1);
			if(/^([0-9]{8})*[a-zA-Z]+$/.test(value)){
				var numero = value.substr(0,value.length-1) % 23;
				letra=cadenadni.substring(numero,numero+1);
				if (letra==let)
				return true;
				return false;
			} else if (/^[XYZ]{1}/.test(value)) {
				var reemplazar = new Array("X", "Y", "Z")
				var por = new Array("0", "1", "2");
				numero=value
				for (var i=0; i<reemplazar.length; i++) { 
					numero = numero.replace(reemplazar[i].toUpperCase(), por[i]); 
				} 
				var numero = numero.substr(0,value.length-1) % 23;
				var letra = cadenadni.substring(numero, numero + 1);
				if (letra==let)
				return true;
				return false;
            }
        }

function checkNewManager(e){
	var validForm=[];
	var dni=$('#managerIdCard').val();
	if(dni.length>0)
	{
	if(validateRepeatedDNI(dni)==false)
		{
		validForm.push("Usuario existente (Ya existe un administrador con este DNI)");
		}
	}
	if((dni.length)<9 || validateNDI(dni)==false)
		{
		validForm.push("DNI (debe tener ocho caracteres más la letra correspondiente)");
		}
	var name=$('#managerName').val();
	if((name.length)<2)
		{
		validForm.push("nombre (de al menos dos caracteres)");
		}
	var lname1=$('#managerLastNameFirst').val();
	if((lname1.length)<2)
		{
		validForm.push("primer apellido (de al menos dos caracteres)");
		}
	var lname2=$('#managerLastNameSecond').val();
	if((lname2.length)<2)
		{
		validForm.push("segundo apellido (de al menos dos caracteres)");
		}
	var date=$('#managerBirthDate').val();
	if(validateDate(date)==false)
		{
		validForm.push("fecha de nacimiento");
		}
	var address=$('#managerAddress').val();
	if((address.length)<2)
		{
		validForm.push("dirección (de al menos dos caracteres)");
		}
	var phone=$('#managerPhone').val();
	if(validatePhone(phone)==false)
		{
		validForm.push("teléfono (código de país seguido del número de teléfono, sin espacios)");
		}
	var phone=$('#managerPassword').val();
	if(validatePassword(phone)==false)
		{
		validForm.push("clave (longitud mínima de ocho caracteres con al menos una mayúscula, una minúscula, un número y un carácter especial)");
		}
	if((validForm.length)!=0)
	{
		e.preventDefault();
		$('#wrong').html('');
		$('#wrong').append('<p>Algunos campos no son correctos:</p>');
		$('#wrong').append('<ul id="wronglist">');
		for (i=0;i<(validForm.length);i++)
			{
				$('#wronglist').append('<li>'+validForm[i]+'</li>');
			}
	}
}
