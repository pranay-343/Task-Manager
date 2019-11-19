
function admin_url() {
  var URL = window.location.pathname 
  var str = URL.split("/");
  var admin_url = window.location.protocol + "/" + window.location.host + "/" +str[1]+ "/"  +str[2]+ "/"+str[3]+"/";
    var admin_url =  "/" +str[1]+ "/"  +str[2]+ "/"+str[3]+"/";
    console.log(admin_url);
  return  admin_url;
  
}
 //alert(admin_url());
function save_form(formBuilder) {
    // abhilash save data from database  
    $(".loading-overlay").show();
    var form_data_db = formBuilder.actions.getData('json');
    //  alert(form_data_db);
    console.log(form_data_db);
    ////////
    var form_name = $("#form_name").val();
    var form_descr = $("#form_descr").val();
   var  a = $("#form_id").val();
   var limitstatus = 0;
  var  editstatus = 0;
    if ($("#limitstatus").prop('checked') == true) {
        limitstatus = 1;
    }
    if ($("#editstatus").prop('checked') == true) {
        editstatus = 1;
    }
      if ($('#formbuliler_form').valid()); 
    if (form_name) {
        $(this).prop("disabled", true);
      var  posturl =   admin_url()+'form/formBuilder_Add_update';
        //   formBuilder_Add_update
        $.post(posturl, {
            editstatus: editstatus,
            limitstatus: limitstatus,
            a: a,
            form_descr: form_descr,
            status: 0,
            form_name: form_name,
            form_data: form_data_db
        }, function(data) {
            $(".loading-overlay").hide();
            var parsedData = JSON.parse(data);
            console.log(parsedData);
            //  alert(parsedData[0]);
            serverResponse('resajmsg', parsedData[0], "success");
            //   alert(parsedData[0]);
            if (parsedData[1]) {
                //   toggleEdit();
                $(this).prop("disabled", false);
                $("#form_id").val(parsedData[1]);
                $(".form-title").text(form_name);
            } else {
                serverResponse('resajmsg', parsedData[0], "danger");
                //alert(parsedData[0]);
            }
            $('html,body').animate({
                scrollTop: 0
            }, 300);
            setInterval(function() {
                window.location.href =  admin_url()+'form/';
            }, 2000);
        });
    } else {
        $(".loading-overlay").hide();
      //  serverResponse('resajmsg', "Please fill form Name", "danger");
        $('html,body').animate({
            scrollTop: 0
        }, 300);
        //  alert("Please fill form Name");
    }
    //////////////
}

function publish_form(formBuilder) {
    // abhilash save data from database  
    $(".loading-overlay").show();
    var form_data_db = formBuilder.actions.getData('json');
    //  alert(form_data_db);
    console.log(form_data_db);
    ////////
    var form_name = $("#form_name").val();
    var form_descr = $("#form_descr").val();
    var a = $("#form_id").val();
    console.log(form_name);
    console.log(a);
    var limitstatus = 0,
        editstatus = 0;
    if ($("#limitstatus").prop('checked') == true) {
        limitstatus = 1;
    }
    if ($("#editstatus").prop('checked') == true) {
        editstatus = 1;
    }
   if ($('#formbuliler_form').valid()); 
    if (form_name) {
        $(this).prop("disabled", true);
        // alert(form_name);
        //  alert(a);
        //	alert(1);
        $.post(admin_url()+'/form/formBuilder_Add_update/', {
            editstatus: editstatus,
            limitstatus: limitstatus,
            a: a,
            form_descr: form_descr,
            status: 1,
            form_name: form_name,
            form_data: form_data_db
        }, function(data) {
            $(".loading-overlay").hide();
            var parsedData = JSON.parse(data);
            console.log(parsedData);
            serverResponse('resajmsg', parsedData[0], "success");
            //   alert(parsedData[0]);
            if (parsedData[1]) {
                //   toggleEdit();
                $(this).prop("disabled", false);
                $("#form_id").val(parsedData[1]);
                $(".form-title").text(form_name);
            } else {
                serverResponse('resajmsg', parsedData[0], "danger");
                //alert(parsedData[0]);
            }
            $('html,body').animate({
                scrollTop: 0
            }, 300);
            setInterval(function() {
                window.location.href = admin_url()+'form/';
            }, 2000);
        });
    } else {
        $(".loading-overlay").hide();
     //   serverResponse('resajmsg', "Please enter form name.", "danger");
        $('html,body').animate({
            scrollTop: 0
        }, 300);
        //  alert("Please fill form Name");
    }
    //////////////
}

jQuery(function($) {

    $("#frmb_save").click(function() {
       // alert( "Handler for .click() called." );
        save_form(formBuilder);
    });
    $("#frmb_Publish").click(function() {
        //   alert( "Handler for .click() called." );
        publish_form(formBuilder);
    });
    var fields = [{
            label: 'Yes or No',
            attrs: {
                type: 'yes_no'
            },
            icon: '<i class="fa fa-retweet" aria-hidden="true"></i>'
        },
        {
            label: 'Website',
            attrs: {
                type: 'url'
            },
            icon: '<i class="fa fa-globe" aria-hidden="true"></i>'
        },
        {
            label: 'Phone',
            attrs: {
                type: 'number'
            },
            icon: '<i class="fa fa-mobile" aria-hidden="true"></i>'
        },
        {
            label: 'Last Name',
            attrs: {
                type: 'text'
            },
            icon: '<i class="fa fa-pencil" aria-hidden="true"></i>'
        },
        {
            label: 'First Name',
            attrs: {
                type: 'text'
            },
            icon: '<i class="fa fa-pencil" aria-hidden="true"></i>'
        },
        {
            label: 'Payment',
            attrs: {
                type: 'select'
            },
            icon: '<i class="fa fa-credit-card-alt" aria-hidden="true"></i>'
        },
        {
            label: 'Signature',
            attrs: {
                type: 'signature'
            },
            icon: '<i class="fa fa-pencil-square-o" aria-hidden="true"></i>'
        },
        {
            label: 'Date of Birth',
            attrs: {
                type: 'date'
            },
            icon: '<i class="fa fa-calendar" aria-hidden="true"></i>'
        },
        {
            label: 'Star Rating',
            attrs: {
                type: 'starRating'
            },
            icon: '<i class="fa fa-star" aria-hidden="true"></i>'
        }
    ];

    var actionButtons = [{
            id: 'smile',
            className: 'btnn btn-white waves-effect waves-light fbSave',
            label: 'Save',
            type: 'button',
            events: {
                click: function(e, formData) {
                    save_form(formBuilder);
                }
            }
        },
        {
            id: 'smile',
            className: 'btnn btn-default waves-effect waves-light fbSave',
            label: 'Publish',
            type: 'button',
            events: {
                click: function(e, formData) {
                    publish_form(formBuilder);
                }
            }
        }
    ];

    var templates = {
        starRating: function(fieldData) {
            return {
                field: '<span id="' + fieldData.name + '">',
                onRender: function() {
                    $(document.getElementById(fieldData.name)).rateYo({
                        rating: 3.6
                    });
                }
            };
        },
        url: function(fieldData) {
            return {
                field: '<input type="url" class="form-control">'
            };
        },
        yes_no: function(fieldData) {
            return {
                field: '<input type="text" class="form-control">'
            };
        },
        signature: function(fieldData) {
            return {
                field: '<input type="file" class="form-control">'
            };
        },
        //  yes_no
    };

    var fbOptions = {
        subtypes: {
            text: ['datetime-local']
        },
        onSave: function(e, formData) {
            toggleEdit();
            $('.render-wrap').formRender({
                formData: formData,
                templates: templates
            });
            //   window.sessionStorage.setItem('formData', JSON.stringify(formData));
        },
        stickyControls: {
            enable: true
        },
        sortableControls: true,
        fields: fields,
        templates: templates,
        //  inputSets: inputSets,
        //  typeUserDisabledAttrs: typeUserDisabledAttrs,
        //  typeUserAttrs: typeUserAttrs,
        disableInjectedStyle: false,
        actionButtons: actionButtons,
        //  disableFields: ['autocomplete'],
        disableFields: ['autocomplete', 'button', 'paragraph', 'hidden', 'number'],
        // replaceFields: replaceFields,
        disabledFieldButtons: {
            text: ['copy']
        }
        // controlPosition: 'left'
        // disabledAttrs
    };
    //// edit section on abhialsh 
    var $formId = $("#form_id").val();
    var $form_data = $("#form_data").val();
    // console.log($formId);
    if ($formId) {
        var formData = JSON.parse($form_data);
        //  console.log(formData);  
    } else {
        var formData = '';

    }
    var editing = true;
    if (formData) {
        if ($formId) {
            fbOptions.formData = formData;
        } else {
            fbOptions.formData = JSON.parse(formData);
        }
    }
    console.log(formData);
    /**
     * Toggles the edit mode for the demo
     * @return {Boolean} editMode
     */
    function toggleEdit() {
        document.body.classList.toggle('form-rendered', editing);
        return editing = !editing;
    }
    var setFormData = '[{"type":"text","label":"Full Name","subtype":"text","className":"form-control","name":"text-1476748004559"},{"type":"select","label":"Occupation","className":"form-control","name":"select-1476748006618","values":[{"label":"Street Sweeper","value":"option-1","selected":true},{"label":"Moth Man","value":"option-2"},{"label":"Chemist","value":"option-3"}]},{"type":"textarea","label":"Short Bio","rows":"5","className":"form-control","name":"textarea-1476748007461"}]';
    var formBuilder = $('.build-wrap').formBuilder(fbOptions);
    var fbPromise = formBuilder.promise;
    fbPromise.then(function(fb) {
        var apiBtns = {
            showData: fb.actions.showData,
            clearFields: fb.actions.clearFields,
            getData: function() {
                console.log(fb.actions.getData());
            },
            setData: function() {
                fb.actions.setData(setFormData);
            },
            addField: function() {
                var field = {
                    type: 'text',
                    class: 'form-control',
                    label: 'Text Field added at: ' + new Date().getTime()
                };
                fb.actions.addField(field);
            },
            removeField: function() {
                fb.actions.removeField();
            },
            resetDemo: function() {
                //  window.sessionStorage.removeItem('formData');
                location.reload();
            }
        };

    });
    document.getElementById('edit-form').onclick = function() {
        toggleEdit();
    };
    $('.render-wrap2').formRender({
        formData: formData,
        templates: templates,
    });
});

function serverResponse(id, res, alertClass, tm = "2500") {
  
    var resmsg1 = '<div class="alert alert-dismissable alert alert-' + alertClass + '"><a href="#" class="close" data-dismiss="alert" aria-label="close"> x </a><span>' + res + '</span> </div>';

    //response  msg aj st
    $('#' + id).show();
    $('#' + id).html(resmsg1);
    window.setTimeout(function() {
        //   $('#'+id).fadeTo(500, 0).slideUp(500, function () {
        $('#' + id).html("");
        //   });
    }, tm);
}