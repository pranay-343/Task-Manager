<?php

defined('BASEPATH') OR exit('No direct script access allowed');
 require APPPATH . 'core/Rest_Controller.php';
 
/**
    
 * Controller for all Toke Refresh, etc..
 */ 

	class Token extends Rest_Controller
	{

		function __construct()
		{
			parent::__construct();
		}

		function Refresh()
		{
			$pera =$this->PerameterValidation(array('user_id','oldToken'));
		    $data = $this->emptyValidation(array('user_id','oldToken'));
		    $where = array('user_id'=>$pera['user_id']);
		    $check = $this->RestModal->checkUserToken($where);
		    if($check)
		    {
		    	if($check->token == $pera['oldToken'])
		    	{
		             $this->refreshToken($pera['user_id']);
	              $res = array('status'=>'200','message'=>'Check header');
		    	}
		    	else
		    	{
	              $res = array('status'=>'401','message'=>'Unauthorized');
		    	}
		    }
		    else
		    {
	         $res = array('status'=>'404','message'=>'User detail not found');
		    }
	              
		    $this->response($res);
		}

		
	}
?>
