$('#btnAdd').click(function(){
	if($('#empCode').val() === ""){
    	$('#empCode').popover('show');
	}else if ($('#empCode').val().length < 4) {
		bootbox.alert("กรุณากรอกข้อมูลรหัสพนักงานเอย่งาน้อย 4 ตัวอักษร");	
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
		bootbox.alert("รหัสผ่านไม่ตรงกันกรุณายืนยันรหัสผ่านให้ตรงกันอีกรั้ง");
	}else if($("#emPosition").val()=="0"){
	 	bootbox.alert("กรุณาเลือกตำแหน่ง");
	}else if($("#emTeam").val()=="0"){
	 	bootbox.alert("กรุณาเลือกทีม");
	}else if($('#password').val().length < 8){
		bootbox.alert("กรุณากรอกรหัสผ่านอย่างน้อย 8 ตัวอักษร");
	}else{
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


	bootbox.alert("สมัครสมาชิกเรียบร้อยแล้ว");
	$('#empCode').val("");
	$('#empNickName').val("");
	$("#empFirstName").val("");
	$("#empLastName").val("");
	$("#email").val("");
	$("#userName").val("");
	$("#password").val("");
	$("#emConpass").val("");
	$("#emPosition").val("0");
	$("#emTeam").val("0");


	}
}) ;
function checkempCode()
	{
		var elem = document.getElementById('empCode').value;
		if(!elem.match(/^([a-z0-9\_])+$/i))
		{
			bootbox.alert("กรุณากรอกข้อมูลรหัสพนักงานเป็น a-Z หรือ A-Z หรือ 0-9 ");
			$('#empCode').val("");
		}
	} ;
function checkEmail()
	{
		var elem = document.getElementById('email').value;
		if(!elem.match(/^([a-z0-9\_\@\.-])+$/i))
		{
			bootbox.alert("กรุณากรอกข้อมูลอีเมลเป็น a-Z หรือ A-Z หรือ 0-9 ");
			$('#email').val("");
		}
	} ;
function checkUserName()
	{
		var elem = document.getElementById('userName').value;
		if(!elem.match(/^([a-z0-9\_])+$/i))
		{
			bootbox.alert("กรุณากรอกข้อมูลผู้ใช้เป็น a-Z หรือ A-Z หรือ 0-9 ");
			$('#userName').val("");
		}
	} ;














