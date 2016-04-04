var paggination = Object.create(UtilPaggination);
var checkSearch = false;

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

    if(jsonData.length <= 0)
        bootbox.alert("ไม่พบข้อมูล");

    $('#checkboxAll').prop('checked', false);
    $('#ResualtSearch').empty();

    var tableData = "";

    jsonData.forEach(function(value){
        tableData = ''
            + '<tr id="' + value.id + '">'
            + '<td class="text-center">'
            + '<input inUse="' + (value.inUse > 0 ? 1 : 0) + '" id="' + value.id + '" class="checkboxTable" type="checkbox" />'
            + '</td>'
            + '<td class="text-center">'
            + '<button onclick="openEdit($(this))" type="button" class="btn btn-xs btn-info" ><span name="editClick" class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></button>'
            + '</td>'
            + '<td id="tdEmpCode" class="text-center">' + value.empCode + '</td>'
            + '<td id="tdEmpName" class="text-center">' + value.empFirstName + '</td>'
            + '<td id="tdEmpLastname" class="text-center">' + value.empLastName + '</td>'
            + '<td id="tdEmpNickname" class="text-center">' + value.empNickName + '</td>'
            + '<td id="tdEmpPosition" class="text-center">' + value.emPosition.positionName + '</td>'
            + '<td id="tdEmpTeam" class="text-center">' + value.emTeam.teamName + '</td>'
            + '<td id="tdEmpRole" class="text-center">' + value.roleCode + '</td>'
            + '<td id="tdEmpUsername" class="text-center">' + value.userName + '</td>'
            + '<td id="tdEmpPassword" class="text-center">' + value.password + '</td>'
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