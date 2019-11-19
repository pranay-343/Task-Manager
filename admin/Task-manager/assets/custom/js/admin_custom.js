$(document).ready(function () {
	
	//code for numric value in input feild
    $('body').on('keypress', '#quantity,#mobile,#contact_no,.contact_no,.numerical,.numerical_value', function (e) {

        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
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


	//code for more detail when click on table row
    $('body').on('click', 'table tr td.page_link ', function () {
        window.location = $(this).parents().attr('href');
        return false;
    });
	
	
   
    $('body').on('keypress', 'input', function (e) {
        if (this.value.length == 0 && e.which == 48) {
            return false;
        }
    });

	//press enter button auto submit form
    $('body').on('keypress', 'input', function (e) {
        if (event.which == 13) {
            $(this).closest("form").find('.save-btn').click();
            event.preventDefault();
        }
    });	

	
	//code for time picker
   
	//slide code for first login screen
   $('.slider-right').removeClass('hide');    
   $(".slider-right").animate({left: '0px'});
   
   
   //code for form builder
   //$('.build-wrap').formBuilder();
   
//code for logo (start)
   $('.button-menu-mobile').click(function(){	 
	  var smalllogo=$('.small_logo').attr('class');	 
	  var checkhide=smalllogo.indexOf('hide');
	  var window_width=$(window).width();
	  if(window_width > 768){
	   if(checkhide=='-1')
	   {
		  $('.small_logo').addClass('hide');  
		  $('.big_logo').removeClass('hide');  
	   }else{
		    $('.small_logo').removeClass('hide'); 
		    $('.big_logo').addClass('hide');  
	   }
	  }
	   
   });
//code for logo (end)
  
//set logo screen according start 
function set_logo() {
	 
    var window_width = $(window).width();
    if (window_width < 768) {
        $('.small_logo').removeClass('hide');
        $('.big_logo').addClass('hide');
        $('#wrapper').addClass('enlarged');
    } else {
        $('#wrapper').removeClass('enlarged');
        $('.small_logo').addClass('hide');
        $('.big_logo').removeClass('hide');
    }
}
set_logo();
timepicker();
pickdate();
//$(window).resize(set_logo); 
//set logo screen according end 
});


function timepicker()
{
	$('.timepicker').timepicker({
        defaultTIme: false,
        icons: {
            up: 'md md-expand-less',
            down: 'md md-expand-more'
        }
    });
}

function pickdate()
{
 $('.datepicker').datepicker({}); 
}
 
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
	
 