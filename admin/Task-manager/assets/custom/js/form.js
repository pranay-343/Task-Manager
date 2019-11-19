


function ManageFormStaus(a, b) {

    // $('#loading-overlay').show();

    $.post('form/manageFormStaus', {id: a, status: b}, function (data) {
        // $('#loading-overlay').hide();  
        if (data) {

            if (b == 0) {
                $('#form_deactive' + a).addClass('hide');
                $('#form_active' + a).removeClass('hide');
            } else {
                $('#form_deactive' + a).removeClass('hide');
                $('#form_active' + a).addClass('hide');
            }
        }
    });


}

function FormUserDeletedata(a)
{
    $('#custom_modal_id').val(a);
    $('#redirect_url').val('https://loggedinapp.com/admin/master_forms/formBuilder_leads.php');
    $('#set_mod').val('Rm9ybVVzZXJEZWxldGU=');

    createUrl('https://loggedinapp.com/admin/master_forms/master_forms_operations.php', 'Are you sure you want to delete this?');
    $('#myModalForAlert').modal('show');

}
