     <div class="content">
                    <div class="container-fluid">

  <!-- Page-Title -->
        <div class="row">
            <div class="col-sm-12">
                <h4 class="page-title">Task Manager</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active">Task List</li>
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
                                            <th>Id</th>
                                            <th> title</th>
                                            <th>Status</th>
                                             <th>View</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                      <tbody>
                                          <?php
                                          $i = 0;
                                            foreach($tasks as $list)
                                            {
                                          $i++;

                                                ?>
                                                <tr>
                                                    <td><?php echo $i?></td>
                                                    <td>#<?php echo $list['id']?></td>
                                                    <td><?php echo $list['task_titile']?></td>
                                                   
                                                    <td>
                                                        <?php //   0=save, 1=assign,2=ongoing,3=reject,4=done
                                                        if($list['status'] == '1')
                                                         {
                                                          echo '<a class="btn btn-primary" title="Click for block"  >assign</a>';
                                                         }
                                                         else if($list['status'] == '2')
                                                         {
                                                            echo '<a class="btn btn-info" title="Click for Active" >Ongoing</a>';
                                                         }
                                                          else if($list['status'] == '3')
                                                         {
                                                            echo '<a class="btn btn-info" title="Click for Active"   >Reject</a>';
                                                         }else if($list['status'] == '4')
                                                         {
                                                          echo '<a class="btn btn-success" title="Click for block"  >Done</a>';
                                                         }
                                                         else
                                                         {
                                                             echo '<a class="btn btn-primary" title="Click for active"  >Not Verify</a>';
                                                         }

                                                        ?>
                                                        
                                                        <!-- <a class="btn btn-danger">Block</a> -->
                                                        <!-- <button>Active</button> -->
                                                    </td>
                                                       <td><a href="<?php echo site_url('Task/taskDetails/'.$list['id']) ?>" class="btn btn-primary" title="Click for active"  >View</a></td>
                                                    <td><a href="<?php echo site_url('Task/edit/'.$list['id']) ?>">Edit</a>/<a href="<?php echo site_url('Task/deletetask/'.$list['id']) ?>">Delete</a></td>
                                                    
                                                 
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