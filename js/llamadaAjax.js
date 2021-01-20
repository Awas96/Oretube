document.addEventListener('DOMContentLoaded', function(){
    function validarloginusuario(source, args){ //Sourcer es el control y args es valor del control
        $.ajax({
            type: "POST",
            url: "Registro.aspx/esta",
            async: false,
            ContentType: "application/json; charset=utf-8",
            data: '("login":"' + args.Value + '")',
            dataType: "json",
            success: function (response){
                args.IsValid = response.d; //devuelve false o true
                alert(response.d);
            }
        });
    }
});