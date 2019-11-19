function hasDecimalPlace(value, x) {
    var pointIndex = value.indexOf('.');
    return  pointIndex >= 0 && pointIndex < value.length - x;
}
// image prev
function image_prev(input,img_id) {
        $('#'+img_id).show();
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#'+img_id).attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}
function randomPassword(filed_id,length) {
    var chars = "abcdefghijklmnopqrstuvwxyz!@#$%^&*()-+<>ABCDEFGHIJKLMNOP1234567890";
    var pass = "";
    for (var x = 0; x < length; x++) {
        var i = Math.floor(Math.random() * chars.length);
        pass += chars.charAt(i);
    }
//    return pass;
       $("#"+filed_id).val(pass);
}

 var tablehref = function(tableid) {

 $(tableid+' tbody').on('click', 'tr td', function () {
 
     //   ev.preventDefault();
   if ($(this).is(':last-child')) {   
     //  return true ;
     }else {  
      var href = $(this).parent().find("a").attr("href");        
            if(href) {
                window.location = href;
            }
     }

});

}

$(document).ready(function () 
{
 // alpha only
    $('.alphaonly').bind('keyup blur',function(){ 
        var node = $(this);
        node.val(node.val().replace(/[^a-zA-Z ]/g,'') ); }
        );

    $('.nosonly').bind('keyup blur',function(){ 
        var node = $(this);
     //   node.val(node.val().replace(/[^0-9.-+]/g,'') );
    });

    //code for numric value in input feild
    $('body').on('keypress', '.numerical,.numerical_value', function (e) 
    {

        if (e.which != 8  && e.which != 0 && (e.which < 48 || e.which > 57 || e.which != 187)) {
            $("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
 $('body').on('keypress', '.contact_no', function (e) 
    { 
        if ( e.which != 8 && e.which != 0 && e.which != 187 &&  e.which != 48 &&  e.which != 96 && (e.which <= 48 || e.which > 57 )) {
            $("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });
    //code for float value value in input feild
    $('body').on('keypress', '.qty,.float', function () {
        if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57 || hasDecimalPlace($(this).val(), 2))) {
            event.preventDefault();
        }
    });

    // code for input keypress 
// $('body').on('keypress', 'input', function (e) {
//        if (this.value.length == 0 && e.which == 48) {
//            return false;
//        }
//    });
 

 // form save -> check  client validation js by  abhilash johri

$('body').on('click', '.submitform', function (e) 
{
        //  getting form  id 
        var formid = $(this).closest("form").attr('id');
        $("#" + formid).validate({
           
        });

             // form validation 
             if(!formid){
                alert('form id is requried');
            }
            if ($("#" + formid).valid()) { 
              return true;
          }else {
           return false;

       }
     $("body,.modal-body").animate({ scrollTop: 0 }, "slow");
   });  
//addTocart
 
$(".addTocart").click(function(event){
 // alert();      
  event.preventDefault();
  var id = $(this).attr('id');   
  $(this).attr("disabled", "disabled");
    $(this).html('<i class="fa-li fa fa-spinner fa-spin"></i>Loading...');
 var href =   $(this).attr('data-href');
  $.get(href, function(data, status){
  //   alert("Data: " + data + "\nStatus: " + status);
   //  alert('Add to cart sucessfully'); 
      $('#'+id).html('');
      $('#'+id).html('Added To Cart');
      
      $('#'+id).attr("disabled", "disabled");
       $('#addtocart_popup').modal('show');
       
        var cartno =   parseInt($('.cart-value').text())+1;
         $('.cart-value').text(cartno);
    setTimeout(function(){  $('#addtocart_popup').modal('hide');}, 1200);
  });
});
  $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
  });
 