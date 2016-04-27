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
	}
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
				roleCode: $("#role").val() ,
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
				bootbox.alert(Message.MSG_DATA_NO_EDIT);
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
					roleCode: $("#role").val() ,
					emConpass: $("#emConpass").val()
				}
				checkData();
				var responseHeader = null;

				$.ajax({
					headers: {
						Accept: "application/json"
					},
					type: "POST",
					url: contextPath + '/ememployees/findeditEmployee',
					data : ememployees,
					success : function (data, status, xhr) {
						if(xhr.status === 200){
							bootbox.alert(Message.MSG_PLEASE_EDIT_SUCCESSFULLY, function(){
								window.location.href = contextPath + '/ememployees/editEmployee';
							});
						}else{
							bootbox.alert(Message.MSG_EDIT_FAILED);
						}
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
	
	$("#laPassword").hide();
	$("#laEmConpass").hide();
	$("#password").hide();
	$("#emConpass").hide();

	$.ajax({
		headers: {
			Accept: "application/json"
		},
		type: "GET",
		url: contextPath + '/ememployees/findappRoleName',
		success: function (data,status,xhr) {
			if(xhr.status==200){
				$.each(data,function(key,val){
					$("#role").append('<option value="'+val.roleCode+'">'+val.roleName+'</option>')
				})
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
							$("#empFirstName").val(labelData[0].empFirstName);
							$("#empLastName").val(labelData[0].empLastName);
							$("#email").val(labelData[0].email);
							$("#userName").val(labelData[0].userName);
							$("#password").val(labelData[0].password);
							$("#emConpass").val(labelData[0].password);
							//document.getElementById("emPosition").value = labelData[0].emPosition.id + "#0";
							$("#emPosition").val(labelData[0].emPosition.id + "#0");
							//document.getElementById("emTeam").value = labelData[0].emTeam.id + "#0";
							$("#emTeam").val(labelData[0].emTeam.id + "#0");
							//document.getElementById("role").value = labelData[0].roleCode;
							//console.log(">"+labelData[0].roleCode);

							oldNickName = labelData[0].empNickName;
							oldempFirstName = labelData[0].empFirstName
							oldempLastName = labelData[0].empLastName;
							oldemail = labelData[0].email
							olduserName = labelData[0].userName;
							oldpassword = labelData[0].password;
							oldemConpass = labelData[0].password;
							oldememPosition = labelData[0].emPosition.id + "#0";
							oldememTeam = labelData[0].emTeam.id + "#0";
							olderole = labelData[0].roleCode ;
							$("#role").val(labelData[0].roleCode);
							//alert(""+labelData[0].roleCode)
						},
						async: false
					});

				}
			}
		}
	});
});













