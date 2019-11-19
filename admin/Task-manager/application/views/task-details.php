   <div class="content">
    <div class="container-fluid">
        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <h4 class="page-title">Task Manager</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active">Task Detail</li>
                </ol>

            </div>
        </div>
<?php if($this->session->flashdata('success')){ ?>
  <div class="alert alert-success alert-dismissible fade show" role="alert">
  <strong>Success!</strong> <?php echo  $this->session->flashdata('success'); ?>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<?php }else if($this->session->flashdata('error')){  ?>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Error!</strong> <?php echo  $this->session->flashdata('error'); ?>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<?php } ?>
<style type="text/css">
  .card-box {min-height: 477px;}
  .gmaps, .gmaps-panaroma {height: 394px;}
</style>
 <?php 
                          switch ($task->status) {
                        case "1":
                          $status ='Assign';   
                            break;
                        case "2":
                             $status ='Ongoing';
                            break;
                        case "3":
                             $status ='Reject';
                            break;
                         case "4":
                          $status ='Done';
                            break;    
                        default:   $status ='Pending';
      
}
                        ?>

   
        <div class="row">
                <div class="col-lg-7">
                  <div class="card-box">
                    <h4 class="header-title m-t-0">  Task Title Showing Now For Added Task</h4><span class="label label-pink">
                       
                    <?php echo $status ?></span>
                    <hr>
                    <div class="row">
                        
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label><b>Special note</b></label>
                                <p><?php echo $task->special_note ?></p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                    <label><b>Start date</b></label>
                                   <p> <?php echo date('d-m-Y',intval($task->start_date)); ?> </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                    <label><b>Start Time</b></label>
                                     <p><?php echo date('h:i A',intval($task->start_time)) ?> </p> 
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                    <label><b>Dead Line Date</b></label>
                                      <p><?php echo date('d-m-Y',intval($task->dead_line_date))    ?> </p>   
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                    <label><b>Dead Line Time</b></label>
                                     <p> <?php echo date('h:i A',intval($task->dead_line_time)) ?></p> 
                            </div>
                        </div>

                        <div class="col-lg-12">
                            <div class="form-group">
                                    <label for="userName"><b>Description</b></label>
                                    <p><?php echo $task->description ?> </p>
                            </div>
                        </div>
                        
                    </div>
                  </div>
                </div>
                <div class="col-lg-5">
                  <div class="card-box">
                    <!-- <h4 class="header-title m-t-0">Assign To</h4> -->
                      <h4 class="header-title m-t-0"><b>Comment Section</b></h4>
                      <hr>
                    <div class="row">
                    
                         <!-- CHAT -->
                            <div class="col-lg-12">
                                
                                    <div class="chat-conversation">
                                        <ul class="conversation-list nicescroll">
                                            
                                            <?php foreach ($comment as $key => $value) {
                                            //  echo '<pre>';print_r($value); echo '</pre>';
                                                if($this->session->userdata('securelogin')['id'] !=$value['comment_by']) {
                                            ?>

                                            <li class="clearfix">
                                                <div class="chat-avatar">
                                                    <img src="<?php echo base_url(); ?>assets/images/avatar-1.jpg" alt="male">
                                                    <i><?php echo date('m/d H:i',intval($value['added_on'])) ?></i>
                                                </div>
                                                <div class="conversation-text">
                                                    <div class="ctext-wrap">
                                                        <i><?php echo $value['comment_to_name']?></i>
                                                        <p>
                                                           <?php echo $value['comment']?>
                                                        </p>
                                                    </div>
                                                </div>
                                            </li>
                                        <?php } else { ?>
                                            <li class="clearfix odd" id="c_<?php echo $value['id']?>">
                                                <div class="chat-avatar">
                                                    <img src="<?php echo base_url(); ?>assets/images/users/avatar-5.jpg" alt="Female">
                                                    <i><?php echo date('m/d H:i',intval($value['added_on'])) ?></i>
                                                </div>
                                                <div class="conversation-text">
                                                    <div class="ctext-wrap">
                                                       <i><?php echo $value['comment_by_name']?>
                                                        <p>
                                                           <?php echo $value['comment']?>
                                                        </p>
                                                    </div>
                                                </div>
                                            </li>
                                           <?php  }} ?>
                                            <!-- <li class="clearfix">
                                                <div class="chat-avatar">
                                                    <img src="<?php echo base_url(); ?>assets/images/avatar-1.jpg" alt="male">
                                                    <i>10:01</i>
                                                </div>
                                                <div class="conversation-text">
                                                    <div class="ctext-wrap">
                                                        <i>John Deo</i>
                                                        <p>
                                                            Yeah everything is fine
                                                        </p>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="clearfix odd">
                                                <div class="chat-avatar">
                                                    <img src="<?php echo base_url(); ?>assets/images/users/avatar-5.jpg" alt="male">
                                                    <i>10:02</i>
                                                </div>
                                                <div class="conversation-text">
                                                    <div class="ctext-wrap">
                                                        <i>Smith</i>
                                                        <p>
                                                            Wow that's great
                                                        </p>
                                                    </div>
                                                </div>
                                            </li> -->
                                        </ul>
                                        <div class="row">
                                            <form method ="post" id="AddComment">
                                            <div class="col-sm-9 chat-inputbar">
                                                <input type="text" id="comment" class="form-control chat-input" name ="comment" placeholder="Enter your text">
                                            </div>
                                            <div class="col-sm-3 chat-send">
                                         <button type="submit" class="btn btn-md btn-info btn-block waves-effect waves-light" >Send</button>
                                            </div>
                                            <input type ="hidden" name="task_id" value="<?php echo $task->id;?>">
                                            <input type ="hidden" name="user_id" value="<?php echo $this->session->userdata('securelogin')['id']; ?>" >
                                            <input type ="hidden" name="comment_to" value="<?php echo $task->taskby_user_id;?>">
                                             </form>     
                                        </div>
                                        <div id="errorMessageLog"></div>
                                    </div>
                                

                            </div> <!-- end col-->
                           
                        
                       
                    </div>
                  </div>
                </div>

                
        </div>

        <div class="row">
                           

                            <div class="col-lg-12">
                                <div class="card-box">
                                    <h4 class="m-t-0 m-b-20 header-title"><b>MAP</b></h4>
                      <iframe src="<?php echo  site_url('home/map/'.$task->id)?>" height="600" width="100%" style="border:none;"></iframe>
                                  
                                </div>
                            </div>
                        </div>
        
            
            
    

    <div class="clearfix"></div>


        <!-- end row -->

    </div> <!-- container -->


<script type="text/javascript">
$("#AddComment").submit(function( event ){
     event.preventDefault();
 if($('#AddComment').valid())
 {
  
   $.post("<?php echo site_url('Task/AddComment');?>",$("#AddComment").serialize(), function(data, status){
    var height = 250;
    $('#comment').val('');
$('.conversation-list li').each(function(i, value){
    height += parseInt($(this).height());
});

height += '';

$('.conversation-list').animate({scrollTop: height});
          $(".conversation-list").load(location.href + " .conversation-list>*", "");

      });
 }  
});


</script>