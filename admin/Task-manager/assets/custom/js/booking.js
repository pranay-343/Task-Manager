//staff add page code for staff time shedule

$('.new_staff_add').on('click', '.set_staff_time', function() {

    var get_value = $(this).val();

    if (get_value == 1) {
        $('.business_hours').removeClass('hide');

    } else {

        $('.business_hours').addClass('hide');
    }


})
//staff add page code for staff time shedule code end
 
 //confirm mail reminder booking option set page code
 
 $('.confirm-mail-reminder').on('click', '.setfooter_booking', function() {

    var get_value = $(this).attr('data-id');

    switch (get_value) {
		
        case 'apt':
            $('.footer-message-div').addClass('hide');
            $('.apt-footer').removeClass('hide');
            break;
        case 'cls':
            $('.footer-message-div').addClass('hide');
            $('.cls-footer').removeClass('hide');
            break;
        default:
            $('.footer-message-div').addClass('hide');
            $('.bus-footer').removeClass('hide');
            break;
			
    }

}); 
 //confirm mail reminder booking option set page code end

 //reminder mail reminder booking option set page code
$('.reminder_mail').on('click', '.set-reminder', function() {

    var get_value = $(this).attr('data-id');

    switch (get_value) {
		
        case 'apt':
            $('.set-reminder-form').addClass('hide');
            $('.apt-form').removeClass('hide');
            break;
        case 'cls':
            $('.set-reminder-form').addClass('hide');
            $('.cls-form').removeClass('hide');
            break;
        default:
            $('.set-reminder-form').addClass('hide');
            $('.bus-form').removeClass('hide');
            break;
			
    }

});
 //reminder mail reminder booking option set page code

//code for drag and drop class and servie bus for listing
 
 
    $(".booking-accordian").sortable({
        items: ".booking-panel",
        stop: function() {
            reorder_category($(this).attr('id'));
        }
    });
    $(".booking-accordian .booking-panel").disableSelection();
 

function reorder_category(getid) {
    //alert();
}
 
 $(".category-portlet").sortable({
        items: ".category-panel-collapse",
        stop: function() {
            set_reorder_category($(this).attr('id'));
        }
    });
    $(".booking-accordian .booking-panel").disableSelection();
 

function set_reorder_category(getid) {
   // alert();
}  
 //code for drag and drop class and servie bus for listing


 //code for drag and drop class and servie bus for listing
$('#class-list-page').on('click', '.moredetail', function() {
	
    var thislink = $(this);	
    var table = $(this).closest('.category-panel-collapse').find('.day-table');
    var dataid = $(this).attr('data-id');
	
    switch (dataid) {
        case '0':
            $(thislink).text('Less Detail');
            $(thislink).attr('data-id', '1');
            table.removeClass('hide');
            break;
        default:
            $(thislink).text('More Detail');
            $(thislink).attr('data-id', '0');
            table.addClass('hide');
             }

})
//code for drag and drop class and servie bus for listing


//add staff on apartment page
$('.staff-add-link a').click(function(){
	
	$(this).addClass('hide');
	$('.staff_list-apt').removeClass('hide');
	
});

$('.cancel-staff-list').click(function(){
	
	$('.staff_list-apt').addClass('hide');
	$('.staff-add-link a').removeClass('hide');
	
});
//add staff on apartment page end code
 
$('.new_appoinment_add').on('click','.service_palace',function(){
	
var getvalue=$(this).val(); 

switch (getvalue) {
        case '3':   
            $(".other-service-address").prop('required',true);		
            $('.other-service-address').removeClass('hide');
            break;
        default:
            $('.other-service-address').addClass('hide'); 
			$(".other-service-address").prop('required',false);	
             } 	
}); 

$('.new_appoinment_add').on('click','.add-form',function(){
	
$(this).addClass('hide'); 
$('.close-form').removeClass('hide');
$('.form-div').removeClass('form-build-hide');

 
}); 

$('.new_appoinment_add').on('click','.close-form',function(){
	
$(this).addClass('hide'); 
$('.add-form').removeClass('hide');
$('.form-div').addClass('form-build-hide');
 
}); 
 
 
$('.new_appoinment_add').on('change','.allow_enable',function(){

if($(this).prop('checked') == true)
{
 $('.allow-input-feild input').prop('disabled', true);
}else{
 $('.allow-input-feild input').prop('disabled', false);	
	
}

}); 

$('.new_appoinment_add').on('change','.service-type-select',function(){

var getvalue=$(this).val();

switch (getvalue) {
        case '1':                		
            $('.accept-pay-div').removeClass('hide');
			$('.price-div').removeClass('hide');
			$('.price-input').prop('required', true);	
            break;
        default:
            $('.accept-pay-div').addClass('hide');
			$('.price-div').addClass('hide');	
			$('.price-input').prop('required', false);	
             }  

});  
 
$(window).resize(function(){
 
var width_window=$(this).width(); 
var a=1;
if(width_window<769){
a=0;
}
switch(a)
{
	case 0:	
	$('.dropdon-for-category').removeClass('w-50');
	$('.dropdon-for-category').addClass('w-100');
	$('.dropdon-for-staff').css('width','100%');	
	break;
	default:	 
	$('.dropdon-for-category').removeClass('w-100'); 
	$('.dropdon-for-category').addClass('w-50'); 
	$('.dropdon-for-staff').css('width','340px'); 
	
}
  
})	


$(document).on('click','.open-drop-down',function(){

$('.drop-down-popup').removeClass('show');
	
$(this).closest('.drop-down-pop-div').find('.drop-down-popup').removeClass('show');

$(this).closest('.drop-down-pop-div').find('.drop-down-popup').addClass('show');	

});

$(document).on('click','.dropdown-get-item',function(){	
$(this).closest('.drop-down-popup').removeClass('show'); 

});

$(document).on('click','.add-dropdown-item',function(){
	
$(this).addClass('hide');	
$(this).closest('.drop-down-popup').find('.dropdown-add-area').removeClass('hide');

});

$(document).on('click','.cancel-pop-items',function(){
	
$(this).closest('.drop-down-popup').find('.add-dropdown-item').removeClass('hide');	
$(this).closest('.drop-down-popup').find('.dropdown-add-area').addClass('hide');

});


$(document).on('click','.add-more-timeshedule',function(){
	 
	
var data='';

data +='<div class="form-row day-shedule-area">';
data +='<div class="form-group col-md-2">';
 
data +='</div>';
data +='<div class="form-group col-md-1">';
 
data +='</div>';
data +='<div class="form-group col-md-2">';
data +='<input type="text" class="form-control timepicker" placeholder="">';
data +='</div>';
data +='<div class="form-group col-md-2 text-center">';
data +='- No Duration';
data +='</div>';
data +='<div class="form-group col-md-2 drop-down-pop-div">';
data +='<input type="text" class="form-control open-drop-down" placeholder="Select staff" readonly>';
data +='<div class="drop-down-popup dropdown-menu dropdown-menu-left   dropdown-arrow dropdown-lg dropdon-for-staff" aria-labelledby="Preview">';
data +='<div class="drop-down-list">';
data +='<a href="javascript:void(0);" class="dropdown-get-item dropdown-item notify-item">';
data +='Robert S. Taylor commented on Admin';  
data +='</a>';
data +='</div>';
data +='<div class="footer pl-0 w-100">';
data +='<a href="javascript:void(0);" class="ml-4 add-dropdown-item">';
data +='+ Add New';
data +='</a>';
data +='<div class="row pl-2 pl-2 dropdown-add-area hide">';
data +='<div class="col-md-6">';
data +='<input type="text" class="form-control" >'; 							 
data +='</div>';
data +='<div class="col-md-6 mt-3 mt-lg-0">';								 
data +='<button class="btn btn-primary publish-btn">Save</button>	<button class="cancel-pop-items btn save-cancel-btn data'; data +='cancel-with-border">Cancel</button>';
data +='</div>';
data +='</div>';
data +='</div>';
data +='</div>';
data +='</div>';
data +='<div class="form-group col-md-2">';
data +='<i class="fa fa-plus mt-2  ml-lg-3 pointer add-more-timeshedule loggedin-color"></i> <i class="loggedin-color fa fa-trash mt-0  ml-lg-3 pointer delete-more-timeshedule"></i>';
data +='</div>';
data +='</div>';
 
if($(this).closest('.class-shedule-area-span').find('.checkbox').prop('checked') == true){
$(this).closest('.class-shedule-area-span').append(data);
}

timepicker();
	
})


$(document).on('click','.add-more-timeshedule',function(){
	 
	
var data='';

data +='<div class="form-row day-shedule-area">';
data +='<div class="form-group col-md-2">';
 
data +='</div>';
data +='<div class="form-group col-md-1">';
 
data +='</div>';
data +='<div class="form-group col-md-2">';
data +='<input type="text" class="form-control timepicker" placeholder="">';
data +='</div>';
 
 
data +='<div class="form-group col-md-2">';
data +='<i class="fa fa-plus mt-2  ml-lg-3 pointer add-more-timeshedule loggedin-color"></i> <i class="loggedin-color fa fa-trash mt-0  ml-lg-3 pointer delete-more-timeshedule"></i>';
data +='</div>';
data +='</div>';
 
 if($(this).closest('.bus-shedule-area-span').find('.checkbox').prop('checked') == true)
 {
$(this).closest('.bus-shedule-area-span').append(data);
 }

timepicker();
	
})



$(document).on('click','.delete-more-timeshedule',function(){

$(this).closest('.day-shedule-area').remove();	 

});	 


$('.booking-accordian').on('click','.cancel-link',function(){	
$(this).closest('.booking-panel').find('.portlet-title').removeClass('hide');	
$(this).closest('.booking-panel').find('.update-category').addClass('hide');	
$(this).closest('.booking-panel').find('.update-category-blank').removeClass('hide');	
});


$('.booking-accordian').on('click','.fa-edit',function(){	
$(this).closest('.booking-panel').find('.portlet-title').addClass('hide');	
$(this).closest('.booking-panel').find('.update-category').removeClass('hide');	
$(this).closest('.booking-panel').find('.update-category-blank').addClass('hide');
});

$(document).on('change','.checkbox',function(){
	
if($(this).prop('checked') == true){	
 $(this).closest('.bus-shedule-area-span,.class-shedule-area-span').find('input').prop('disabled',false); 
}else{
$(this).closest('.bus-shedule-area-span,.class-shedule-area-span').find('input').prop('disabled',true);	
}
 
 });
 
 
 //addtional stop area
 
 $(document).on('click','.add_aditional_stop a',function(){
 
var data=''; 
data +='<div class="row mt-4 stop-feild">';
data +='<div class="col-3">';
data +='<input type="text" class="form-control">';
data +='</div>';
data +='<div class="col-3">';
data +='<select type="text" class="form-control">';
data +='<option value="">Select</option>';

for(i=5; i<=180; i=i+5)
{
data +='<option value="'+ i +'">'+ i +' Min</option>';	
}

data +='</select>';
data +='</div>';
data +='<div class="col-1">';
data +='<i class="fa fa-trash mt-2 loggedin-color pointer"></i>';
data +='</div>';
data +='</div>';
 
$('.add_aditional_stop').append(data);	 
	 
	 
 });
 
 
  
 $(document).on('click','.add_aditional_stop .fa-trash',function(){

 $(this).closest('.stop-feild').remove();
 
 })
 
 $(document).on('click','.add_custom_date a',function(){ 
 
var data=''; 

data+='<div class="row customdatfeild">';
data+='<div class="col-md-7">';
data+='<div class="aditional_datearea mt-3">';
data+='<div class="row ">';
data+='<div class="col-md-5">'; 
data+='<label></label>';
data+='<input type="text" class="form-control datepicker">';
data+='</div>';
data+='<div class="col-md-1   mt-4 mt-lg-2">';
data+='<label class=""></label>';
data+='<input type="checkbox"   data-plugin="switchery" data-color="#5fbeaa" data-switchery="true" data-size="small"';
data+='class="hide checkbox">';
data+='</div>';
data+='<div class="col-md-5">';
data+='<label></label>';
data+='<input type="text" class="form-control timepicker">';
data+='</div>';
data+='<div class="col-md-1 mt-4">';
data+='<label></label>';
data+='<i class="fa fa-plus loggedin-color mt-2 pointer"></i>';
data+='</div>';

data+='</div>'; 
data+='<div class="row additional_stop_add"><div class="col-md-12 mt-3"><a href="javascript:void(0)">+ Add Addtional Stops</a></div></div>';
data+='</div>';

data+='</div>';
data+='<div class="col-md-4 mt-2">';
data+='<i class="fa fa-trash loggedin-color pointer delete-custon"></i>';
data+='</div>'; 

data+='</div>';
           

 $('.more_custom_date').append(data);
 
 pickdate();
 timepicker();
 
 });
 

  $(document).on('click','.more_custom_date .delete-custon',function(){
     $(this).closest('.customdatfeild').remove();
  });
  
  
 
  $(document).on('click','.more_custom_date .additional_stop_add a',function(){
 
 var data=''; 
data +='<div class="row mt-4 stop-feild">';
data +='<div class="col-3">';
data +='<input type="text" class="form-control">';
data +='</div>';
data +='<div class="col-3">';
data +='<select type="text" class="form-control">';
data +='<option value="">Select</option>';

for(i=5; i<=180; i=i+5)
{
data +='<option value="'+ i +'">'+ i +' Min</option>';	
}

data +='</select>';
data +='</div>';
data +='<div class="col-1">';
data +='<i class="fa fa-trash mt-2 loggedin-color pointer"></i>';
data +='</div>';
data +='</div>';

$(this).closest('.additional_stop_add').after(data);
 
 
  });  
  
  $(document).on('click','.more_custom_date .stop-feild .fa-trash',function(){
	  
	  $(this).closest('.stop-feild').remove();  
	  
  })
  
  $(document).on('click','.more_custom_date .customdatfeild .fa-plus',function(){ 
  var data='';
data +='<div class="row ">';
data +='<div class="col-md-5"><label></label><input type="text" class="form-control datepicker"></div>';
data +='<div class="col-md-1   mt-4 mt-lg-2"><label class=""></label><input type="checkbox" data-plugin="switchery"'; 
data +='data-color="#5fbeaa" data-switchery="true" data-size="small" class="hide checkbox"></div>';
data +='<div class="col-md-5"><label></label><input type="text" class="form-control timepicker"></div>';
data +='<div class="col-md-1 mt-4"><label></label><i class="fa fa-plus loggedin-color mt-2 pointer"></i></div>';
data +='</div>';
 $(this).closest('.row').after(data);
  pickdate();
 timepicker();
  });
 

  