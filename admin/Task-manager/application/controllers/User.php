<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
require_once("CommanControllers.php");
class User extends CommanControllers {
    
      	function __construct()
    	{
    		parent:: __construct();
    		$this->load->model('UserModel',"User");
    		 $this->checkLogin();

    	}

	public function index()
	{
		if($this->session->userdata('securelogin')){
			$data['title'] = '';
			$data['contents'] = 'dashboard';
			$this->load->view("theme/template",$data);
		}else{
			redirect('Admin/login');
		}
	 }

	 function AddUser($add='',$edit='')
	 {
	 	
	 	$Detail = array();
	    $designation = $this->User->GetData("designation","id,department,name",'');
	    if($add !='save')
	    {
	    	if($add !='edit')
	    	{
                $data['title']    = 'Add User';
			    $data['contents'] = 'Add-user';
			    $data['designation'] = $designation;
			    $data['Detail'] = $Detail;
				$data['message']     = "";
		        $this->load->view("theme/template",$data);
	    	}
	    	else
	    	{
	    $detail = $this->User->RowData("users","*",array('id'=>$edit));
	    if($detail)
	    {
	    	print_r($detail);die();
                $data['title']    = 'Add User';
			    $data['contents'] = 'Add-user';
			    $data['designation'] = $designation;
			    $data['Detail'] = $Detail;
				$data['message']     = "";
	    }
	    else
	    {
	    	    $data['title']    = 'Add User';
			    $data['contents'] = 'Add-user';
			    $data['designation'] = $designation;
			    $data['Detail'] = $Detail;
				$data['message']     = "";
	    }
	    		
		        $this->load->view("theme/template",$data);
	    	}

           
	    }
	    else
	    { 

		    $this->form_validation->set_rules('first_name', 'first name', 'required');
			$this->form_validation->set_rules('last_name', 'last name', 'required');
			$this->form_validation->set_rules('email', 'email', 'required|is_unique[users.email]');
			// $this->form_validation->set_rules('department', 'department', 'required');
			$this->form_validation->set_rules('designation', 'designation', 'required');
			if ($this->form_validation->run() == FALSE)
			{
			     $data['title']    = 'Add User';
			    $data['contents'] = 'Add-user';
			    $data['designation'] = $designation;
			    $data['Detail'] = $Detail;
				$data['message']     = "";
		        $this->load->view("theme/template",$data);
			}
			else
			{
				$insert['first_name']  = $this->input->post('first_name');
		    	$insert['last_name']   = $this->input->post('last_name');
		    	$insert['full_name']   = $insert['first_name'].' '.$insert['last_name'];
		    	$insert['phone']       = $this->input->post('phone');
		    	$insert['email']       = $this->input->post('email');
		    	$insert['password']    = md5($this->input->post('password'));
		    	$insert['md_5']        = $this->input->post('password');
		    	// $insert['department']  = $this->input->post('department');
		    	$insert['designation'] = $this->input->post('designation');
		    	$insert['joining_date'] = $this->input->post('joining_date');
		    	$insert['work_hour']   = $this->input->post('hour');
		    	$insert['status']   = '1';
		    	$insert['added_on']   = strtotime(date('d-m-Y H:i:s'));
		    	   $insert['user_type'] = '3';
		    	$query   = $this->User->AddData('users',$insert);
		    	if($query)
		    	{
	               

	            $data['title']    = 'Add User';
			    $data['contents'] = 'Add-user';
			    $data['designation'] = $designation;
			    $data['Detail'] = $Detail;
     		    $data['message']     = "Successfully added.";
		        $this->load->view("theme/template",$data);
		    	}
		    	else
		    	{
		            

			        $data['title']    = 'Add User';
				    $data['contents'] = 'Add-user';
				    $data['designation'] = $designation;
				    $data['Detail'] = $Detail;
					$data['message']     = "Something went wrong. Try again";
			        $this->load->view("theme/template",$data);
		    	}
			}
		    	

		  }
	 }

	 function UserList()
	 {
	 	    $users = $this->User->GetData("users","*",array('status !='=>'4','user_type >'=>'2'));	    
            $data['title'] = 'User List';
		    $data['contents'] = 'user-list';
		    $data['users'] = ($users)?$users:array();
			$data['message']     = "";
	        $this->load->view("theme/template",$data);
	 }

	 function deleteUser($user_id='',$status='4')
	 {
            
              	$update['status']   = $status;
		        $update['update_on']   = strtotime(date('d-m-Y H:i:s'));

		    	$query   = $this->User->updateData('users',$update,array('id'=>$user_id));
		    	if($query)
		    	{
	                redirect('User/UserList');
		    	}
		    	else
		    	{
	                redirect('User/UserList');
		    	}
	 }


	
	
	
}

?>