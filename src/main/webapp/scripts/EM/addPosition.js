$('#btnAdd').click(function() {
	if($('#txtPositionCode').val() === ""){
    	$('#txtPositionCode').popover('show');
	}else if($('#txtPositionName').val()  === ""){
    	$('#txtPositionName').popover('show');
	}else{
		var emPosition = {
			positionCode: $('#txtPositionCode').val(),
			positionName: $('#txtPositionName').val()
		};
	   	var responseHeader = null;
	   	$.ajax({
	   		type: "POST",
	   		contentType: "application/json; charset=utf-8",
	   		dataType: "json",
	   		headers: {
	   			Accept: "application/json"
	   		},
	   		url: contextPath + '/empositions',
	   		data : JSON.stringify(emPosition),
	   		complete: function(xhr){
	   			bootbox.alert("xhr : " + xhr);
	   		},
	   		async: false
	   	});
	}
});

$('#btnEdit').click(function() {
	bootbox.confirm("คุณต้องการลบข้อมูลที่เลือกหรือไม่", function(result) {
    	alert("Return : " + result);
    });
});