var validated=false;
$('#delManagerForm').submit(function(e) {
		if(validated===false)
		{
	    	e.preventDefault();
	    	$("#dialog-confirm").dialog({
			resizable: false,
			height: 240,
			width: 500,
			modal: true,
			buttons: {
					"Si": function() {
					$(this).dialog("close");
					validated=true;
					$('#delManagerForm').submit();
				    },
				    "No": function() {
					$(this).dialog("close");
					return false;
				    }
				}
			});
		}
	});