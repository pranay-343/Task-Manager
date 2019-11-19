     <div class="content">
                    <div class="container-fluid">

  <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <h4 class="page-title">Task Manager</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active">User List</li>
                </ol>

            </div>
        </div>
                        <div class="row">
                            <div class="col-lg-12">

                                <div class="card-box">
                                    <h4 class="m-t-0 header-title">All User List</h4>
                                
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>User Id</th>
                                            <th>User Name</th>
                                            <th>Email</th>
                                            <th>Contact</th>
                                            <!-- <th>profile_img</th> -->
                                            <th>designation</th>
                                            <th>hiring_date</th>
                                            <th>work_hour</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                      <tbody>
                                          <?php
                                          $i = 0;
                                            foreach($users as $list)
                                            {
                                          $i++;

                                                ?>
                                                <tr>
                                                    <td><?php echo $i?></td>
                                                    <td>#<?php echo $list['id']?></td>
                                                    <td><?php echo $list['full_name']?></td>
                                                    <td><?php echo $list['email']?></td>
                                                    <td><?php echo $list['phone']?></td>
                                                    <td><?php echo $list['designation']?></td>
                                                    <td><?php echo $list['hiring_date']?></td>
                                                    <td><?php echo $list['work_hour']?> Hours</td>
                                                    <td>
                                                        <?php 
                                                        if($list['status'] == '1')
                                                         {
                                                          echo '<a class="btn btn-success" title="Click for block" href="'.site_url('User/deleteUser/'.$list['id'].'/2').'" >Active</a>';
                                                         }
                                                         else if($list['status'] == '2')
                                                         {
                                                            echo '<a class="btn btn-danger" title="Click for Active"  href="'.site_url('User/deleteUser/'.$list['id'].'/1').'" >Block</a>';
                                                         }
                                                         else
                                                         {
                                                             echo '<a class="btn btn-primary" title="Click for active"  href="'.site_url('User/deleteUser/'.$list['id'].'/1').'" >Not Verify</a>';
                                                         }

                                                        ?>
                                                        
                                                        <!-- <a class="btn btn-danger">Block</a> -->
                                                        <!-- <button>Active</button> -->
                                                    </td>
                                                    <td><a href="<?php echo site_url('User/AddUser/edit/'.$list['id']) ?>">Edit</a>/<a href="<?php echo site_url('User/deleteUser/'.$list['id']) ?>">Delete</a></td>
                                                    
                                                </tr>
                                                <?php
                                            }
                                          ?>
                                      </tbody>
                                    </table>
                                </div>

                            </div>
                            

                        </div>

                    </div> <!-- container -->

                </div> <!-- content -->