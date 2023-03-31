document.addEventListener("DOMContentLoaded", function () {

    let form = document.querySelector("#login-form")
    let nombre = document.querySelector("#inputName")
    let email = document.querySelector("#inputEmail")
    let password = document.querySelector("#inputPassword")
    let textArea = document.querySelector("#inputMensaje")

    function validate() {
        let vnombre = nombre.value;
        if(vnombre.length === 0){
            document.querySelector("#nameHelp").innerHTML = "Por favor, ingresa tú nombre";
            return false;
        }
        
        let emailValue = email.value;
        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        console.log(email.value);
        if (!emailRegex.test(emailValue)) {
            document.querySelector("#emailHelp").innerHTML = "Por favor, ingresa un correo electrónico válido";
            return false;
        }
    
        let passwordValue = password.value;
        if (passwordValue.length < 6) {
         document.querySelector("#passwordHelp").innerHTML = "La contraseña debe tener al menos 6 caracteres";
            return false;
        }

        let vTexArea = textArea.value;
        if(vTexArea.length === 0){
            document.querySelector("#mensajeHelp").innerHTML = "Por favor, un comentario";
            return false;
        }

        return true;
    }  
    $(document).ready( function () {
        $('#miTabla').DataTable();
    } );

     form.addEventListener("submit", function (event) {
     if (!validate()) {
        event.preventDefault();
        } else {
        alert('El formulario se envio correctamente');
        }
     
    })
 
});

