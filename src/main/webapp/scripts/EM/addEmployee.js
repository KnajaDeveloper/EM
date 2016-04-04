var addEmployee;
var saveEmployee;



$('#btnAdd').click(function(){
	if($('#empCode').val() === ""){
		$('#empCode').popover('show');
	}else if($('#empNickName').val() === ""){
		$('#empNickName').popover('show');
	}else if($('#empFirstName').val() === ""){
		$('#empFirstName').popover('show');
	}else if($('#empLastName').val() === ""){
		$('#empLastName').popover('show');
	}else if($("#emPosition").val()=="0"){
		$('#emPosition').popover('show');
	}else if($("#emTeam").val()=="0"){
		$('#emTeam').popover('show');
	}else if($("#role").val()=="0"){
		$('#role').popover('show');
	}else if($('#email').val() === ""){
		$('#email').popover('show');
	}else if($('#userName').val() === ""){
		$('#userName').popover('show');
	}else if($('#password').val() === ""){
		$('#password').popover('show');
	}else if($('#emConpass').val() === ""){
		$('#emConpass').popover('show');
	}else if($('#emConpass').val() != $("#password").val()){
		bootbox.alert(Message.MSG_PLEASE_CONFIRM_YOUR_PASSWORD_AGAIN);}
	//}else if($('#password').val().length < 8){
	//	bootbox.alert(Message.MSG_PLESE_ENTER_YOUR_PASSWORD_AT_LAST_8_CHAR);
	//}
	else {
		if(checkEdit == false) {
			var ememployees = {

				empCode: $("#empCode").val(),
				empNickName: $("#empNickName").val(),
				empFirstName: $("#empFirstName").val(),
				empLastName: $("#empLastName").val(),
				email: $("#email").val(),
				userName: $("#userName").val(),
				password: $("#password").val(),
				emTeam: {
					id: $("#emTeam").val().split("#")[0],
					version: $("#emTeam").val().split("#")[1]
				},
				emPosition: {
					id: $("#emPosition").val().split("#")[0],
					version: $("#emPosition").val().split("#")[1],
				},
				roleCode: $("#role").val() == 1 ? "ADMIN" : "USER",
				emConpass: $("#emConpass").val()

			}
			checkData();
			if (chkDb === 0) {
				var responseHeader = null;
				$.ajax({
					type: "POST",
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					headers: {
						Accept: "application/json"
					},
					url: contextPath + '/ememployees',
					data: JSON.stringify(ememployees),
					complete: function (xhr) {
						bootbox.alert(Message.MSG_SUBSCRIBE_SUCCESSFULLY);
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
						$("#role").val("0");
					},
					async: false
				});

			} else {

				bootbox.alert(Message.MSG_PLEASE_ENTER_YOUR_EMID_AGAIN);
			}
		} else {
			if (oldNickName == $("#empNickName").val() &&
				oldempFirstName == $("#empFirstName").val() &&
				oldempLastName == $("#empLastName").val() &&
				oldemail == $("#email").val() &&
				olduserName == $("#userName").val() &&
				oldpassword == $("#password").val() &&
				oldemConpass == $("#password").val() &&
				oldememPosition == $("#emPosition").val() &&
				oldememTeam == $("#emTeam").val() &&
				olderole == $("#role").val()
			) {
				bootbox.alert("ข้อมูลไม่มีการเปลี่ยนแปลง");
			} else{
				var ememployees = {
					empCode: $("#empCode").val(),
					empNickName: $("#empNickName").val(),
					empFirstName: $("#empFirstName").val(),
					empLastName: $("#empLastName").val(),
					email: $("#email").val(),
					userName: $("#userName").val(),
					password: $("#password").val(),
					emTeam: $("#emTeam").val().split("#")[0],
					emPosition: $("#emPosition").val().split("#")[0],
					roleCode: $("#role").val() == 1 ? "ADMIN" : "USER",
					emConpass: $("#emConpass").val()

				}
				checkData();
				var responseHeader = null;
				$.ajax({
					type: "GET",
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					headers: {
						Accept: "application/json"
					},
					url: contextPath + '/ememployees/findeditEmployee',
					data: ememployees,
					complete: function (xhr) {
						bootbox.alert("แก้ไขข้อมูลสำเร็จ", function(){
							window.location.href = contextPath + '/ememployees/editEmployee';
						});

					},
					async: false
				});

			}
		}
	}

}) ;

var chkDb;
function checkData() {
	var dataJsonData = {
		empCode :$('#empCode').val()
	}

	var checkdDb = $.ajax({
		type: "GET",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		headers: {
			Accept: "application/json"
		},
		url: contextPath + '/ememployees/findCheckEMCodeByID',
		data : dataJsonData,
		complete: function(xhr){
		},
		async: false
	});

	chkDb = checkdDb.responseJSON;

}

var oldNickName;
var oldempFirstName;
var oldempLastName;
var oldemail;
var olduserName;
var oldpassword;
var oldemConpass;
var oldememPosition;
var oldememTeam;
var olderole;

var checkEdit=false;
$(document).ready(function(){
	console.log("EM>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+id);
	if(id!="") {
		checkEdit=true;
		labelData = $.ajax({
			headers: {
				Accept: "application/json"
			},
			type: "GET",
			url: contextPath + '/ememployees/findEmployeeByID',
			data: {id: id},
			complete: function (xhr) {
				//console.log(xhr)
				var labelData = xhr.responseJSON;
				$('#empCode').val(labelData[0].empCode).attr('disabled', true);
				$('#empNickName').val(labelData[0].empNickName);
				oldNickName = labelData[0].empNickName;
				$("#empFirstName").val(labelData[0].empFirstName);
				oldempFirstName = labelData[0].empFirstName
				$("#empLastName").val(labelData[0].empLastName);
				oldempLastName = labelData[0].empLastName;
				$("#email").val(labelData[0].email);
				oldemail = labelData[0].email
				$("#userName").val(labelData[0].userName);
				olduserName = labelData[0].userName;
				$("#password").val(labelData[0].password);
				oldpassword = labelData[0].password;
				$("#emConpass").val(labelData[0].password);
				oldemConpass = labelData[0].password;
				document.getElementById("emPosition").value = labelData[0].emPosition.id + "#0";
				oldememPosition = labelData[0].emPosition.id + "#0";
				document.getElementById("emTeam").value = labelData[0].emTeam.id + "#0";
				oldememTeam = labelData[0].emTeam.id + "#0";
				document.getElementById("role").value = labelData[0].roleCode == "ADMIN" ? 1 : 2;
				olderole = labelData[0].roleCode == "ADMIN" ? 1 : 2;
			},
			async: false
		});

	}
});













