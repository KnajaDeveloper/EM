var checkedRows = [];
var DeSuccess = 0;
var DeFail = 0;
//var checkBoxDisable = [] ;
var json=[];
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

        var ob = jQuery.parseJSON(responseResult.responseText);

        checkCode();
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

                            bootbox.alert("บันทึกข้อมูลสำเร็จ");
                            $('#ModalAdd').modal('hide');
                            $("input[name='add']").val(null);
                        }
                        else if (id === 'next') {
                            $("input[name='add']").val(null);
                        }

                    } else if (xhr.status === 500) {
                        bootbox.alert("บันทึกข้อมูลไม่สำเร็จ");
                    }
                },
                async: false
            });
        }
        else {
            bootbox.alert("ซ้ำครับ");
        }


    }


    else if ($("#teamCode").val() == "") {
        $("#teamCode").popover('show');
    }
    else if ($("#teamName").val() == "") {
        $("#teamName").popover('show');
    }
    searchData();
}); //-- AddTeam --//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#cancelAdd").click(function () {
    $('#Add').modal('hide');
    $("input[name='add']").popover('hide');
    $("input[name='add']").val(null);
}); //-- cancelAdd--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#cancelEdit").click(function () {
    $('#edit').modal('hide');
    $("input[name='editText']").popover('hide');
    $("input[name='editText']").val(null);
}); //--cancelEdit--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#search").click(function () {

    searchData();
    if( json.length <= 0)
    {
        bootbox.alert("ไม่พบข็อมูล");
    }
   // var a = null;
   //a= $.ajax({
   //     type: "GET",
   //     contentType: "application/json; charset=utf-8",
   //     dataType: "json",
   //     headers: {
   //         Accept: "application/json"
   //     },
   //     url: contextPath + '/ememployees/findProjectByemTeam',
   //     //  data: dataJsonData,
   //     complete: function (xhr) {
   //
   //     },
   //     async: false
   // });
   // var res =jQuery.parseJSON(a.responseText);
   // console.log(res);
   // for (var i = 0; res.size > i ; i++)
   // {
   //     console.log();
   // }
    //bootbox.alert("ไม่พบข้อมูล"+searchData()) ;
    //var responseHeader = null;
    //responseHeader = $.ajax({
    //    type: "GET",
    //    contentType: "application/json; charset=UTF-8",
    //    dataType: "json",
    //    headers: {
    //        Accept: "application/json"
    //    },
    //
    //    url: contextPath + '/emteams/findProjectBytypeTeamCode',
    //    data: {
    //        searchCode: $("input[name='searchCode']").val(),
    //        searchName: $("input[name='searchName']").val()
    //    },
    //
    //    complete: function (xhr) {
    //
    //        if (xhr.status === 200) {
    //            bootbox.alert("55555");
    //        } else if (xhr.status === 500) {
    //            bootbox.alert("6666");
    //        }
    //    },
    //    async: false
    //});
    //var Obj = jQuery.parseJSON(responseHeader.responseText);
    //var tableData = "";

    //$.each(Obj, function (key, val) {
    //    tableData = ''
    //        + '<tr style="background-color: #fff">'
    //        + '<td class="text-center">'
    //        + '<input class="check" type="checkbox" name="checkdDelete" />'
    //        + '</td>'
    //        + '<td class="text-center">'
    //        + '<button id="btnEdit' + key + '" type="button" class="btn btn-info" data-toggle="modal" data-target="#add" data-backdrop="static"><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
    //        + '</td>'
    //        + '<td id="tdTeamCode' + key + '" class="text-center" style="color: #000">'
    //        + val["teamCode"]
    //        + '</td>'
    //        + '<td id="tdTeamName' + key + '" class="text-center" style="color: #000">'
    //        + val["teamName"]
    //        + '</td>'
    //        + '</tr>';
    //
    //    $('#ResualtSearch').append(
    //        tableData
    //    );
    //});
}); //--searchData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[id^=btnEdit]", function () {

    var id = this.id.split('t')[2];
    $('#editCode').val($('#tdTeamCode' + id).text());
    $('#editName').val($('#tdTeamName' + id).text());

}) //--getDataEdit--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#btnDelete").click(function () {
    //alert(checkedRows.length);
    var i = 0;
    for (i; checkedRows.length > i; i++) {
        //alert(checkedRows[i] + 555555555);
        //checkIdKey(i);
        DeleteData(i);
    }
    bootbox.alert(" ลบข้อมูลสำเร็จ : " + DeSuccess + "  ลบข้อมูลไม่สำเร็จ : " + DeFail);
    DeSuccess = 0;
    DeFail = 0;
    checkedRows = [];
    $("#checkAll").attr('checked', false);
    searchData();
}); //-- deleteData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "#checkAll", function () {


        $(".check").prop('checked', $(this).prop('checked'));
    

    var id = 1;
    var i = $('#data').find('tr').length;
    var num;
    //alert($('#data').find('tr').length);
    for (i; i > id; id++) {
        if ($(this).prop('checked') == true) {
            num = checkedRows.indexOf($('#tdTeamCode' + id).text())
            if (num != "") {
                checkedRows.push($('#tdTeamCode' + id).text());
            }
        }
        else {
            num = checkedRows.indexOf($('#tdTeamCode' + id).text());
            checkedRows.splice(num, 1);
        }

    }
    //alert(">>> " + checkedRows + "..");
}); //--checkAllData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[id^=chDelete]", function () {
    var id = this.id.split('e')[3];
    if ($(this).prop('checked') == true) {
        checkedRows.push($('#tdTeamCode' + id).text());
        //alert(">>> " + checkedRows + "..");

    }
    else {
        var num = checkedRows.indexOf($('#tdTeamCode' + id).text());
        checkedRows.splice(num, 1);
        //alert(">>> " + checkedRows + "..");
    }
}); //--checkData--//
//////////////////////////////////////////////////////////////////////////////////////////////////
$("#saveEdit").click(function () {
    var teamCode = $('#editCode').val();
    var teamName = $('#editName').val();
    EditData(teamCode, teamName);
    searchData();
}); //-- EditData--//
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
        checkIdKey(value.id);
        if (checkBoxDisable != "" ) {
            tableData = ''

                + '<tr  style="background-color: #fff">'
                + '<td class="text-center">'
                + '<input id="chDelete' + key + '" class="check" type="checkbox" name="checkdDelete" disabled="true" />'
                + '</td>'
                + '<td class="text-center">'
                + '<button id="btnEdit' + key + '" type="button" class="btn btn-info" data-toggle="modal" data-target="#ModalEdit" data-backdrop="static" ><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
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
        } else {
            tableData = ''

                + '<tr  style="background-color: #fff">'
                + '<td class="text-center">'
                + '<input id="chDelete' + key + '" class="check" type="checkbox" name="checkdDelete"  />'
                + '</td>'
                + '<td class="text-center">'
                + '<button id="btnEdit' + key + '" type="button" class="btn btn-info" data-toggle="modal" data-target="#ModalEdit" data-backdrop="static" ><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
                + '</td>'
                + '<td id="tdTeamCode' + key + '" class="text-center" style="color: #000">'
                + value.teamCode
                + '</td>'
                + '<td id="tdTeamName' + key++ + '" class="text-center" style="color: #000">'
                + value.teamName
                + '</td>'
                + '</tr>';
            $('#ResualtSearch').append(
                tableData
            );
        }
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
        url: contextPath + '/emteams/findDeleteTeam',
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
        url: contextPath + '/emteams/findEditTeam',
        data: dataJsonData,
        complete: function (xhr) {
            if (xhr.status === 200) {
                $('#ModalEdit').modal('hide');
                bootbox.alert(" แก้ไขข้อมูลสำเร็จ");

            } else if (xhr.status === 500) {
                bootbox.alert("แก้ไขข้อมูลไม่สำเร็จ");
            }
        },
        async: false
    });
} //--functionEditData--//
/////////////////////////////////////////////////////////////////////////////////////////////////
function checkCode() {
    var elem = $("#teamCode").val();
    if (!elem.match(/^([a-z0-9\_])+$/i)) {
        bootbox.alert("กรุณากรอกข้อมูลรหัสพนักงานเป็น a-Z หรือ A-Z หรือ 0-9 ");
        $("#teamCode").val("");
    }
}; //--functionCheck a-z --//
/////////////////////////////////////////////////////////////////////////////////////////////////
function checkIdKey(emTeam) {
    var responseResult = null;
    var dataJsonData = {
        emTeam : emTeam

    }
    responseResult = $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            Accept: "application/json"
        },
        url: contextPath + '/ememployees/findProjectByemTeam',
        data: dataJsonData,
        complete: function (xhr) {

        },
        async: false
    });
    checkBoxDisable = jQuery.parseJSON(responseResult.responseText);
    console.log(checkBoxDisable);

} //--functionCheckID--//