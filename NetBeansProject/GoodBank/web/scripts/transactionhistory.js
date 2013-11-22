function getTransactions(value,total) {
	var transaction_info = [];
	$.ajax({
				async: false,
				url: "jQueryTransactions.jsp",
				type: "POST",
				data: "account="+value,
				success: function(result) {
					var details = result.trim().split("$");
				    var transactions = details[1].trim().split("#");
				    for (i = 0; i < transactions.length; i++)
				    	{
						var dataA = transactions[i].trim().split("|");
					    transaction_info[i]=dataA;
				    	}
				    //alert(total+" vs "+(transaction_info.length-1));
				    if (total!=transaction_info.length-1)
				    	{
						$('#movementDetails').fadeOut('slow', function() 
							{
							$('#movementDetails').html('');
							$('#totalMoney').html('');
							$('#movementDetails').append('<table id="myTable" class="tablesorter"><thead><tr><th>Fecha</th><th>Cantidad</th><th>Ordenante</th><th>Concepto</th></tr></thead><tbody id="mvDetails"></tbody></table>');
							for (i = 0; i < (transaction_info.length-1); i++)
							    {
							    	if(i%2==0)
							    	{
							    	$('#mvDetails').append('<tr class="odd"><td>'+transaction_info[i][2]+'</td><td>'+transaction_info[i][3]+'</td><td>'+transaction_info[i][4]+'</td><td>'+transaction_info[i][5]+'</td></tr>');
							    	}
							    	else
							    	{
									$('#mvDetails').append('<tr class="even"><td>'+transaction_info[i][2]+'</td><td>'+transaction_info[i][3]+'</td><td>'+transaction_info[i][4]+'</td><td>'+transaction_info[i][5]+'</td></tr>');
							    	}
							    }
							$('#totalMoney').html('El saldo actual de tu cuenta es: '+details[0].trim());
							$("#myTable").tablesorter({widgets : ['zebra', 'columns'], usNumberFormat : false,	sortReset : true, sortRestart : true});
							$('#movementDetails').fadeIn('slow');		
							});
						}
					}
			    });
	return (transaction_info.length-1);
}
