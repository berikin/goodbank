function getTransactions(value) {
	$.ajax({
				async: false,
				url: "jQueryTransactions.jsp",
				type: "POST",
				data: "account="+value,
				success: function(result) {
				    var transactions = result.split("#");
				    var transaction_info = [];
				    for (i = 0; i < transactions.length; i++)
				    {
					var dataA = transactions[i].split(",");
					    transaction_info[i]=dataA;
				    }
				    $('#movementDetails').html('');
				    $('#movementDetails').append('<table><thead><tr><th>Fecha</th><th>Cantidad</th><th>Ordenante</th><th>Concepto</th></tr></thead><tbody id="mvDetails"></tbody></table>');
				    for (i = 0; i < (transaction_info.length-1); i++)
				    {
						$('#mvDetails').append('<tr><td>'+transaction_info[i][2]+'</td><td>'+transaction_info[i][3]+'</td><td>'+transaction_info[i][4]+'</td><td>'+transaction_info[i][5]+'</td></tr>');
				    }
				}
			    });
}

$( document ).ready(function() {
    getTransactions();
  });
