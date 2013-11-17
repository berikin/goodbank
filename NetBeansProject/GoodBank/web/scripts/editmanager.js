function editManager(value) {
	var returnVal = true;
	$.ajax({
				async: false,
				url: "jQuerySelectManagers.jsp",
				type: "POST",
				data: "edit="+value,
				success: function(result) {
				    var managers = (result.trim()).split(",");
				    	$('#managerIdCard').val(managers[1]);
				    	$('#managerPwdIdCard').val(managers[1]);
				    	$('#managerName').val(managers[2]);
				    	$('#managerLastNameFirst').val(managers[3]);
				    	$('#managerLastNameSecond').val(managers[4]);
				    	var date=managers[5].split("-");
				    	$('#managerBirthDate').val(date[2]+"/"+date[1]+"/"+date[0]);
				    	$('#managerStreetType').val(managers[6]);
				    	$('#managerAddress').val(managers[7]);
				    	$('#managerProvince').val(managers[8]);
				    	$('#managerCommunity').val(managers[9]);
						$('#managerPhone').val(managers[10]);
				    	$('#managerRange').val(managers[11]);
				    }
			    });
}