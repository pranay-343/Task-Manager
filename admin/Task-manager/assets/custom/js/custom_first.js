$(document).ready(function(){	
//code for profile page 
//add faq queston
$('.add_new_faq').click(function(){
data='';
data +='<div class="form-row faqbackground">';
data +='<div class="form-group col-md-12">';
data +='<input type="text" class="form-control"  placeholder="Question">';
data +='</div>'; 
data +='<div class="form-group col-md-12">';
data +='<input type="text" class="form-control"  placeholder="Answer">';
data +='</div>'; 
data +='<div class="form-group col-md-12">';
data +='<button type="button" class="removefaq btn btn-white waves-effect">Remove</button>';
data +='</div>';                              
data +='</div>'; 
$('.faqcode').after(data);
})

$('body').on('click', '.removefaq', function() {   
   $(this).parent().parent().remove();   
});
//profile page code end	
	
});