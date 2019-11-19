/*---------> Order Section Code Start <---------*/


function ajax_pagination(current_page=1,search_term='',entry='')
{
  total_page = $("#total_page").val();
  if(Number(current_page) >= Number(total_page))
  {
    setTimeout(function(){ $("#next").hide(); }, 100);
  }

   $("#current_page").val(current_page);

   url   = $("#URL").val();
   entry = $("#entry").val();
   entry = Number(entry);
   page  = Number(current_page*entry-entry);
   
  $.post(url,{'search':search_term,'limit':page,'perpage':entry},function(res){
    
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
   final = parseInt(page + 1);
    page = Number(page)+1;
    ajax_pagination(page);    
   
}

function previous()
{
    page = $("#current_page").val();
    page = Number(page)-1;
    ajax_pagination(page);
}

