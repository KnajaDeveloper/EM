$('#btnAdd').click(function(){
	if($('#empCode').val() === ""){
    	$('#empCode').popover('show');
	}else if($('#empNickName').val() === ""){
		$('#empNickName').popover('show');
	}else if($('#empFirstName').val() === ""){
		$('#empFirstName').popover('show');
	}else if($('#empLastName').val() === ""){
		$('#empLastName').popover('show');
	}else if($('#email').val() === ""){
		$('#email').popover('show');
	}else if($('#userName').val() === ""){
		$('#userName').popover('show');
	}else if($('#password').val() === ""){
		$('#password').popover('show');
	}else if($('#emConpass').val() === ""){
		$('#emConpass').popover('show');
	}else if($('#emConpass').val() != $("#password").val()){
		$('#emConpass').popover('show');
	}
	else{
	var ememployees = {
		empCode : $("#empCode").val() ,
		empNickName : $("#empNickName").val() ,
		empFirstName : $("#empFirstName").val() ,
		empLastName : $("#empLastName").val() ,
		email : $("#email").val() ,
		userName : $("#userName").val() ,
		password : $("#password").val() ,
		emTeam : {
		 	id : $("#emTeam").val().split("#")[0],
		 	version : $("#emTeam").val().split("#")[1]
		 } ,
		emPosition : {
		 	id : $("#emPosition").val().split("#")[0],
		 	version : $("#emPosition").val().split("#")[1],
		 } ,
		emConpass : $("#emConpass").val()
	}
	var responseHeader = null;
	$.ajax({
		type: "POST",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		headers: {
			Accept: "application/json"
		},
		url: contextPath + '/ememployees',
		data : JSON.stringify(ememployees),
		complete: function(xhr){
		} ,
		  async: false
	});
	alert("สมัครสมาชิกเรียบร้อยแล้ว");

	}
}) ;










