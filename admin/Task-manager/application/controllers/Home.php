<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
require_once("CommanControllers.php");

class Home extends CommanControllers {
    
      	function __construct()
    	{
    		parent:: __construct();
    		$this->load->model('UserModel',"Admin");
    	}

public function map($task_id){
       
  $traker = $this->Admin->map($task_id);
   // print_r( $traker);  
     $wayPoints = array();
     foreach ($traker as $key => $value) {
        $wayPoints[] = $value['user_lat'].','.$value['user_long'];
     }
      
      //$wayPoints = ["Uttam Nagar West, New Delhi, Delhi","Meerut","Aligarh","Anupshahr","Bulandshahr"];
        $data['wayPoints'] =array_unique($wayPoints);
       $this->load->view("map",$data);
}
	public function login()
	{
		$this->form_validation->set_rules('username', 'Username', 'required');
		$this->form_validation->set_rules('password', 'Password', 'required');
		if ($this->form_validation->run() == FALSE)
		{
			if($this->session->userdata('securelogin')){
				redirect('superadmin/dashboard');
			}else{
				$this->load->view("login");
			}
		}
		else{
			 $username = trim($this->input->post('username'));
			$password = trim($this->input->post('password'));

			$data = $this->Admin->RowData('users','*',array('user_type '=>'1','email'=>$username,"password"=>md5($password)));

			if($data)
			{
                    $newdata = array(
							'id'  	 => $data->id,
							'name'  	 => $data->full_name,
							'first_name'  	 => $data->first_name,
							
							'email'      => $data->email,
							'lastlogin'  => $data->last_login,
							'mobile' 	 => $data->contact
					);
					$this->session->set_userdata('securelogin', $newdata);
					redirect('/Home');
			}
			else
			{
                   $this->session->set_flashdata('response',"<p style='text-align: center;font-size: 17px;color: #d61d1d;margin-bottom: -21px;'>Username or password wrong.</p>");
					redirect('Home/login');
			}
		}
	}
	
	public function logout()
	{
		$newdata = array(
				'name'  	 => '',
				'email'      => '',
				'lastlogin'  => '',
				'mobile' 	 => ''
		);
		$this->session->unset_userdata($newdata);
		$this->session->sess_destroy();
		redirect('Home/login','refresh');
	}
	
	
}

?>