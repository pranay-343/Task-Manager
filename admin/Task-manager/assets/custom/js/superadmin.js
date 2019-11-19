  $(document).ready(function(){

  
  /*select all module permissions code start*/
     $('.client_add').on('click', '#checkAll', function() {
		$('.select_modules').not(this).prop('checked', this.checked);
	 });	 
   /*select all module permissions code end*/ 

   /*add client form code start*/
   
     $('#client_add').on('click', '#btnSubmit', function() {
           	
		 $("#client_add").validate();
	 });	 
   /*add client form code end*/

   /*--------> Payment histroy pagination section code start <--------*/
      $("#entry").change(function(){
         var entry  = $(this).val();
            url = $("#BaseURL").val();
            $.post(url+'/superadmin/Stripe/test',{'ent':entry},function(res){
              $("#pymnt_hist").html(res);
            })  


      })
   /*--------> Payment histroy pagination section code end <--------*/ 
   

 
});	
function client_type(id,value,action='')
  {

     url = $("#BaseURL").val();
     if(action=='')
     {
       url = url+'/superadmin/client/updateClientType';
       mod= 'update_status';
     }

     if(action=='module_status')
     {
      url = url+'/superadmin/Permission/update_module_Status';
      mod= 'UpdateModuleStatus';
     }
     if(action == 'update_payment_status')
     {
      url = url+'/superadmin/Permission/update_module_Status';
      mod= 'UpdatePaymentStatus';
     } 
      //alert(url);
      $.post(url,{'mode':mod,'where':id,'set':value}, function(res){
         /*alert(res);*/
        if(res == 4)
        {
          $(".dct"+id).css("display","block");
          $(".act"+id).css("display","none");       
        }
       else if(res ==2)
        {
         $(".act"+id).css("display","block");
         $(".dct"+id).css("display","none"); 
        }
       else if(res ==5)
        { 
         $('.'+id+'act').css("display","block");
         $('.'+id+'dct').css("display","none"); 
        }
        else if(res ==6)
        {
         $("."+id+'dct').css("display","block");
         $("."+id+'act').css("display","none"); 
        }

      })
   
  }

/*  Order Section Js Start------->*/
function getDetail(orderNo, req)
{
  url   = $("#URL").val();
  
  $.post(url+'/single',{'order_no':orderNo,'request_for':req},function(res){
    $("#order_detail").html(res);
    $("#myModal").modal('show');
  });
  
}

/*  Order Section Js End------->*/

 