var checkedRows = [];
var DeSuccess = 0;
var DeFail = 0;
var checkBoxDisable = [] ;
var json = [];
var ob ;
var edit = '' ;
//////////////////////////////////////////////////////////////////////////////////////////////////
var paggination = Object.create(UtilPaggination);
$(document).ready(function () {

});  //-- show--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('[id^=btnM]').click(function () {

    var id = this.id.split('M')[1];
    var responseResult = null;
    var teamCode = $("#teamCode").val();
    if ($("#teamCode").val() != "" && $("#teamName").val() != "") {

        var dataJsonData = {
            teamCode: teamCode

        }
        responseResult = $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            headers: {
                Accept: "application/json"
            },
            url: contextPath + '/emteams/findCheck',
            data: dataJsonData,
            complete: function (xhr) {

            },
            async: false
        });

         ob = jQuery.parseJSON(responseResult.responseText);

        checkCode(id);

    }
    else if ($("#teamCode").val() == "") {
        $("#teamCode").popover('show');
    }
    else if ($("#teamName").val() == "") {
        $("#teamName").popover('show');
    }

}); //-- AddTeam --//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#cancelAdd").click(function () {
    $('#Add').modal('hide');
    $("input[name='add']").popover('hide');
    $("input[name='add']").val(null);
}); //-- cancelAdd--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#cancelEdit").click(function () {
    if($('#editName').val()!= edit)
    {
        bootbox.confirm(Message.MESSAGE_NO_CANCEL_DATA_HAS_CHANGED, function (result) {
            if (result === true) {
                $('#ModalEdit').modal('hide');
                $("input[name='editText']").popover('hide');
                $("input[name='editText']").val(null);
            }

        });
    }
    else {$('#ModalEdit').modal('hide');}

}); //--cancelEdit--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#search").click(function () {
    $("#checkAll").attr('checked', false);
    searchData();
    if (json.length <= 0) {
        bootbox.alert(Message.MESSAGE_DATA_NOT_FOUND);
    }

}); //--searchData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[id^=btnEdit]", function () {

    var id = this.id.split('t')[2];
    $('#editCode').val($('#tdTeamCode' + id).text());
    $('#editName').val($('#tdTeamName' + id).text());
    edit=$('#editName').val();

}) //--getDataEdit--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#btnDelete").click(function () {
    checkedRows = [];
    $('input[status^=check]:checked').each(function () {
        if( $('input[status^=check]:checked'))
        {
            var roleCode = $(this).attr('teamCode').split("code_")[1];
            checkedRows.push(roleCode);
        }
    });
    //console.log(checkedRows);
    if (checkedRows.length > 0) {
        bootbox.confirm(Message.MESSAGE_REMOVE_SELECT, function (result) {
            if (result === true) {
                for (var i=0; checkedRows.length > i; i++) {
                    DeleteData(i);
                }
                bootbox.alert(Message.MESSAGE_DELETE_SUCCESS+" " + DeSuccess +" "+ Message.MESSAGE_DELETE_FAIL + DeFail);
                DeSuccess = 0;
                DeFail = 0;
                checkedRows = [];
                $("#checkAll").attr('checked', false);
                searchData();
            }
        });
    } else if (checkedRows.length == 0) {
        bootbox.alert( Message.MESSAGE_PLEASE_SELECT_SELECT_DATA);
    }

}); //-- deleteData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "#checkAll", function () {
        $('[id^=chDelete]').prop('checked', $(this).prop('checked'));
}); //--checkAllData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[id^=chDelete]", function () {

    var checkNum = $('input[status=check]').length;
    var checkBoxCheck =  $('input[status=check]:checked').length;
    if (checkBoxCheck == checkNum){
        $('#checkAll').prop('checked', true);
    }
    else
    {
        $('#checkAll').prop('checked', false);
    }
}); //--checkData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#saveEdit").click(function () {

    if($('#editName').val()== edit)
    {
        bootbox.alert(Message.MESSAGE_NO_INFORMATION_CHANGED);////////////////////////////////////////////////////////////////////////////////////////
    }
    else
    {
        var teamCode = $('#editCode').val();
        var teamName = $('#editName').val();
        EditData(teamCode, teamName);
        searchData();
    }


}); //-- EditData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[id^=checkDisableDelete]", function () {
    bootbox.alert(Message.MESSAGE_DO_NOT_DELETE);
    var id = this.id.split('checkDisableDelete')[1];
    $("#checkDisableDelete"+id).attr('checked', false);

}); //--checkDataDelete--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("[id^=paggingSimpleBtn]").click(function () {
    if ($('#checkAll').prop('checked') == true){
        $('input[type=checkbox]').prop('checked', false);
    }
}); //--paggingSimpleBtn--//
//////////////////////////////////////////////////////////////////////////////////////////////////
paggination.setEventPaggingBtn("paggingSimple", paggination);
paggination.loadTable = function loadTable(jsonData) {
    json = jsonData;
    if (jsonData.length <= 0) {

    }
    $('#ResualtSearch').empty();
    var tableData = "";
    var key = 1;
    jsonData.forEach(function (value) {
            tableData = ''

                + '<tr  style="background-color: #fff">'
                + '<td class="text-center">'
                + '<input  id="' + (parseInt(value.inUse) > 0 ? 'checkDisableDelete' : 'chDelete')+ key + '" class="check" type="checkbox"  name="checkdDelete" '+(parseInt(value.inUse) > 0 ? '':'teamCode="code_'+value.teamCode+'" status="check"')+' />'
                + '</td>'
                + '<td class="text-center">'
                + '<button id="btnEdit' + key + '" type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#ModalEdit" data-backdrop="static" ><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
                + '</td>'
                + '<td id="tdTeamCode' + key + '" class="text-center" style="color: #000">'
                + value.teamCode
                + '</td>'
                + '<td id="tdTeamName' + key++ + '" class="text-center" style="color: #000">'
                + value.teamName
                + '</td>'
                + '</tr>';
            $('#ResualtSearch').append(tableData
            );
    });

};
function searchData() {

    var dataJsonData = {
        searchCode: $("input[name='searchCode']").val(),
        searchName: $("input[name='searchName']").val()
    }
    paggination.setOptionJsonData({
        url: contextPath + "/emteams/findProjectBytypeTeamCode",
        data: dataJsonData
    });
    paggination.setOptionJsonSize({
        url: contextPath + "/emteams/teamPaggingSize",
        data: dataJsonData
    });
    paggination.search(paggination);
}  //--functionSearch--//
//////////////////////////////////////////////////////////////////////////////////////////////////
function DeleteData(i) {
    var dataJsonData = {
        deleteCode: checkedRows[i]

    }

    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            Accept: "application/json"
        },
        url: contextPath + '/emteams/deleteTeam',
        data: dataJsonData,

        complete: function (xhr) {
            if (xhr.status === 200) {
                DeSuccess++;

            } else if (xhr.status === 500) {
                DeFail++;

            }
        },

        async: false

    });

} //--functionDelete--//
//////////////////////////////////////////////////////////////////////////////////////////////////
function EditData(teamCode, teamName) {
    var dataJsonData = {
        editCode: teamCode,
        editName: teamName
    }
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            Accept: "application/json"
        },
        url: contextPath + '/emteams/editTeam',
        data: dataJsonData,
        complete: function (xhr) {
            if (xhr.status === 200) {
                $('#ModalEdit').modal('hide');
                bootbox.alert(Message.MESSAGE_EDIT_SUCCESS);

            } else if (xhr.status === 500) {
                bootbox.alert( Message.MESSAGE_EDIT_FAIL);
            }
        },
        async: false
    });
} //--functionEditData--//
/////////////////////////////////////////////////////////////////////////////////////////////////
function checkCode(id) {
    var elem = $("#teamCode").val();
    // if (!elem.match(/^([a-z0-9\_])+$/i)) {
    //     bootbox.alert(Message.MESSAGE_PLEASE_ENTER_A_Z);
    //     $("#teamCode").val("");
    // }
    // else
    // {
        if (ob == "") {
            var addTeams = {
                teamCode: $("#teamCode").val(),
                teamName: $("#teamName").val()
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                headers: {
                    Accept: "application/json"
                },
                url: contextPath + '/emteams',
                data: JSON.stringify(addTeams),

                complete: function (xhr) {

                    if (xhr.status === 201) {

                        if (id === 'save') {

                            bootbox.alert(Message.MESSAGE_SAVE_SUCCESS);
                            $('#ModalAdd').modal('hide');
                            $("input[name='add']").val(null);
                        }
                        else if (id === 'next') {
                            $("input[name='add']").val(null);
                        }

                    } else if (xhr.status === 500) {
                        bootbox.alert(Message.MESSAGE_ADD_FAIL);
                    }
                },
                async: false
            });
        }
        else {
            bootbox.alert(Message.MESSAGE_CODE_DUPLICATE);
        }
        searchData();
    // }
}; //--functionCheck a-z --//
/////////////////////////////////////////////////////////////////////////////////////////////////
//function checkIdKey(emTeam) {
//    var responseResult = null;
//    var dataJsonData = {
//        emTeam: emTeam
//
//    }
//    responseResult = $.ajax({
//        type: "GET",
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        headers: {
//            Accept: "application/json"
//        },
//        url: contextPath + '/ememployees/findProjectByemTeam',
//        data: dataJsonData,
//        complete: function (xhr) {
//
//        },
//        async: false
//    });
//    checkBoxDisable = jQuery.parseJSON(responseResult.responseText);
//    //console.log(checkBoxDisable);
//
//} //--functionCheckID--//
/////////////////////////////////////////////////////////////////////////////////////////////////