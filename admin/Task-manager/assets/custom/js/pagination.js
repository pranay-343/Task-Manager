$(document).ready(function(){
  var timeout = null;
 $('#searching').keyup(function() {
  search = $(this).val();
 clearTimeout(timeout);
timeout = setTimeout(function () {
        ajax_pagination(1,search);
    }, 500);
});
}) 
function ajax_pagination(current_page=1,search_term='',datefilter='')
{
 
  if(datefilter =='')
  {
    datefilter = $("#datefilter").val()
  }  
  total_page = $("#total_page").val();
  if(total_page<=1)
  {
     $("#next").hide();
  }

  if(Number(current_page) >= Number(total_page))
  {
    setTimeout(function(){ $("#next").hide(); }, 100);
  }

   $("#current_page").val(current_page);

   url   = $("#URL").val();
   entry = $("#entry").val();
   entry = Number(entry);
   page  = Number(current_page*entry-entry);
   
  $.post(url,{'search':search_term,'limit':page,'perpage':entry,'date_filter':datefilter,'current_page':current_page},function(res){
  
    
    $(".datalist").html(res);

    if(current_page<=1)
    {
      $("#prev").hide();
    }
    if(current_page>=total_page)
    {
      $("#next").hide();
    }
    
  });
}

function next()
{
   page = parseInt($("#current_page").val());
   total_page = parseInt($("#total_page").val());
   search = $('#searching').val()
   final = parseInt(page + 1);
    page = Number(page)+1;
    ajax_pagination(page,search);    
   
}

function previous()
{
    page = $("#current_page").val();
    page = Number(page)-1;
    search = $('#searching').val()
    ajax_pagination(page,search);
}

function date_filter()
{
  date = $("#datefilter").val();
  search = $('#searching').val();
ajax_pagination(1,search,date);
}
