var paggination = Object.create(UtilPaggination);

$('#btnSearch').click(function() {
	searchData();
});

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

paggination.setEventPaggingBtn("paggingSimple",paggination);
paggination.loadTable = function loadTable (jsonData) {

    if(jsonData.length <= 0)
       bootbox.alert(Message.MSG_DATA_NOT_FOUND);

   	$('#checkboxAll').prop('checked', false);
    $('#ResualtSearch').empty();

    var tableData = "";

    jsonData.forEach(function(value){
        tableData = ''
		+ '<tr>'
            + '<td class="text-center">'
            	+ '<input inUse="' + (value.inUse > 0 ? 1 : 0) + '" id="' + value.id + '" class="checkboxTable" type="checkbox" />'
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
	$('#btnModalNext').hide();
	$('.modal-title').text(Label.LABEL_EDIT_POSITION);
    $('#txtPositionCode').val(element.parent("td:eq(0)").parent("tr:eq(0)").children("#tdPositionCode").text()).attr('disabled', true);
    positionName = element.parent("td:eq(0)").parent("tr:eq(0)").children("#tdPositionName").text();
    $('#txtPositionName').val(positionName);
}

function checkEMPositionCode() {
  	var elem = document.getElementById('txtPositionCode').value;
  	if(!elem.match(/^([a-z0-9\_])+$/i)){
  		$('#txtPositionCode').attr("data-content" , Message.PLEASE_ENTER_THE_CODE_AS_a_TO_z_OR_A_TO_Z_OR_0_TO_9).popover('show');
  		return false;
  	}else{
  		return true;
  	}
 };

var check = 0;

$('[id^=btnModal]').click(function() {
	var id = this.id.split('l')[1];
	if(id === 'Cance'){
		if(check == 1){
            if($('#txtPositionName').val() == positionName){
                $('#add').modal('hide');
				$('#txtPositionCode').popover('hide'); $('#txtPositionName').popover('hide');
				$('#txtPositionCode').val(null); $('#txtPositionName').val(null);
            }else{
                bootbox.confirm(Message.MSG_WANT_TO_CANCEL_EDITING_THE_DATA_HAS_CHANGED_OR_NOT, function(result) {
                    if(result == true){
                        $('#add').modal('hide');
						$('#txtPositionCode').popover('hide'); $('#txtPositionName').popover('hide');
						$('#txtPositionCode').val(null); $('#txtPositionName').val(null);
                    }
                });
            }
        }else{
            $('#add').modal('hide');
        }

        check = 0;
	}else{
		if($('#txtPositionCode').val() === ""){
			$('#txtPositionCode').attr("data-content" , Message.MSG_PLEASE_FILL).popover('show');
		}else if($('#txtPositionName').val()  === ""){
			if(checkEMPositionCode() === true){
				$('#txtPositionName').popover('show');
			}
		}else{
			if(checkEMPositionCode() === true){
				var emPosition = {
					
				};
				var responseHeader = null;
				if(check == 0){
					if(checkData() == 0){
						$.ajax({
							headers: {
                                Accept: "application/json"
                            },
                            type: "POST",
							url: contextPath + '/empositions/saveEMPosition',
							data : {
								positionCode: $('#txtPositionCode').val(),
								positionName: $('#txtPositionName').val()
							},
							complete: function(xhr){
								if(xhr.status == 201){
									if(id == 'Add'){
										bootbox.alert(Message.MSG_ADD_MORE_SUCCESS);
										$('#add').modal('hide');
									}
									$('#txtPositionCode').val(null);
									$('#txtPositionName').val(null);
								}else if(xhr.status == 500){
									bootbox.alert(Message.MSG_ADD_FAILED);
								}
							},
							async: false
						});
					}else{
						bootbox.alert(Message.MSG_PLEASE_ENTER_A_NEW_POSITION_CODE);
					}
				}else if(check == 1){
					if($('#txtPositionName').val() == positionName){
						bootbox.alert(Message.MSG_NO_INFORMATION_CHANGED);
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
									bootbox.alert(Message.MSG_EDIT_SUCCESSFULLY);
									$('#add').modal('hide');
									$('#txtPositionCode').val(null);
									$('#txtPositionName').val(null);
									searchData();
									check = 0;
								}else if(xhr.status === 500){
									bootbox.alert(Message.MSG_EDIT_FAILED);
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
	$(".modal-title").text(Label.LABEL_ADD_POSITION);
	$('#btnModalNext').show();
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
				positionID: $(this).attr("id")
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
            bootbox.alert(Message.MSG_PLEASE_SELECT_THE_DATA_TO_BE_DELETED);
            return false;
    }else{
    	bootbox.confirm(Message.MSG_DO_YOU_WANT_TO_REMOVE_THE_SELECTED_ITEMS, function(result) {
			if(result == true){
				deleteData();
				searchData();
				$('#checkboxAll').prop('checked', false);
				if(status500 === 0){
					bootbox.alert(Message.MSG_DELETE_SUCCESS + " " + status200 + " " + Message.MSG_LIST);
				}else{
					bootbox.alert(Message.MSG_DELETE_SUCCESS + " " + status200 + " " + Message.MSG_LIST + " " + Message.MSG_DELETE_FAILED + " " + status500 + " " + Message.MSG_LIST);
				}

				status200 = 0;
				status500 = 0;
			}
		});
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
    return checkdDb.responseJSON;
}

$("#checkboxAll").click(function(){
    $(".checkboxTable").prop('checked', $(this).prop('checked'));
    $.each($(".checkboxTable[inUse=1]"),function(index, value){
        $(this).prop("checked", false);
    });
});

$('#Table').on("click", ".checkboxTable", function () {
	if($(this).attr("inUse") > 0){
    	$(this).prop("checked", false);
    	bootbox.alert(Message.MSG_INUSE);
    }
    if($(".checkboxTable:checked").length == $(".checkboxTable[inUse=0]").length && $(".checkboxTable[inUse=0]").length != 0){
        $("#checkboxAll").prop("checked", true);
    }else{
        $("#checkboxAll").prop("checked", false);
    }
});