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
	if((dni.length)<9 || validateNDI(dni)==false)
		{
		validForm.push("dni");
		}
	var name=$('#managerName').val();
	if((name.length)<2)
		{
		validForm.push("nombre");
		}
	var lname1=$('#managerLastNameFirst').val();
	if((lname1.length)<2)
		{
		validForm.push("primer apellido");
		}
	var lname2=$('#managerLastNameSecond').val();
	if((lname2.length)<2)
		{
		validForm.push("segundo apellido");
		}
	var date=$('#managerBirthDate').val();
	if(validateDate(date)==false)
		{
		validForm.push("fecha de nacimiento");
		}
	var address=$('#managerAddress').val();
	if((address.length)<2)
		{
		validForm.push("dirección");
		}
	var phone=$('#managerPhone').val();
	if(validatePhone(phone)==false)
		{
		validForm.push("teléfono");
		}
	var phone=$('#managerPassword').val();
	if(validatePassword(phone)==false)
		{
		validForm.push("clave");
		}
	if((validForm.length)!=0)
	{
		alert(validForm);
		e.preventDefault();
	}
}
