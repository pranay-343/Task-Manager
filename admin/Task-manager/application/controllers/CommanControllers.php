
<?php 
defined('BASEPATH') OR exit('No direct script access allowed');

class CommanControllers extends CI_Controller {
    
      	function __construct()
    	{
    		parent:: __construct();

    	}

	
	 public function index()
	{
		if($this->session->userdata('securelogin')){
			$data['title'] = '';
			$data['contents'] = 'dashboard';
			$this->load->view("theme/template",$data);
		}else{
			redirect('Home/login');
		}
	}
	 public function checkLogin()
	{
		if(!$this->session->userdata('securelogin')){
			redirect('Home/login');
		}
	}
	
	
}

?>