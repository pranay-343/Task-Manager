$('.extention_form').on('click', '.add_another_person', function(){ 
	
var data='';	
data +='<span class="dynamic-feilds"><div class="form-group redstar col-md-5 pull-left" >';
data +='<label for="inputEmail4" class="col-form-label">Person Name</label>';
data +='<input type="text" class="form-control" vlaue="" name="form_name" placeholder="Person Name">'; 
data +='</div>';
data +='<div class="form-group  col-md-5 redstar pull-left" >';
data +='<label for="inputEmail4" class="col-form-label">Phone Number</label>';
data +='<input type="text" class="form-control" vlaue="" name="form_name" placeholder="Phone Number">'; 
data +='</div>';
data +='<div class="form-group  col-md-2 pull-left" >';
data +='<label for="inputEmail4" class="col-form-label "><span class="delete-lable-box delete-person pointer label label-primary pull-right">X</span></label>';                        
data +='</div></span>';

$(this).closest(".extntion-form-box").find('.add-person-btn').before(data);
	
});

$('.extention_form').on('click', '.delete-person', function(){ 

var count_feild=$(this).closest('.department-box').find('.dynamic-feilds').length;

  if(count_feild>1)
  {
       $(this).closest(".dynamic-feilds").remove();
   }
   
});


$('.extention_form').on('click', '.add_new_department', function(){ 

var data='';
data +='<span class="department-box">';
data +='<div class="form-row  p-2 delete-box">';
data +='<div  class="col-md-10 extntion-form-box p-3">';
data +='<div class="form-group  redstar col-md-7" >';
data +='<label for="inputEmail4" class="col-form-label">Department </label>';
data +='<input type="text" class="form-control" vlaue="" id="form_name" name="form_name" placeholder="Department Name">'; 
data +='</div>';
data +='<span class="dynamic-feilds"><div class="row">';
data +='<div class="form-group  col-md-5 pull-left redstar" >';
data +='<label for="inputEmail4" class="col-form-label"> Person Name</label>';
data +='<input type="text" class="form-control" vlaue=""  name="form_name" placeholder="Person Name">';
data +='</div>';
data +='<div class="form-group  col-md-5 pull-left redstar">';
data +='<label for="inputEmail4" class="col-form-label">Phone Number</label>';
data +='<input type="text" class="form-control" vlaue=""  name="form_name" placeholder="Phone Number">'; 
data +='</div>';
data +='<div class="form-group  col-md-2 pull-left" >';
data +='<label for="inputEmail4" class="col-form-label "><span class="delete-person delete-lable-box pointer label label-primary pull-right">X</span>	</label>';                       
data +='</div></div>';
data +='</span>';
data +='<p class="add-person-btn p-2" >';
data +='<label for="inputEmail4" class="col-form-label"><a  href="javascript: void(0)" class="pointer add_another_person"><i class="ion-plus-circled"></i> Add Another Person</a></label>';
data +='</p>';
data +='</div>';
data +='<div  class="col-md-2">';   
data +='<label for="inputEmail4" class="col-form-label pt-0"><span class="delete-lable-box delete-another-department pointer label label-primary pull-right">X</span>';	
data +='</label>';
data +='</div>';
data +='</div>';
               
data +='</span>';

$(this).closest(".department-box").find('.add-another-department').before(data);

});
 
$('.extention_form').on('click', '.delete-another-department', function(){ 

var count_box=$('.extention_form').find(".delete-box").length;
 
 if(count_box > 1){
   $(this).closest(".delete-box").remove();
 }
}); 
