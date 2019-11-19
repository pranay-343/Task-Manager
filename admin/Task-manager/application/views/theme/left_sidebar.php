<div class="left side-menu">
   <div class="sidebar-inner slimscrollleft">
      <!--- Divider -->
      <div id="sidebar-menu">
         <ul>
            <li class="has_sub">
               <a href="<?php echo site_url('home')?>" class="waves-effect"><i class="fa fa-tachometer"></i> <span> Dashboard </span> </a>
            </li>
          <!--   <li class="has_sub"> 
               <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-file-text-o"></i> <span>  Forms  </span> <span class="menu-arrow"></span> </a>
               <ul class="list-unstyled">
                  <li><a href="<?php // echo site_url('admin/form')?>">Add Form</a></li>
                  <li><a href="<?php // echo site_url('admin/form/forms_response')?>">Form Responses</a></li>
               </ul>
            </li> -->
            
            <li class="has_sub">
               <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-users"></i> <span> Users</span> <span class="menu-arrow"></span> </a>
               <ul class="list-unstyled">
                  <li><a href="<?php echo site_url('User/UserList')?>" > User List</a></li>
                  <li><a href="<?php echo site_url('User/AddUser')?>" > Add User </a></li>
                  <!-- <li><a href="o.php" > User Setting </a></li> -->
               </ul>
            </li>
            <li class="has_sub">
               <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-tasks"></i> <span> Tasks</span> <span class="menu-arrow"></span> </a>
               <ul class="list-unstyled">
                  <li><a href="<?php echo site_url('/Task/list')?>" > Task List</a></li>
                  <!-- <li><a href="<?php // echo site_url('/Task/mytasklist')?>" > My Task List </a></li> -->
                  <li><a href="<?php echo site_url('/Task/addTask')?>" > Assign Task </a></li>
               </ul>
            </li>
            
          <?php /*
             <li class="has_sub">
               <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-cog"></i> <span> Settings</span> <span class="menu-arrow"></span> </a>
               <ul class="list-unstyled">
                  <li><a href="<?php echo site_url('Settings/Departments')?>" > Department</a></li>
                  <li><a href="<?php echo site_url('Settings/Designations')?>" > Designation </a></li>
                  <!-- <li><a href="o.php" > User Setting </a></li> -->
               </ul>
            </li>
             */ ?>
           
         </ul>
         <div class="clearfix"></div>
      </div>
      <div class="clearfix"></div>
   </div>
</div>