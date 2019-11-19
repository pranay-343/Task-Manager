<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
require_once("CommanControllers.php");
class Settings extends CommanControllers {
    
      	function __construct()
    	{
    		parent:: __construct();
    		 $this->checkLogin();
    	}

	public function index()
	{
		
	 }

	 function Departments($action="list")
	 {
	 	$data['title'] = 'Department '.$action;
		$data['contents'] = 'department';
		$data['action']   = $action;
	    $this->load->view("theme/template",$data);
	 }
	 function AddDepartment()
	 {
	 	
	 }
	 function Designations($action="list")
	 {
	 	$data['title'] = 'Designation '.$action;
		$data['contents'] = 'designation';
		$data['action']   = $action;
	    $this->load->view("theme/template",$data);
	 }
	 function AddDesignation()
	 {
	 	$data['title'] = '';
		$data['contents'] = 'Department List';
	    $this->load->view("theme/template",$data);
	 }

	
	
	
}

?>