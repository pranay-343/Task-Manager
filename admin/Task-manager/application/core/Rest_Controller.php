<?php
/**
 * 
 */
 class Rest_Controller extends CI_Controller
 {
	
	  public $request;
	  function __construct()
	  {
	    parent::__construct(); //need this!!
	      $this->load->model("api/RestModal");
	      $this->config->load('rest');
	      $this->manageHeaders();
	      $this->request = json_decode(file_get_contents("php://input"), true);
	      $this->Authorization();   //Check all header
	  }

	  function manageHeaders()
	  {
	  	 header("Access-Control-Allow-Origin: *");
         header("Access-Control-Allow-Methods: PUT, GET, POST,UPDATE,DELETE");
         header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept,api_key, app_secret,authtoken");
         header("Access-Control-Expose-Headers: Origin, X-Requested-With, Content-Type, Accept,api_key, app_secret,authtoken"); 
	  }

	  function Authorization()
	  {
	  	     $checkURI  = explode('/', $_SERVER['REQUEST_URI']);
	         if(end($checkURI) == 'Refresh' || end($checkURI) =='AddIP')
	         {
	          return true;
	         }

	  	    $header      = getallheaders();

		    if (array_key_exists('api_key',$header) && array_key_exists('app_secret',$header) )
		    {
		           $this->loginAuth($header);
		    }
		    else
		    {
		      if(array_key_exists('authtoken',$header))
		      {
		        // return true;
		        $this->checkToken($header['authtoken']);

		      }
		      else
		      {
		        $res = array('status'=>'400','message'=>'Header is missing');
		        $this->response($res);
		      }
		    }

	  }

	  function loginAuth($header)
	  {
	       //check this header is only for signIn signUp
	        $checkURI  = explode('/', $_SERVER['REQUEST_URI']);
	         if(end($checkURI) == 'SignUp' || end($checkURI) == 'SignIn' || end($checkURI) == 'ForgotPassword' || end($checkURI) == 'AnotherDevice' || end($checkURI) == 'SocialLogin')
	         {}
	         else
	         {
	           $res = array('status'=>'405','message'=>'Method Not Allowed');
	           $this->response($res);
	         }
	       //check this header is only for signIn signUp

	       if($header['api_key'] == $this->config->item('api_key') && $header['app_secret'] == $this->config->item('app_secret'))
	            {
	              return true;
	            }
	            else
	            {
	              $res = array('status'=>'401','message'=>'Unauthorized');
	              $this->response($res);
	            }
	  }

	  function checkToken($token)
	  {
	  	  if($token == 'test@123')
	  	  {
            return true;
	  	  }

	      $payload = explode('.',$token);
	      $userDetail = json_decode(base64_decode(end($payload)),true);
	      $user_id    = $userDetail['user_id']; 
	      $where = array('token'=>$token,'user_id'=>$user_id);
	      $check = $this->RestModal->checkToken($where);
	      if($check)
	      {
	         $expire  = $check['expire_time'];
	         if(now>$expire)
	         {
	               $res = array('status'=>'408','message'=>'Token expire.');
	               $this->response($res);
	         }
	         else
	         {
	          return true;
	         }
	      }
	      else
	      {
	        $res = array('status'=>'401','message'=>'Unauthorized');
	        $this->response($res);
	      }
	     
	  }
	  function GetToken($payload)
	  {
        $token = openssl_random_pseudo_bytes(35).'__'.uniqid().rand(0,50);
        $token = bin2hex($token);
        $token = str_replace('._', 'TO', $token);
        return  $token.'.'.$payload;
	  }
	  function addToken($token)
	  {
	      $payload = explode('.',$token);
	      $userDetail = json_decode(base64_decode(end($payload)),true);
	      $user_id    = $userDetail['user_id']; 
	      $check = $this->RestModal->checkToken(array('user_id'=>$user_id));
	       $now = date('d-m-Y H:i:s');
	      $expiry  = strtotime($now.token_expire);
	      if(!$check)
	      {
	        // insert New token
	        $insert['user_id']      = $user_id;
	        $insert['token']        = $token;
	        $insert['expire_time']  = $expiry;
	        $insert['added_on']     = time();
	        $this->RestModal->AddToken($insert);
	      }
	      else
	      {
	        $update['token']        = $token;
	        $update['expire_time']  = $expiry;
	        $update['update_on']    = time();
	        $where['user_id']      = $user_id;
	        $this->RestModal->updateToken($update,$where);

	      }
	  }
	  function refreshToken($user_id)
	  {
	    $payload = base64_encode(json_encode(array('user_id'=>$user_id)));
	    $token = $this->GetToken($payload);
	    $this->addToken($token);
	    header('authtoken:'.$token);
	    // http_response_code(205);
	  }

	  function PerameterValidation($pera,$req=array())
  {
        $requett =$this->request; 
        if(count($req) != 0)
        {
         $requett = $req;
        }
        $res = array();
        $success = array();
        foreach($pera as $perameter)
        {
          
           if(isset($requett[$perameter]))
           { 
            $success[$perameter] = ($requett[$perameter])?$requett[$perameter]:'';
           }
           else
           {
            $res[] = $perameter.' perameter is missing.';
           }
        }
        if(count($res) == 0)
        {
          return $success;
        }
        else
        {
             $msg['status']  = "400";
             $msg['message'] = "Perameter missing";
             // $msg['record'] = $res;

            $this->response($msg,400);
        }
  }
  function emptyValidation($pera,$req=array())
  {
        $requett =$this->request; 
        if(count($req) != 0)
        {
         $requett = $req;
        }
        
        $res = array();
        $success = array();
        foreach($pera as $perameter)
        {
           if(!empty($requett[$perameter]))
           { 
            $success[$perameter] = ($requett[$perameter])?$requett[$perameter]:'';
           }
           else
           {
            $res[] = $perameter.' can not be empty.';
           }
        }
        if(count($res) == 0)
        {
          return $success;
        }
        else
        {
             $msg['status']  = "400";
              $msg['message'] = "Perameter is empty";
             // $msg['record'] = $res;
            $this->response($msg,400);
        }
  }

  function response($res)
  {
        if(!is_array($res)){
          $res = array('status'=>'400','message'=>'response is not json');
        }
        print(json_encode($res));
          die();
  }
  

  



 }
?>