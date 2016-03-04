var paggination = Object.create(UtilPaggination);

$('#btnSearch').click(function() {
	searchData();
});

paggination.setEventPaggingBtn("paggingSimple",paggination);
paggination.loadTable = function loadTable (jsonData) {

    if(jsonData.length <= 0)
       bootbox.alert("ไม่พบข้อมูล");

    $('#ResualtSearch').empty();

    var tableData = "";

    jsonData.forEach(function(value){
        tableData = ''
		+ '<tr>'
            + '<td class="text-center">'
            	+ '<input  id="" class="checkboxTable" type="checkbox" />'
            + '</td>'
            + '<td class="text-center">'
            	+ '<button onclick="openModalEdit($(this))" type="button" class="btn btn-xs btn-info" data-toggle="modal" data-target="#add" data-backdrop="static"><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
            + '</td>'
            + '<td id="tdPositionCode" class="text-center">' + value.positionCode + '</td>'
            + '<td id="tdPositionName" class="text-center">' + value.positionName + '</td>'
        + '</tr>';

        $('#ResualtSearch').append(tableData);
    });
};

var positionName;

function openModalEdit(element){
	check = 1;
	$('#btnMNext').hide();
    $('#txtPositionCode').val(element.parent("td:eq(0)").parent("tr:eq(0)").children("#tdPositionCode").text()).attr('disabled', true);
    positionName = element.parent("td:eq(0)").parent("tr:eq(0)").children("#tdPositionName").text();
    $('#txtPositionName').val(positionName);
}

function searchData() {
	$('#checkboxAll').prop('checked', false);
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

function checkEMPositionCode() {
  	var elem = document.getElementById('txtPositionCode').value;
  	if(!elem.match(/^([a-z0-9\_])+$/i)){
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
		check = 0;
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
				if(check == 0){
					if(checkData() == 0){
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
						bootbox.alert("รหัสตำแหน่งมีแล้ว");
					}
				}else if(check == 1){
					if($('#txtPositionName').val() === positionName){
						bootbox.alert("ข้อมูลไม่มีการเปลี่ยนแปลง");
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
									check = 0;
								}else if(xhr.status === 500){
									bootbox.alert("แก้ไขข้อมูลไม่สำเร็จ");
								}
							},
							async: false
						});
					}
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

var status200 = 0;
var status500 = 0;

function deleteData() {
	$.each($(".checkboxTable:checked"),function(index,value){
	    $.ajax({
			type: "GET",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			headers: {
				Accept: "application/json"
			},
			url: contextPath + '/empositions/findDeletePosition',
			data : {
				positionCode: $(this).attr("id")
			},
			complete: function(xhr){
				if(xhr.status === 200)
					status200++;
				if(xhr.status === 500)
					status500++;
			},
			async: false
		});
	});
}

$('#btnDelete').click(function() {
	if($(".checkboxTable:checked").length <= 0){
            bootbox.alert("คุณยังไม่ได้เลือกข้อมูลที่ต้องการลบ");
            return false;
    }else{
    	bootbox.confirm("คุณต้องการลบข้อมูลที่เลือกหรือไม่", function(result) {
			if(result == true){
				deleteData();
				searchData();
				$('#checkboxAll').prop('checked', false);
				if(status500 === 0){
					bootbox.alert("ลบข้อมูลสำเร็จ : " + status200 + " รายการ");
				}else{
					bootbox.alert("ลบข้อมูลสำเร็จ : " + status200 + " รายการ ลบข้อมูลไม่สำเร็จ : " + status500 + " รายการ");
				}
			}
		});
    }
});

$("#checkboxAll").click(function(){
    $(".checkboxTable").prop('checked', $(this).prop('checked'));
});

$('#Table').on("click", ".checkboxTable", function () {
    if($(".checkboxTable:checked").length == $(".checkboxTable").length){
        $("#checkboxAll").prop("checked", true);
    }else{
        $("#checkboxAll").prop("checked", false);
    }
});

function checkData() {
    var checkdDb = $.ajax({
		type: "GET",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		headers: {
			Accept: "application/json"
		},
		url: contextPath + '/empositions/findCheckPositionCode',
		data : {
			positionCode:$('#txtPositionCode').val()
		},
		complete: function(xhr){
		},
		async: false
	});
    return jQuery.parseJSON(checkdDb.responseText);
}