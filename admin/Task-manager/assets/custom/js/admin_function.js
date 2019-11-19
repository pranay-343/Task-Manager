
function redirect_url(redirect_url_path)
{

    window.location.href = "" + redirect_url_path;

}
function serverResponse(id, res, alertClass) {

    var tm = "2500";
    var resmsg1 = '<div class="alert alert-dismissable alert alert-' + alertClass + '"><a href="#" class="close" data-dismiss="alert" aria-label="close"> x </a><span>' + res + '</span> </div>';

    $('#' + id).show();
    $('#' + id).html(resmsg1);
    $('body,html').animate({scrollTop: 0}, 500);
    if (alertClass == 'success') {
        window.setTimeout(function () {
            $('#' + id).html("");
            //   });
        }, tm);
    }
}

//  for  submit form   only post not file 
function form_submit(formid, resid) {

    var url = $("#" + formid).attr('action');

    if (url == '' || url == undefined) {
        alert('form action is required');
        return false;
    }

    if ($("#" + formid).valid()) {
        $('.loading-overlay').show();
        var form_value = $("#" + formid).serialize();

        $.post(url, form_value, function (data) {
            console.log(data);
            $(".loading-overlay").hide();
            var parsedData = JSON.parse(data);
            console.log(parsedData);
            var res_type = parsedData[0]; //success  info warning danger
            var msg = parsedData[1];

            if (res_type == 'redirect') {
                setTimeout(function () {
                    location.href = parsedData[2]
                }, 3000);
                res_type = 'success';
            }
            if (res_type == 'success' || res_type == 'info') {
                $("#" + formid)[0].reset();

            }

            serverResponse(resid, msg, res_type);

            $('html,body').animate({scrollTop: 0}, 300);

        });
    }
}


//  for  submit form  with file 
function submit_form(formid, resid ="") {

    var url = $("#" + formid).attr('action');

    if (url == '' || url == undefined) {
        alert('form action is required');
        return false;
    }

    if ($("#" + formid).valid()) {
        $('.loading-overlay').show();
      
       $("#" + formid).submit(function (e) {
             e.preventDefault(); 
            $.ajax({
                url: url,
                type: "post",
                data: new FormData(this),
                processData: false,
                contentType: false,
                cache: false,
                async: false,
                success: function (data) {
                    
                    $(".loading-overlay").hide();
                    
                    var parsedData = JSON.parse(data);
                    console.log(parsedData);
                    
                    var res_type = parsedData[0]; //success  info warning danger
                    var msg = parsedData[1];

                    if (res_type == 'redirect') {
                        setTimeout(function () {
                            location.href = parsedData[2]
                        }, 3000);
                        res_type = 'success';
                    }
                    
                    if (res_type == 'success' || res_type == 'info') {
                        $("#" + formid)[0].reset();

                    }
                     
                    serverResponse(resid, msg, res_type);

                    $('html,body').animate({scrollTop: 0}, 300);
                }
            });
        });
    }
}

//for modal popup code start

function open_modal(modal_element) {

    $('.datepicker').datepicker({});
    $('' + modal_element).modal('show');

}
function close_modal(modal_element) {

    $('' + modal_element).modal('hide');

}
//for modal popup code end


//char counter in description
$(document).on('keyup', '.textarea-char-counter', function (e) {

    var len = $(this).val().length;
    if (len > 500) {
        $(this).val($(this).val().substring(0, 500));
    } else {
        $('.char-counter').text(len);
    }


});




