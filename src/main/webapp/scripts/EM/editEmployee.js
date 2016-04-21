var paggination = Object.create(UtilPaggination);
var checkSearch = false;
var status500 = 0;
var status200 = 0;

$('#btnSearch').click(function() {

    searchData();
    checkSearch = true;
});

function searchData() {
    var dataJsonData = {
        empCode:$('#empCode').val(),
        empFirstName:$('#empFirstName').val(),
        userName:$('#userName').val(),
        empNickName:$('#empNickName').val(),
        emTeam:$('#emTeam').val().split('#')[0],
        emPosition:$('#emPosition').val().split('#')[0]

    }

    paggination.setOptionJsonData({
        url:contextPath + "/ememployees/findPaggingData",
        data:dataJsonData
    });

    paggination.setOptionJsonSize({
        url:contextPath + "/ememployees/findPaggingSize",
        data:dataJsonData
    });

    paggination.search(paggination);
}

paggination.setEventPaggingBtn("paggingSimple",paggination);
paggination.loadTable = function loadTable (jsonData) {
    $('#ResualtSearch').empty();
    if(jsonData.length <= 0)
        $('#ResualtSearch').append('<tr><td colspan = 9 class="text-center">' + Message.MSG_DATA_NOT_FOUND + '</td></tr>');

    $('#checkboxAll').prop('checked', false);


    var tableData = "";

    jsonData.forEach(function(value){
        tableData = ''
            + '<tr id="' + value.id + '">'
            + '<td class="text-center">'
            + '<input inUse="' + (value.inUsed ? 1 : 0) + '" id="' + value.id + '" class="checkboxTable" type="checkbox" />'
            + '</td>'
            + '<td class="text-center">'
            + '<button onclick="openEdit($(this))" type="button" class="btn btn-xs btn-info" ><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
            + '</td>'
            + '<td id="tdEmpCode" class="text-left">' + value.empCode + '</td>'
            + '<td id="tdEmpName" class="text-left">' + value.empFirstName + '</td>'
            + '<td id="tdEmpLastname" class="text-left">' + value.empLastName + '</td>'
            + '<td id="tdEmpNickname" class="text-left">' + value.empNickName + '</td>'
            + '<td id="tdEmpPosition" class="text-left">' + value.emPosition.positionName + '</td>'
            + '<td id="tdEmpTeam" class="text-left">' + value.emTeam.teamName + '</td>'
            + '<td id="tdEmpRole" class="text-left">' + value.roleCode + '</td>'
            + '</tr>';
        $('#ResualtSearch').append(tableData);
    });
};
function openEdit(element){
    var id = element.parent().parent().attr("id");
    window.location.href = contextPath + '/ememployees/addEmployee?id='+id;
}
$('#Addemployee').click(function() {
    window.location.href = contextPath + '/ememployees/addEmployee';
});


function deleteData() {
    $.each($(".checkboxTable:checked"),function(index,value){
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            headers: {
                Accept: "application/json"
            },
            url: contextPath + '/ememployees/findDeleteEmployee',
            data : {
                id: $(this).attr("id")
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
                var pageNumber = $("#paggingSimpleCurrentPage").val();
                searchData();
                paggination.loadPage(pageNumber, paggination);

                $('#checkboxAll').prop('checked', false);
                if(status500 == 0){
                    bootbox.alert(Message.MSG_DELETE_SUCCESS + " " + status200 + " " + Message.MSG_LIST);
                }
                else{
                    bootbox.alert(Message.MSG_DELETE_SUCCESS + " " + status200 + " " + Message.MSG_LIST + " " + Message.MSG_DELETE_FAILED + " " + status500 + " " + Message.MSG_LIST);
                }
                status200 = 0;
                status500 = 0;
            }
        });
    }
});

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