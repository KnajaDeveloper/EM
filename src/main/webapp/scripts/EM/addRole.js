var paggination = Object.create(UtilPaggination);
var roleName;
var arrEmpCode=[] ;
var arrRoleCode=[] ;
var arrRoleChang=[] ;
var json = [];
//////////////////////////////////////////////////////////////////////////////
$(document).ready(function () {
    appRole();
});  //-- show--//
//////////////////////////////////////////////////////////////////////////////
$("#search").click(function () {
    $('input[name=radioAll_]').prop('checked', false);
    arrRoleChang=[];
    searchData();
    //console.log(json+"555");
    if (json.length <= 0) {
        bootbox.alert(Message.MESSAGE_DATA_NOT_FOUND);
    }
}); //-- --//
//////////////////////////////////////////////////////////////////////////////
paggination.setEventPaggingBtn("paggingSimple", paggination);
paggination.loadTable = function loadTable(jsonData) {
    json = jsonData;
    if (jsonData.length <= 0) {

    }
    $('#ResualtSearch').empty();
    var tableData = "";
    var num = 1;

    jsonData.forEach(function (value) {

            tableData = ''
                + '<tr id="tr_'+num+'" >'
                + '<td id="tdEmpCode_' + num + '" class="text-center" style="color: #000">'
                + value.empCode
                + '</td>'
                + '<td id="tdName_' + num + '" class="text-left" style="color: #000">'
                + value.empFirstName +"  "+ value.empLastName
                + '</td>'
                + '<td id="tdPosition_' + num + '" class="text-left" style="color: #000">'
                + value.emPosition.positionName
                + '</td>'
                + '<td id="tdEmTeam_' + num + '" class="text-left" style="color: #000">'
                + value.emTeam.teamName
                + '</td>'
                + '</tr>';

        $('#ResualtSearch').append(tableData);

            for(var i = 0 ; roleName.length > i ; i++) {
            tableData = ''

                + '<td  class="text-center" style="color: #000">' +
                '<input  status="roleCodeCheck_'+roleName[i].roleCode+'" radioNum="radioNum_'+roleName[i].roleCode+'" empcode="emp_'+ value.empCode + '" type="radio" name="radio_'+value.empCode+'">'
                + '</td>'
            $('#tr_'+num).append(tableData);
        };
        num++;
        if(value.roleCode != null && value.roleCode !='')
        {
            arrRoleChang.push(value.roleCode);
            //console.log(value.roleCode+"<<<"+value.empCode);
            $('input[status=roleCodeCheck_'+value.roleCode+'][name=radio_'+value.empCode+']').prop('checked', true);
        }
    });

};
//////////////////////////////////////////////////////////////////////////////
$("#save").click(function () {
    arrEmpCode=[];arrRoleCode=[];role=false;
    $('input[name^=radio_]:checked').each(function () {
        var empCode = $(this).attr('name').split("radio_")[1];
        arrEmpCode.push(empCode);
        if( $('input[status^=roleCodeCheck_]:checked'))
        {
            var roleCode = $(this).attr('status').split("roleCodeCheck_")[1];
            arrRoleCode.push(roleCode)
        }
    });
    for(var i= 0 ; arrRoleChang.length >= i ; i++) {
        if (arrRoleCode[i] != arrRoleChang[i]) {
            role = true ; break;
        }
    }
    //console.log(arrRoleCode);console.log(arrRoleChang);
    //console.log(arrEmpCode.length); console.log(role);
    if (arrEmpCode.length > 0  ) {
        if(role == true)
        {
            bootbox.confirm(Message.MESSAGE_SAVE, function (result) {
                if (result === true) {
                    //console.log(arrEmpCode.length);
                    for (var i = 0; arrEmpCode.length > i; i++) {
                        saveAppRole(i);

                    }
                    bootbox.alert(Message.MESSAGE_SAVE_SUCCESS);
                    $('input[name=radioAll_]').prop('checked', false);
                    arrRoleChang=[];
                    searchData();
                    arrEmpCode=[];arrRoleCode=[];
                }
            });
        }
        else { bootbox.alert(Message.MESSAGE_NO__DATA_HAS_CHANGED);  arrRoleChang=[];arrEmpCode=[];arrRoleCode=[];role=false;searchData();}

    }
    else { bootbox.alert(Message.MESSAGE_NO__DATA_HAS_CHANGED); }


}); //-- --//
var role;
//////////////////////////////////////////////////////////////////////////////
$("#canCel").click(function () {
    arrEmpCode=[];arrRoleCode=[];role=false;
    $('input[name^=radio_]:checked').each(function () {
        var empCode = $(this).attr('name').split("radio_")[1];
        arrEmpCode.push(empCode);
        if( $('input[status^=roleCodeCheck_]:checked'))
        {
            var roleCode = $(this).attr('status').split("roleCodeCheck_")[1];
            arrRoleCode.push(roleCode)
        }
    });
    //console.log(">"+arrRoleCode); console.log("<"+arrRoleChang);
    for(var i= 0 ; arrRoleChang.length >= i ; i++) {
        if (arrRoleCode[i] != arrRoleChang[i]) {
            role = true ; break;
        }

    }
    //console.log(role);
    if(role == true)
    {
        bootbox.confirm(Message.MESSAGE_NO_CANCEL_DATA_HAS_CHANGED, function (result) {
            if (result === true) {
                arrRoleChang=[];arrEmpCode=[];arrRoleCode=[];
                $('input[name=radioAll_]').prop('checked', false);
                searchData();
            }
        });
    }
    else { arrRoleChang=[];arrEmpCode=[];arrRoleCode=[];role=false;searchData();}
}); //-- --//
//////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[status^=roleCodeCheck_]", function () {

    var id = $(this).attr('status').split('roleCodeCheck_')[1];
    //console.log(id);
    if($('input[status=roleCodeCheckAll_'+id+']').prop('checked') == false){
        $('input[name=radioAll_]').prop('checked', false);
    }
    var rdNum = $('input[radioNum^=radioNum_'+id+']').length;
    //console.log(rdNum);9
    var radioCheck =  $('input[status=roleCodeCheck_'+id+']:checked').length;
   if (radioCheck == rdNum-1){
       $('input[status=roleCodeCheckAll_'+id+']').prop('checked', true);
   }
}); //--checkAppRole--//
//////////////////////////////////////////////////////////////////////////////
$('#data').on("click", "[name^=radioAll_]", function () {
    var id = $('input[status^=roleCodeCheckAll_]:checked').attr('status').split('roleCodeCheckAll_')[1];
    //console.log(id);
    $('input[status^=roleCodeCheck_'+id+']').prop('checked', $(this).prop('checked'));

}); //--checkAllData--//
//////////////////////////////////////////////////////////////////////////////
var appRoleHave  ;
function searchData() {
    if($("#appRole").prop('checked') == true){
        appRoleHave = "1" ;
    }
    else  if($("#notApprole").prop('checked') == true)
    {
        appRoleHave = "2";
    }
    else  if($("#allApprole").prop('checked') == true)
    {
        appRoleHave = "3";
    }
    var dataJsonData = {
        empCode:      $("#empCode").val(),
        empFirstName: $("#empFirstName").val(),
        empLastName:  $("#empLastName").val(),
        emPosition:   $("#emPosition").val(),
        emTeam:       $("#emTeam").val(),
        appRoleHave:   appRoleHave
    }
    paggination.setOptionJsonData({
        url: contextPath + "/ememployees/findselectDataAddRole",
        data: dataJsonData
    });
    paggination.setOptionJsonSize({
        url: contextPath + "/ememployees/addRolePaggingSize",
        data: dataJsonData
    });
    paggination.search(paggination);
}  //--functionSearch--//
//////////////////////////////////////////////////////////////////////////////
function appRole() {
    var responseResult = null;
    var dataJsonData = {
    }
    responseResult = $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            Accept: "application/json"
        },
        url: contextPath + '/ememployees/findappRoleName',
        data: dataJsonData,
        complete: function (xhr) {

        },
        async: false
    });
    roleName = jQuery.parseJSON(responseResult.responseText);
    //console.log(roleName[0].roleName);
    var tableData = "";
    var numRole =0;
    if(roleName.length != null ) {
        roleName.forEach(function () {
            tableData = ''
                + '<th id="roleName_' + roleName[numRole].roleCode + '" class="text-center" style="width: 30px; color:#000">' +
                roleName[numRole].roleName
                + '<div  class="text-center"><input type="radio" radioNum="radioNum_' + roleName[numRole].roleCode + '" name="radioAll_" status="roleCodeCheckAll_' + roleName[numRole].roleCode + '"></div>'
                + '</th>';
            $('#column').append(tableData);
            numRole++;
        });
    }
} //----//
//////////////////////////////////////////////////////////////////////////////
function saveAppRole(i) {
    var responseResult = null;
    var dataJsonData = {
        arrEmpCode : arrEmpCode[i],
        arrRoleCode : arrRoleCode[i]
    }
    responseResult = $.ajax({
        type: "POST",
        //contentType: "application/json; charset=utf-8",
        //dataType: "json",
        //headers: {
        //    Accept: "application/json"
        //},
        url: contextPath + '/ememployees/saveOrUpdateAppRoleCode',
        data: dataJsonData,
        complete: function (xhr) {

        },
        async: false
    });
}
//////////////////////////////////////////////////////////////////////////////