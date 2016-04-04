$(document).ready(function(){
    $('#btnLogout').click(function(){
        location.href = contextPath + "/resources/j_spring_security_logout";
    });
});
function test(arr){
    for(var i=0; arr.length > i ;i++){
    var navigator = "<li class='active'>"+arr[i]+"</li>";
    $('#pathNav').append(navigator);
    }
}