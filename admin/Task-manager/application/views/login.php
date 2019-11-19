<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Loggedin App">
        <meta name="author" content="Loggedin App">

        <link rel="shortcut icon" href="<?php echo base_url();?>assets/images/new-favicon.ico">

        <title>Admin Login</title>

        <link href="<?php echo base_url();?>assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo base_url();?>assets/css/style.css" rel="stylesheet" type="text/css" />
        
    </head>
    <body>

        <div class="account-pages"></div>
        <div class="clearfix"></div>
        <div class="wrapper-page">
            <div class="card-box">
                <div class="panel-heading">
                    <h4 class="text-center"><strong class="text-custom">Task Manager</strong></h4>
                </div>

<?php echo $this->session->flashdata('response');?>
                <div class="p-20"><br><br>
                    <form class="form-horizontal m-t-20" action="" method="post">

                        <div class="form-group ">
                            <div class="col-12">
                                <input class="form-control" name="username" type="text" required="" placeholder="Username">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-12">
                                <input class="form-control" name="password" type="password" required="" placeholder="Password">
                            </div>
                        </div>

                        <div class="form-group text-center m-t-40">
                            <div class="col-12">
                                <button class="btn btn-info btn-block text-uppercase waves-effect waves-light"
                                        type="submit">Log In
                                </button>
                            </div>
                        </div>

                    </form>

                </div>
            </div>
            
            
        </div>
        
        

        
    	<script>
            var resizefunc = [];
        </script>
		
		<script src="<?php echo base_url();?>assets/js/jquery.min.js"></script>
		<script src="<?php echo base_url();?>assets/js/bootstrap.min.js"></script>
	
	</body>
</html>