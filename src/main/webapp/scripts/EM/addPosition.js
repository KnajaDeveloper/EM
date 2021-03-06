var paggination = Object.create(UtilPaggination);
var checkSearch = false;

$('#btnSearch').click(function() {
	searchData();
	checkSearch = true;
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

   	$('#ResualtSearch').empty();

   	if(jsonData.length <= 0){
        $('#ResualtSearch').append('<tr><td colspan = 4 class="text-center">' + Message.MSG_DATA_NOT_FOUND + '</td></tr>');
    }

   	$('#checkboxAll').prop('checked', false);

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
            + '<td id="tdPositionName" class="">' + value.positionName + '</td>'
        + '</tr>';

        $('#ResualtSearch').append(tableData);
    });
};

var positionName;

function openModalEdit(element){
	check = 1;
	$('#btnModalNext').hide();
	$('.modal-title').text(Label.LABEL_EDIT_POSITION);
    $('#txtPositionCode').val(element.parent("td:eq(0)").parent("tr:eq(0)").children("#tdPositionCode").text()).attr('disabled', true).popover('hide');;
    positionName = element.parent("td:eq(0)").parent("tr:eq(0)").children("#tdPositionName").text();
    $('#txtPositionName').val(positionName).popover('hide');
}

// function checkEMPositionCode() {
//   	var elem = document.getElementById('txtPositionCode').value;
//   	if(!elem.match(/^([a-z0-9\_])+$/i)){
//   		$('#txtPositionCode').attr("data-content" , Message.PLEASE_ENTER_THE_CODE_AS_a_TO_z_OR_A_TO_Z_OR_0_TO_9).popover('show');
//   		return false;
//   	}else{
//   		return true;
//   	}
//  };

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
            $('#txtPositionCode').val(null);
            $('#txtPositionName').val(null);
        }
	}else{
		if($('#txtPositionCode').val() == ""){
			$('#txtPositionCode').attr("data-content" , Message.MSG_PLEASE_FILL).popover('show');
		}else if($('#txtPositionName').val()  == ""){
			$('#txtPositionName').popover('show');
		}else{
			var emPosition = {
				positionCode: $('#txtPositionCode').val(),
				positionName: $('#txtPositionName').val()
			};
			var responseHeader = null;
			if(check == 0){
				if(checkData() == 0){
					$.ajax({
						type: "POST",
						headers: {
							Accept: "application/json"
						},
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						url: contextPath + '/empositions',
						data : JSON.stringify(emPosition),
						complete: function(xhr){
							if(xhr.status == 201){
								if(id == 'Add'){
									bootbox.alert(Message.MSG_ADD_MORE_SUCCESS);
									$('#add').modal('hide');
								}
								$('#txtPositionCode').val(null);
								$('#txtPositionName').val(null);
								if(checkSearch == true){
									var pageNumber = $("#paggingSimpleCurrentPage").val();
									searchData();
									paggination.loadPage(pageNumber, paggination);
								}
							}else if(xhr.status == 500 || xhr.status == 0){
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
						type: "POST",
						headers: {
							Accept: "application/json"
						},
						url: contextPath + '/empositions/findeditEMPosition',
						data : emPosition,
						complete: function(xhr){
							if(xhr.status === 200){
								bootbox.alert(Message.MSG_EDIT_SUCCESSFULLY);
								$('#add').modal('hide');
								$('#txtPositionCode').val(null);
								$('#txtPositionName').val(null);
								var pageNumber = $("#paggingSimpleCurrentPage").val();
								paggination.loadPage(pageNumber, paggination);
							}else if(xhr.status === 500 || xhr.status == 0){
								bootbox.alert(Message.MSG_EDIT_FAILED);
							}
						},
						async: false
					});
				}
			}
		}
	}
});

$('#btnAdd').click(function() {
	check = 0;
	$(".modal-title").text(Label.LABEL_ADD_POSITION);
	$('#btnModalNext').show();
	$('#txtPositionCode').attr('disabled', false).popover('hide');
	$('#txtPositionName').popover('hide');
});

var status0 = 0;
var status200 = 0;
var status500 = 0;

function deleteData() {
	$.each($(".checkboxTable:checked"),function(index,value){
	    $.ajax({
			type: "POST",
			headers: {
				Accept: "application/json"
			},
			url: contextPath + '/empositions/findDeletePosition',
			data : {
				positionID: $(this).attr("id")
			},
			complete: function(xhr){
				if(xhr.status == 0)
					status0++;
				if(xhr.status == 200)
					status200++;
				if(xhr.status == 500)
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

				if(status0 > 0){
					bootbox.alert(Message.MSG_DELETE_FAILED);
				}else if(status500 == 0){
					bootbox.alert(Message.MSG_DELETE_SUCCESS + " " + status200 + " " + Message.MSG_LIST);
				}else{
					bootbox.alert(Message.MSG_DELETE_SUCCESS + " " + status200 + " " + Message.MSG_LIST + " " + Message.MSG_DELETE_FAILED + " " + status500 + " " + Message.MSG_LIST);
				}

				status0 = 0;
				status200 = 0;
				status500 = 0;

				var pageNumber = $("#paggingSimpleCurrentPage").val();
				searchData();
				paggination.loadPage(pageNumber, paggination);

				$('#checkboxAll').prop('checked', false);
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

	if(checkdDb.responseJSON == null){
		return 0;
	}

    return checkdDb.responseJSON;
}

$("#checkboxAll").click(function(){
	if($(".checkboxTable[inUse=0]").length == 0){
        bootbox.alert(Message.MSG_DATA_ALL_IN_USED);
        $(this).prop("checked", false);
    }
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