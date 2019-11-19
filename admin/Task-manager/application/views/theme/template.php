<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="<?php if(isset($meta_desc) && $meta_desc) {echo $meta_desc;} ?>">
      <meta name="author" content="<?php if(isset($meta_author) && $meta_author) { echo $meta_author; }else {echo 'Loggedin';}?>">
      <link rel="shortcut icon" href="<?php echo base_url();?>assets/images/new-favicon.ico">
      <title> <?php if(isset($title) && $title) echo $title; ?> </title>
      <!--Morris Chart CSS -->
      <link rel="stylesheet" href="<?php echo base_url();?>assets/morris/morris.css">
      <link href="<?php echo base_url();?>assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
      <link href="<?php echo base_url();?>assets/css/icons.css" rel="stylesheet" type="text/css" />
      <link href="<?php echo base_url();?>assets/css/style.css" rel="stylesheet" type="text/css" />
      <link href="<?php echo base_url	();?>assets/custom/css/admin.css" rel="stylesheet" type="text/css" />
      <link href="<?php echo base_url();?>assets/custom/css/theme.css" rel="stylesheet" type="text/css" />
      <link href="<?php echo base_url();?>plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
<!--      <link href="<?php echo base_url();?>plugins/bootstrap-select/css/multi-select.css" rel="stylesheet" type="text/css" />-->
      <link href="<?php echo base_url();?>plugins/switchery/css/switchery.min.css" rel="stylesheet" />
      <link href="<?php echo base_url();?>plugins/bootstrap-tagsinput/css/bootstrap-tagsinput.css" rel="stylesheet" />
      <link href="<?php echo base_url();?>plugins/timepicker/bootstrap-timepicker.min.css" rel="stylesheet" />
      <link href="<?php echo base_url();?>plugins/timepicker/bootstrap-timepicker.min.css" rel="stylesheet">
      <link href="<?php echo base_url();?>plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
      <link href="<?php echo base_url();?>plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet">
      <link href="<?php echo base_url();?>plugins/clockpicker/css/bootstrap-clockpicker.min.css" rel="stylesheet">
      <link href="<?php echo base_url();?>plugins/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
      <link href="<?php echo base_url();?>assets/css/jsk.css" rel="stylesheet">
      <script type="text/javascript" src="<?php echo base_url()?>/assets/js/jquery.min.js"></script>
      <script src="<?php echo base_url();?>assets/js/modernizr.min.js"></script>
      <script src="<?php echo base_url();?>plugins/switchery/js/switchery.min.js"></script>   
          <!-- jQuery  -->
      <script src="<?php echo base_url();?>assets/js/popper.min.js"></script><!-- Popper for Bootstrap -->
 <script src="<?php echo base_url();?>assets/js/bootstrap.min.js"></script>
   </head>
   <body class="fixed-left">
      <!-- Begin page -->
      <div id="wrapper">
         <!-- Top Bar Start -->
         <div class="topbar">
            <!-- LOGO -->
            <div class="topbar-left">
               <div class="text-center">
                  <a href="<?php echo site_url('admin/dashboard')?>" class="logo">
				  <!-- <img src="<?php echo base_url('assets/loggedin_images/thime/logo_small.png'); ?>" height="30" class="small_logo hide"> -->
				  <!-- <img src="<?php echo base_url('assets/loggedin_images/thime/logo_admin_panel.png'); ?>" height="50" class="big_logo">-->TASK</a>

               </div>
            </div>
            <!-- Button mobile view to collapse sidebar menu -->
            <!-- navigation  -->  
            <?php $this->view('theme/nav'); ?> 
         </div>
         <!-- Top Bar End -->
         <!-- ========== Left Sidebar Start ========== -->
         <?php $this->view('theme/left_sidebar'); ?>                 
         <!-- Left Sidebar End -->
         <!-- ============================================================== -->
         <!-- Start right Content here -->
         <!-- ============================================================== -->
         <div class="content-page mb-5 mb-sm-0">
            <!-- Start content -->
            <?php $this->view($contents); ?> 
         </div>
         <!-- content -->
         <footer class="footer">
            &copy; <?php echo date('Y'); ?>. All rights reserved.
            <span class="text-right download">Download Task manager App:
            <img src="<?php echo base_url('assets/loggedin_images/thime/google-new.png'); ?>" height="18">
            <img src="<?php echo base_url('assets/loggedin_images/thime/apple-new.png'); ?>" height="18">
            </span>
         </footer> 
      </div>
      <!--  ============================================================== -->
      <!-- End Right content here -->
      <!-- ============================================================== -->
      <!-- Right Sidebar -->
      <?php $this->view('theme/right_sidebar'); ?> 
      <!-- /Right-bar -->
      </div>
      <!-- END wrapper -->
	  <div class="loading-overlay" id="loading-overlay"></div>  
      <script>
         var resizefunc = [];
      </script>

      <script src="<?php echo base_url();?>assets/js/detect.js"></script>
      <script src="<?php echo base_url();?>assets/js/fastclick.js"></script>
      <script src="<?php echo base_url();?>assets/js/jquery.slimscroll.js"></script>
      <script src="<?php echo base_url();?>assets/js/jquery.blockUI.js"></script>
<!--      <script src="<?php echo base_url();?>assets/js/waves.js"></script>
      <script src="<?php echo base_url();?>assets/js/wow.min.js"></script>-->
      <script src="<?php echo base_url();?>assets/js/jquery.nicescroll.js"></script>
      <script src="<?php echo base_url();?>assets/js/jquery.scrollTo.min.js"></script>
      <!-- Counterup  -->
      <script src="<?php echo base_url();?>plugins/waypoints/lib/jquery.waypoints.min.js"></script>
      <script src="<?php echo base_url();?>plugins/counterup/jquery.counterup.min.js"></script>
      <script src="<?php echo base_url();?>plugins/raphael/raphael-min.js"></script>
<!--      <script src="<?php echo base_url();?>assets/pages/jquery.dashboard_4.js"></script>-->
      <script src="<?php echo base_url();?>assets/js/jquery.core.js"></script>
      <script src="<?php echo base_url();?>assets/js/jquery.app.js"></script>
      <script type="text/javascript" src="<?php echo base_url()?>/assets/custom/js/jquery.validate.min.js"></script>
      <script type="text/javascript" src="<?php echo base_url()?>/assets/custom/js/additional-methods.js"></script>
      <script src="<?php echo base_url();?>plugins/morris/morris.min.js"></script>
     
      <script src="<?php echo base_url();?>plugins/bootstrap-select/js/bootstrap-select.min.js"></script>
      <script src="<?php echo base_url();?>plugins/bootstrap-tagsinput/js/bootstrap-tagsinput.min.js"></script>
      <script src="<?php echo base_url();?>plugins/timepicker/bootstrap-timepicker.js"></script>
      <script src="<?php echo base_url();?>assets/pages/jquery.form-pickers.init.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.1/jquery.rateyo.min.js"></script>
      <script src="<?php echo base_url();?>/plugins/moment/moment.js"></script>
      <script src="<?php echo base_url();?>plugins/timepicker/bootstrap-timepicker.js"></script>
      <script src="<?php echo base_url();?>plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
      <script src="<?php echo base_url();?>plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
      <script src="<?php echo base_url();?>plugins/clockpicker/js/bootstrap-clockpicker.min.js"></script>
      <script src="<?php echo base_url();?>plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
      <script src="<?php echo base_url();?>assets/pages/jquery.form-pickers.init.js"></script>
       <script src="<?php echo base_url();?>assets/custom/js/custom_first.js"></script>
      <script src="<?php echo base_url();?>assets/custom/js/admin_custom.js"></script>
      <script src="<?php echo base_url();?>assets/custom/js/admin_function.js"></script>
   </body>
</html>