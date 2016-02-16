var paggination = Object.create(UtilPaggination);
$('#btnSearch').click(function() {
	searchData();
	$('#checkboxAll').prop('checked', false);
});

function checkEMPositionCode() {
  	var elem = document.getElementById('txtPositionCode').value;
  	if(!elem.match(/^([a-z0-9\_])+$/i))
  	{
  		$('#txtPositionCode').attr("data-content" , "กรุณากรอกข้อมูลรหัสพนักงานเป็น a-Z หรือ A-Z หรือ 0-9").popover('show');
  		return false;
  	}else{
  		return true;
  	}
 };

var check = 0;

$('[id^=btnM]').click(function() {
	var id = this.id.split('M')[1];
	if(id === 'Cancel'){
		$('#add').modal('hide');
		$('#txtPositionCode').popover('hide'); $('#txtPositionName').popover('hide');
		$('#txtPositionCode').val(null); $('#txtPositionName').val(null);
	}else{
		if($('#txtPositionCode').val() === ""){
			$('#txtPositionCode').attr("data-content" , "กรุณากรอกข้อมูลรหัสตำแหน่ง").popover('show');
		}else if($('#txtPositionName').val()  === ""){
			if(checkEMPositionCode() === true){
				$('#txtPositionName').popover('show');
			}
		}else{
			if(checkEMPositionCode() === true){
				var emPosition = {
					positionCode: $('#txtPositionCode').val(),
					positionName: $('#txtPositionName').val()
				};
				var responseHeader = null;
				if(check === 0){
					checkData();
					if(chkDb === 0){
						$.ajax({
							contentType: "application/json; charset=utf-8",
							dataType: "json",
							headers: {
								Accept: "application/json"
							},
							type: "POST",
							url: contextPath + '/empositions',
							data : JSON.stringify(emPosition),
							complete: function(xhr){
								if(xhr.status === 201){
									if(id === 'Add'){
										bootbox.alert("บันทึกข้อมูลสำเร็จ");
										$('#add').modal('hide');
									}
									$('#txtPositionCode').val(null);
									$('#txtPositionName').val(null);
								}else if(xhr.status === 500){
									bootbox.alert("บันทึกข้อมูลไม่สำเร็จ");
								}
							},
							async: false
						});
					}else{
						bootbox.alert("รหัสต่ำแหน่งมีแล้ว");
					}
				}else if(check === 1){
					if($('#txtPositionName').val() === checkEdit){
						bootbox.alert("ข้อมูลไม่มีการเปลี่ยนแปลง");
						$('#add').modal('hide');
						$('#txtPositionCode').val(null);
						$('#txtPositionName').val(null);
					}else{
						$.ajax({
							contentType: "application/json; charset=utf-8",
							dataType: "json",
							headers: {
								Accept: "application/json"
							},
							type: "GET",
							url: contextPath + '/empositions/findeditEMPosition',
							data : emPosition,
							complete: function(xhr){
								if(xhr.status === 200){
									bootbox.alert("แก้ไขข้อมูลสำเร็จ");
									$('#add').modal('hide');
									$('#txtPositionCode').val(null);
									$('#txtPositionName').val(null);
									searchData();
								}else if(xhr.status === 500){
									bootbox.alert("แก้ไขข้อมูลไม่สำเร็จ");
								}
							},
							async: false
						});
					}
					check = 0;
				}
			}
		}
	}
});

$('#btnAdd').click(function() {
	$(".modal-title").text("เพิ่มตำแหน่ง");
	$('#btnMNext').show();
	$('#txtPositionCode').attr('disabled', false);
});

var dataPositionCode = [];
var sendData = "";

$('#btnDelete').click(function() {
	if(dataPositionCode.length > 0){
		bootbox.confirm("คุณต้องการลบข้อมูลที่เลือกหรือไม่", function(result) {
			if(result == true){
				for(var i = 0; i < dataPositionCode.length; i++){
					sendData = dataPositionCode[i];
					deleteData();
				}
				dataPositionCode.splice(0, dataPositionCode.length);
				searchData();
				$('#checkboxAll').prop('checked', false);

				if(chkDStatus500 === 0){
					bootbox.alert("ลบข้อมูลสำเร็จ : " + chkDStatus200 + " รายการ");
				}else{
					bootbox.alert("ลบข้อมูลสำเร็จ : " + chkDStatus200 + " รายการ ลบข้อมูลไม่สำเร็จ : " + chkDStatus500 + " รายการ");
				}
			}
		});
	}else{
		bootbox.alert("คุณยังไม่ได้เลือกข้อมูลที่ต้องการลบ");
	}
});

$('#Table').on("click", "[id^=chkDelete]", function () {
    var id = this.id.split('e')[3];
    if ($(this).prop('checked') == true) {
        dataPositionCode.push($('#tdPositionCode' + id).text());
    }
    else if ($(this).prop('checked') == false) {
        var num = dataPositionCode.indexOf($('#tdPositionCode' + id).text());
        dataPositionCode.splice(num, 1);
    }
});

$('#checkboxAll').click(function(){
	$(".check").prop('checked', $(this).prop('checked'));
    var lengthTr = $('#Table').find('tr').length;
    for (var i = 1; i < lengthTr; i++) {
        if ($(this).prop('checked') == true) {
        	if($('#chkDelete' + i).prop('disabled') == true){
        		$('#chkDelete' + i).prop('checked', false);
        	}
            var num = dataPositionCode.indexOf($('#tdPositionCode' + i).text())
            if (num != "") {
                dataPositionCode.push($('#tdPositionCode' + i).text());
            }
        }
        else {
            var num = dataPositionCode.indexOf($('#tdPositionCode' + i).text());
            dataPositionCode.splice(num, 1);
        }
    }
});

var checkEdit = "";

$('#Table').on("click", '[id^=btnEdit]', function() {
	var id = this.id.split('t')[2];
	check = 1;
	$('#btnMNext').hide();
	$(".modal-title").text("แก้ไขตำแหน่ง");
	$('#txtPositionCode').val($('#tdPositionCode' + id).text()).attr('disabled', true);
	checkEdit = $('#tdPositionName' + id).text();
	$('#txtPositionName').val($('#tdPositionName' + id).text());
});

var chkdata = [];

paggination.setEventPaggingBtn("paggingSimple",paggination);
paggination.loadTable = function loadTable (jsonData) {

    if(jsonData.length <= 0)
       bootbox.alert("ไม่พบข้อมูล");

    $('#ResualtSearch').empty();
    var link = "";
    var i = 1;
    var tableData = "";

    var dataJsonData = {
    	empCode: ""
    }
	var checkdDb = $.ajax({
		type: "GET",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		headers: {
			Accept: "application/json"
		},
		url: contextPath + '/ememployees/findProjectByemPosition',
		data: dataJsonData,
		complete: function(xhr){
		},
		async: false
	});
	var Obj = jQuery.parseJSON(checkdDb.responseText);
	$.each(Obj, function(key, val) {
		chkdata.push(val["code"]);
	});

    jsonData.forEach(function(value){
        tableData = ''
		+ '<tr style="background-color: #fff">'
            + '<td>'
        	+ '<div id="chkBox' + i + '" class="text-center">'
            + '<input  id="chkDelete' + i + '" class="check" type="checkbox" name="chkdelete" />'
        	+ '</div>'
            + '</td>'
            + '<td class="text-center">'
            + '<button id="btnEdit' + i + '" type="button" class="btn btn-info" data-toggle="modal" data-target="#add" data-backdrop="static"><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
            + '</td>'
            + '<td id="tdPositionCode' + i + '" class="text-center" style="color: #000">'
            + value.code
            + '</td>'
            + '<td id="tdPositionName' + i + '" class="text-center" style="color: #000">'
            + value.name
            + '</td>'
        + '</tr>';

        $('#ResualtSearch').append(
            tableData
        );

        for(var chk = 0; chk < chkdata.length; chk++){
			if(value.code === chkdata[chk]){
				$('#chkDelete' + i).prop('disabled', true);
				break;
			}
		}

		i++;
    });
};

function searchData() {
  	var dataJsonData = {
  		positionCode:$('#sPositionCode').val(),
		positionName:$('#sPositionName').val()
    }

    paggination.setOptionJsonData({
      	url:contextPath + "/empositions/findPaggingData",
      	data:dataJsonData
    });

    paggination.setOptionJsonSize({
        url:contextPath + "/empositions/findPaggingSize",
        data:dataJsonData
    });

    paggination.search(paggination);
}

var chkDStatus200 = 0;
var chkDStatus500 = 0;

function deleteData() {
  	var dataJsonData = {
  		positionCode:sendData
    }

    $.ajax({
		type: "GET",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		headers: {
			Accept: "application/json"
		},
		url: contextPath + '/empositions/findDeletePosition',
		data : dataJsonData,
		complete: function(xhr){
			if(xhr.status === 200)
				chkDStatus200++;
			if(xhr.status === 500)
				chkDStatus500++;
		},
		async: false
	});
}

var chkDb;

function checkData() {
	var dataJsonData = {
  		positionCode:$('#txtPositionCode').val()
    }

    var checkdDb = $.ajax({
		type: "GET",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		headers: {
			Accept: "application/json"
		},
		url: contextPath + '/empositions/findProjectBypositionCode',
		data : dataJsonData,
		complete: function(xhr){
		},
		async: false
	});

    chkDb = jQuery.parseJSON(checkdDb.responseText);
}