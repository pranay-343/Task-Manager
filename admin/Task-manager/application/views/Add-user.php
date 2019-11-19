   <div class="content">
    <div class="container-fluid">

        <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <h4 class="page-title">Task Manager</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active">Add New User</li>
                </ol>

            </div>
        </div>


        <div class="row">

            <!-- <div class="col-lg-3"></div> -->
            <div class="col-lg-12">

                <div class="card-box">
                    <!-- <h4 class="header-title m-t-0">Basic Form</h4> -->
                
                    <?php echo (!empty($message))?'<div class="alert alert-success">'.$message.'</div>':""; ?>
                  <!-- <strong>Success!</strong> Indicates a successful or positive action. -->
                

                    <form action="<?php echo site_url('User/AddUser/save')?> " method="post">
                        <div class="row">
                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">First Name<span class="text-danger">*</span></label>
                                    <input type="text" name="first_name" parsley-trigger="change" 
                                    placeholder="Enter first name" class="form-control">
                                    <?php echo form_error('first_name', '<div class="error">', '</div>'); ?>
                                </div>
                            </div>
                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Last Name<span class="text-danger">*</span></label>
                                    <input type="text" name="last_name" parsley-trigger="change" 
                                    placeholder="Enter last name" class="form-control">
                                     <?php echo form_error('last_name', '<div class="error">', '</div>'); ?>
                                </div>
                            </div>
                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Contact No<span class="text-danger">*</span></label>
                                    <input type="text" name="phone" parsley-trigger="change" 
                                    placeholder="Enter contact no" class="form-control">
                                     <?php echo form_error('phone', '<div class="error">', '</div>'); ?>
                                </div>
                            </div>

                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Email<span class="text-danger">*</span></label>
                                    <input type="text" name="email" parsley-trigger="change" 
                                    placeholder="Enter email address" class="form-control">
                                     <?php echo form_error('email', '<div class="error">', '</div>'); ?>
                                </div>
                            </div>
                            
                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Password<span class="text-danger">*</span></label>
                                    <input type="" name="password" parsley-trigger="change" 
                                    placeholder="Enter password" value="123456" class="form-control"  autocomplete="off">
                                     <?php echo form_error('password', '<div class="error">', '</div>'); ?>
                                </div>
                            </div>
                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Designation<span class="text-danger">*</span></label>
                                    <select class="form-control" name="designation">
                                        <option value="">Select Designation</option>
                                        <?php
                                        // print_r($designation);
                                            foreach($designation as $designatios)
                                            {
                                                echo "<option value='".$designatios['department']."'>".$designatios['name']."</option>";
                                            }
                                         ?>
                                    </select>
                                     <?php echo form_error('designation', '<div class="error">', '</div>'); ?>
                                </div>
                            </div>
                            <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Joining Date<span class="text-danger">*</span></label>
                                    <input type="text" name="joining_date" parsley-trigger="change" 
                                    placeholder="Enter Hiring Date" class="form-control" id="datepicker-autoclose" autocomplete="off">
                                </div>
                            </div>
                             <div  class="col-lg-6">
                                <div class="form-group">
                                    <label for="userName">Working Hour Per Day<span class="text-danger">*</span></label>
                                    <select class="form-control" name="hour">
                                        <!-- <option>Select Working hour</option> -->
                                        <option value="0">0</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                    </select>
                                </div>
                            </div>
                         


                        </div>
                        
                        <div class="row">
                               <div class="col-md-12">
                                <div class="form-group text-right m-b-0">
                            <button class="btn btn-primary waves-effect waves-light" type="submit">
                                Submit
                            </button>
                            
                        </div>
                            </div>
                        </div>

                    </form>
                </div> <!-- end card-box -->
            </div>
            <!-- end col -->


        </div>


        <!-- end row -->

    </div> <!-- container -->



