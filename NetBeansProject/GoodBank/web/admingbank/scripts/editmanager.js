function editManager(value) {
	var returnVal = true;
	$.ajax({
				async: false,
				url: "jQuerySelectManagers.jsp",
				type: "POST",
				data: "edit="+value,
				success: function(result) {
				    var managers = result.split("#");
				    	$('#managerIdCard').attr('value', managers[1]);
				    	$('#managerName').attr('value', managers[2]);
				    	$('#managerLastNameFirst').attr('value', managers[3]);
				    	$('#managerLastNameSecond').attr('value', managers[4]);
				    	$('#managerBirthDate').attr('value', managers[5]);
				    	$('#managerStreetType').attr('value', managers[6]);
				    	$('#managerAddress').attr('value', managers[7]);
				    	$('#managerProvince').attr('value', managers[8]);
				    	$('#managerCommunity').attr('value', managers[9]);
						$('#managerPhone').attr('value', managers[10]);
				    	$('#managerRange').attr('value', managers[11]);
				    }
			    });
}