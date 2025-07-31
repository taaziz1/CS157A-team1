function passwordFunction(){
    var x = document.getElementById("floatingPassword");
    var c =document.getElementById("passwordImage")
    if (x.type === "password") {
        x.type = "text";

    } else {
        x.type = "password";

    }
}