   <div class="content">
    <div class="container-fluid">

      <!-- Page-Title -->
      <div class="row">
        <div class="col-sm-12">
          <h4 class="page-title">Task Manager</h4>
          <ol class="breadcrumb">
            <li class="breadcrumb-item active">Assign Task</li>
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
      <?php 
       if(isset($task) &&  $task){
      $task_titile =$task->task_titile;
      $special_note  =  $task->special_note;
      $start_date =  $task->start_date;
      $start_time  =      $task->start_time;
      $dead_line_date=         $task->dead_line_date;
      $dead_line_time =        $task->dead_line_time;
      $description=            $task->description;
      $assign_to = explode(',',$task->assign_to);
    //  print_r($assign_to);

    }else {
      $task_titile = $special_note = $start_date = $start_time =  $dead_line_date= $dead_line_time =  $description ='';
      $assign_to = array();
    }
      ?>

      <?php echo validation_errors(); ?>
      <form method="post" id ="assign_form" action="<?php echo site_url('Task/addTask') ?>">
        <div class="row">
          <div class="col-lg-7">
            <div class="card-box">
              <h4 class="header-title m-t-0">Task Detail</h4>
              <hr>
              <div class="row">
                <div class="col-lg-12">
                  <div class="form-group">
                    <label for="userName">Title<span class="text-danger">*</span></label>
                    <input value="<?php echo (set_value('title'))?set_value('note'):$task_titile; ?>"  type="text" required name="title" parsley-trigger="change" 
                    class="form-control">
                    <?php echo form_error('title', '<div class="error">', '</div>'); ?>
                  </div>
                </div>
                <div class="col-lg-12">
                  <div class="form-group">
                    <label for="userName">Special note<span class="text-danger">*</span></label>
                    <input  value="<?php echo (set_value('note'))?set_value('note'):$special_note; ?>"  required type="text" name="note" parsley-trigger="change" 
                    class="form-control">
                    <?php echo form_error('note', '<p class="error">', '</p>'); ?>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-group">
                    <label for="userName">Start date<span class="text-danger">*</span></label>
                    <input  value="<?php echo (set_value('start_date'))?set_value('start_date'):date('Y-m-d',intval($start_date)); ?>"  required type="date" name="start_date" parsley-trigger="change" 
                    class="form-control">
                    <?php echo form_error('start_date', '<p class="error">', '</p>'); ?>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-group">
                    <label for="userName">Start Time</label>
                    <input  value="<?php echo (set_value('start_time'))?set_value('start_time'):date('H:i:s',intval($start_time)); ?>"  required type="time" name="start_time" parsley-trigger="change" 
                    class="form-control">
                    <?php echo form_error('start_time', '<p class="error">', '</p>'); ?>   
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-group">
                    <label for="userName">Dead Line Date<span class="text-danger">*</span></label>
                    <input  value="<?php echo (set_value('dead_line_date'))?set_value('dead_line_date'):date('Y-m-d',intval($dead_line_date)); ?>"  type="date" name="dead_line_date" parsley-trigger="change" 
                    class="form-control">
                    <?php echo form_error('dead_line_date', '<p class="error">', '</p>'); ?>     
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-group">
                    <label for="userName">Dead Line Time</label>
                    <input  value="<?php echo (set_value('dead_line_time'))?set_value('dead_line_time'):date('H:i:s',intval($dead_line_time)); ?>"  type="time" name="dead_line_time" parsley-trigger="change" 
                    class="form-control">
                    <?php echo form_error('dead_line_time', '<p class="error">', '</p>'); ?>  
                  </div>
                </div>

                <div class="col-lg-12">
                  <div class="form-group">
                    <label for="userName">Description<span class="text-danger">*</span></label>
                    <textarea required="" class="form-control" name="description"> <?php echo (set_value('description'))?set_value('description'):$description; ?></textarea>
                    <?php echo form_error('description', '<p class="error">', '</p>'); ?> 
                  </div>
                </div>

              </div>
            </div>
          </div>
          <div class="col-lg-5">
            <div class="card-box">
              <h4 class="header-title m-t-0">Assign To</h4>
              <hr>
              <div class="row">
               <div class="col-lg-12">
                <?php
                foreach($users as $alluser)
                {
                    
                  ?>
                  <div class="form-group mb-1">
                    <input type="checkbox" name="assign_to[]" value="<?php echo $alluser['id']?>" <?Php if (in_array($alluser['id'], $assign_to)){ echo 'checked';}?> required>
                    <label for="checkbox6a">
                      <?php echo $alluser['full_name']?>
                    </label>
                  </div>
                  <?php
                }
                ?>
              </div>



            </div>
          </div>
        </div>

        <div class="col-md-12">
          <div class="form-group text-center">
            <button class="btn btn-primary waves-effect waves-light submitform" type="submit">
              Submit
            </button>
          </div>
        </div>
      </div>
       <input  type ="hidden" id ="task_id" name ="task_id" value ="<?php echo $task_id; ?>" >


    </form>

    <div class="clearfix"></div>


    <!-- end row -->

  </div> <!-- container -->




