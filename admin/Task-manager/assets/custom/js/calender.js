$('.add-class').on('click','.location-radio',function(){

$('.add-class').find('.other-address').addClass('hide');
$('.add-class').find('.other-address').prop('required',false);
if($(this).val()==3)
{
$('.add-class').find('.other-address').removeClass('hide');
$('.add-class').find('.other-address').prop('required',true);
 
}	
	
});