
$('.page-restaurant').on('click','.panel-heading i',function(){
	
 $(this).closest('.menu-span').find('.custom-child-accordion').toggle(500);
	
});

$(document).on('mouseover','.menu-span .card-box',function(){
	
 
$(this).find('.edit-delete').removeClass('invisible'); 
	
});

$(document).on('mouseout','.menu-span .card-box',function(){
 
$(this).find('.edit-delete').addClass('invisible'); 
	
})

 $(document).on('click','.child-form-edit',function(){  
  
$(this).closest('.custom-child-accordion').find('.list-item').addClass('hide');
$(this).closest('.custom-child-accordion').find('.child-form').removeClass('hide');
  
 });

 $(document).on('click','.cancel-child-form',function(){  
  
$(this).closest('.custom-child-accordion').find('.list-item').removeClass('hide');
$(this).closest('.custom-child-accordion').find('.child-form').addClass('hide');
  
 }); 
 
 
 $(document).on('click','.size-feild .fa-close',function(){  
  
$(this).closest('.size-feild').remove();
 
  
 }); 
  
 
 $(document).on('click','.add-mutipal-size',function(){  
 
var data='';
data +='<div class="row mb-2 size-feild">';
data +='<div class="col-md-4">';
data +='<div class="form-group">';
data +='<input  type="text" class="form-control" placeholder="size">';
data +='</div>';
data +='</div>';
data +='<div class="col-md-4">';
data +='<div class="form-group">';
data +='<input  type="text" class="form-control" placeholder="size">';
data +='</div>';
data +='</div>';
data +='<div class="col-md-4 h4 mt-1">';
data +='<div class="form-group">';
data +='<i class="fa fa-close mr-3 pointer"></i>   <input  type="radio" name="radio">';
data +='</div>';
data +='</div>';
data +='</div>';  
$(this).closest('.size-area').before(data);
  
 });


 $(document).on('click','.time-hour-set .fa-plus',function(){  

var data=''; 
data+='<div class="form-row">';
data+='<div class="form-group col-md-2">'; 
data+='</div>';
data+='<div class="form-group col-md-2">';
data+='</div>';
data+='<div class="form-group col-md-3">';
data+='<input type="text" class="form-control timepicker">';
data+='</div>';
data+='<div class="form-group col-md-3">';
data+='<input type="text" class="form-control timepicker">';
data+='</div>';
data+='<div class="form-group col-md-2 mt-1">';
data+='<i class="fa fa-trash loggedin-color pointer"></i>';
data+='</div>';
data+='</div>';

$(this).closest('.form-row').after(data);
timepicker();
 }); 
 
$(document).on('click','.time-hour-set .fa-trash',function(){  
$(this).closest('.form-row').remove();
})

//shipping local delivery popup code
 