function checkNewAccount(e) {
	var validForm=[];
	var amount=$('#accountAmount').val();
	if(amount.length<1)
		{
		validForm.push("Cantidad inicial de dinero a ingresar");
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
