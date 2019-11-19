<?php

defined('BASEPATH') OR exit('No direct script access allowed');
 require APPPATH . 'core/Rest_Controller.php';
 
/**
   
 * Controller for all Driver related  Operation like signin , signUp , update detail,Otp verify,changePassword, etc..
 */ 

	class Users extends Rest_Controller
	{
		function __construct()
		{
			parent::__construct();
		    $this->load->model('api/UserModel', 'User');   
            $this->load->helper('email');

		}

		function index()
		{
       
		}
		 function SignIn()
		{
			 
            $pera = $this->PerameterValidation(array('email','password'));
            $where = " users.email='".$pera['email']."'";
            $check = $this->User->SignUpData($where);

            if($check)
            {
          	  if($check->password ==  md5($pera['password']))
          	  {
          	  	        $responce['id']           = $check->id;
                       $responce['full_name']    = $check->full_name;
                       $responce['first_name']    = $check->first_name;
                       $responce['last_name']    = $check->last_name;                 
                       $responce['email']        = $check->email;
                       $responce['country_code'] = $check->country_code;
                       $responce['phone']        = $check->phone;
                       $responce['department']    = $check->department;
                        $responce['designation']    = $check->designation;
                         $responce['status']    = $check->status;
                       
                       $responce['profile_img']  = ($check->profile_img && !empty($check->profile_img))?base_url('uploads/profile/').$check->profile_img:"";
                       $responce['profile_img_thumb']  = ($check->profile_img && !empty($check->profile_img))?base_url('uploads/profile/thumb/').$check->profile_img:"";
                     

          	  	if($check->status == '1')
          	  	{
          	  	
          	          $res = array('status'=>'200','message'=>'Success','record'=>$responce);    	
          	  	}
          	  	else
          	  	{
          	  		$responce['email']        = $check->email;
                    $responce['country_code'] = $check->country_code;
                    $responce['contact']      = $check->phone;
                    $responce['otp_type']     = '1';
                     
           
      	            $res = array('status'=>'203','message'=>'First verify your email than try again','record'=>$responce);

          	  	}
          	  	  $payload=base64_encode(json_encode(array('user_id'=>$check->id)));
	                 $token = $this->GetToken($payload);
	                  $this->addToken($token);
	                 header('authtoken:'.$token);
          	  }
          	  else
          	  {
          	    $res = array('status'=>'400','message'=>'Password mismatch');
          	  }
               
            }
            else
	        {
	            $res = array('status'=>'404','message'=>'User detail not found'); 
	        }
		  $this->response($res);

		}

			        
	
		function SocialLogin()
		{
            $pera = $this->PerameterValidation(array('first_name','last_name', 'fb_id', 'profile_img',  'email','country_code','country','contact','password','user_type','fcm_token','device_id','app_version','os_type','os_version','device_name','device_modal'));
		    
		    $data = $this->emptyValidation(array('fb_id'));

            $where = "users.fb_id='".$pera['fb_id']."' OR  users.email='".$pera['email']."' OR (users.phone='".$pera['contact']."' AND users.country_code='".$pera['country_code']."' ) ";
            $check = $this->User->SignUpData($where);
            $otp_type = '1';
            $otp = rand(100000,999999);

            // print_r($check);die();
            if($check)
            {
            	if($check->status == '1')
            	{
	            	if($check->device_id == $pera['device_id'])
	            	{
	            		if($check->fb_id != $pera['fb_id'])
	            		{
	                     $update['fb_id']  = $pera['fb_id'];
	            		}

	                    $responce['id']           = $check->id;
	                    $responce['full_name']    = $check->full_name;
	                    $responce['first_name']    = $check->first_name;
	                    $responce['last_name']    = $check->last_name;
	                    $responce['display_name'] = $check->display_name;
	                    $responce['email']        = $check->email;
	                    $responce['country_code'] = $check->country_code;
	                    $responce['phone']        = $check->phone;
	                    $responce['user_type']    = $check->user_type;
	                    $responce['profile_img']  = ($check->profile_img && !empty($check->profile_img))?base_url('uploads/profile/').$check->profile_img:"";
	                    $responce['profile_img_thumb']  = ($check->profile_img && !empty($check->profile_img))?base_url('uploads/profile/thumb/').$check->profile_img:"";


		            	 $update['last_login']   = now;
			   			 $update['last_login_ip']   = $this->input->ip_address();
				         $update['login_type']   = '2';
		            	 $update['status'] = '1';


		            	 $whereUpdate = array('id'=>$check->id);
			             $updateData = $this->User->UpdateData('users',$update,$whereUpdate);
	                     
	                     $payload = base64_encode(json_encode(array('user_id'=>$check->id)));
	                     $token = $this->GetToken($payload);
	                     $this->addToken($token);
	                     header('authtoken:'.$token);



	          	          $res = array('status'=>'200','message'=>'Success','record'=>$responce);

	            	}
	            	else
	            	{
	          	          $res = array('status'=>'205','message'=>'Another device login');
	            	}
            	}
            	else
            	{

        		    $responce['email']        = $check->email;
                    $responce['country_code'] = $check->country_code;
                    $responce['contact']      = $check->phone;
                    $responce['otp_type']     = '1';
                     
                     $payload = base64_encode(json_encode(array('user_id'=>$check->id)));
                     $token = $this->GetToken($payload);
                     $this->addToken($token);
                     header('authtoken:'.$token);

      	            $res = array('status'=>'203','message'=>'First verify your email than try again','record'=>$responce);
            	}

              

            }
            else
            {
            $profile_img = ($pera['profile_img'] && !empty($pera['profile_img']))?$this->UploadImageByUrl($pera['profile_img']):"";
               if($pera['email'] =='' || ($pera['contact'] =='' && $pera['country_code'] ==''))
               {
	             $res = array('status'=>'204','message'=>'Add mandatory field.','record'=>$pera);
		         $this->response($res);
               }
               

               $responce  = array('otp_type'=>$otp_type, 'email'=>$pera['email'], 'country_code'=>$pera['country_code'],'contact'=>$pera['contact']);


			    $insert['first_name']    = $pera['first_name'];
			    $insert['last_name']     = $pera['last_name'];
			    $insert['full_name']     = trim($pera['first_name'].' '.$pera['last_name']);
			    $insert['fb_id']         = $pera['fb_id'];
          	    $insert['email']         = $pera['email'];
			    $insert['country_code']  = $pera['country_code'];
				$insert['country']       = $pera['country'];
			    
			    $insert['phone']         = $pera['contact'];
			    $insert['password']      = "";
			    $insert['profile_img']   =  $profile_img;// profile  image
			    $insert['user_type']     = $pera['user_type'];
			    $insert['otp']           = $otp;
			    $insert['otp_type']      = $otp_type;
			    $insert['otp_gen_time']  = now;

			    $insert['added_on']      = now;
			    $insert['signup_type']   = '2';
			    // $insert['last_login']   = now;
			    // $insert['last_login_ip']   = $this->input->ip_address();
			    $insert['login_type']   = '2';
	            // $insert['status'] = '1';


         
            	$user_id = $this->User->AddData('users',$insert);
            	// $insert = array();
            	$insert2['user_id']       = $user_id;
			    $insert2['os_type']       = $pera['os_type'];
			    $insert2['os_version']    = $pera['os_version'];
			    $insert2['device_name']   = $pera['device_name'];
			    $insert2['device_modal']  = $pera['device_modal'];
			    $insert2['fcm_token']     = $pera['fcm_token'];
			    $insert2['device_id']     = $pera['device_id'];
            	
            	$query  = $this->User->AddData('device_info',$insert2);
                if($query)
                {
                

	               // Add Default plans section start 
			           
			           	 $plans  = $this->User->GetData('subscription','*',array('amount'=>'0',"status"=>'1'));
			           	 if($plans)
			           	 {  
			           	 	$i = 0;
			           	 	$insert = $arr = array();
			           	 	foreach($plans as $defaultPlan)
			           	 	{
                                $arr['subscription_status'] = ($i==0)?'1':'3';
			           	 		$arr['user_id']             = $user_id;
				            	$arr['txn_id']              = 'default';
				            	$arr['subscrition_id']      = $defaultPlan['id'];
				            	$arr['subscription_date']   = now;
				            	$arr['expire_date']         = strtotime(date("d-m-Y H:i:s").'+'.$defaultPlan['duration'].' days');
				            	$arr['can_add_contact']     = $defaultPlan['can_add_contact'];
				            	$arr['can_add_post']        = $defaultPlan['can_add_post'];
				            	$arr['can_share_post']      = $defaultPlan['can_share_post'];
				            	$arr['added_contact']       = 0;
				            	$arr['added_post']          = 0;
				            	$arr['shared_post']         = 0;
				            	$arr['added_on']            = now;
				            	$insert[] =$arr; 
                             $i++;
			           	 	}
			           	 	$this->User->AddMultiple('user_subscription',$insert);
			           	 }
			           
			           // Add Default plans section start 

	               
	             // $res = array('status'=>'200','message'=>'Success','record'=>$responce);
	              $payload = base64_encode(json_encode(array('user_id'=>$user_id)));
                 $token = $this->GetToken($payload);
                 $this->addToken($token);
                 header('authtoken:'.$token);
                  
                  $body = " Hello ".$pera['first_name'].' '.$pera['last_name'].', <br> Your sign up Otp is '.$otp;
		             $mail = Send_Otp($body,$responce['email'],$pera['first_name'].' '.$pera['last_name']);
		             $res = array('status'=>'203','message'=>$mail,'record'=>$responce); 


                }
                else
                {
	               $res = array('status'=>'400','message'=>'Somthing went wrong'); 
                }

            }

		   $this->response($res);

		}
		 function ForgotPassword()
    {
          $pera = $this->PerameterValidation(array('email'));
          $data = $this->emptyValidation(array('email'));

      $where = "email = '".$pera['email']."' ";
       $check = $this->User->RowData('users','id,full_name,email',$where);

          // $check = $this->User->RowData($where);
          if($check)
          {
            $this->load->helper('string');
           $link  =  random_string('alnum',20);

             $link = $link.$check->id;
               $update['forgot_pass_link']   = $link;
               $update['update_on']          = now;

               $whereUpdate = array('id'=>$check->id);
               $updateData = $this->User->UpdateData('users',$update,$whereUpdate);
               $reset_url = site_url('home/reset/'. $link);
               if($updateData)
               {
                   $payload=base64_encode(json_encode(array('user_id'=>$check->id)));
                   $token = $this->GetToken($payload);
                   $this->addToken($token);

                   header('authtoken:'.$token);

                     $body = " Hello ".', <br> click to below link for reset your password <br> <a href="'.$reset_url.'"><button>Link</button></a>';
                 $mail = Send_Otp($body,$pera['email']);
                 $res = array('status'=>'200','message'=>$mail); 
                 
               }
               else
               {
                  $res = array('status'=>'400','message'=>'Try again'); 
               }

          }
          else
          {
           $res = array('status'=>'404','message'=>'Username not found'); 
          }
      $this->response($res);


    }

		function ChangePassword()
		{
			$pera = $this->PerameterValidation(array('user_id','new_password','old_password'));
		    $data = $this->emptyValidation(array('user_id','new_password'));

              $where = " users.id = '".$pera['user_id']."' ";
              $check = $this->User->SignUpData($where);
              if($check)
              {
              	 if($pera['old_password'] !="")
              	 {
                    if($check->password != md5($pera['old_password']))
                    {
	                  $res = array('status'=>'400','message'=>'Old password mismatch.'); 
		              $this->response($res);
                    }     
              	 }

              	 if($pera['old_password'] == '' && ($check->otp !='' || $check->otp_type !='0'))
              	 {
              	 	$res = array('status'=>'400','message'=>'First verify the otp.'); 
		            $this->response($res);
              	 }

                 $update['password']   = md5($pera['new_password']);
            	 $whereUpdate = array('id'=>$check->id);
	             $updateData = $this->User->UpdateData('users',$update,$whereUpdate);
	             if($updateData)
	             {
	             $res = array('status'=>'200','message'=>'Success','record'=>$check); 
	             }
	             else
	             {

	             $res = array('status'=>'400','message'=>'Try again'); 
	             }


              }
              else
              {
	           $res = array('status'=>'404','message'=>'User detail not found'); 
              }
		       $this->response($res);
		  


		}

		function ProfileUpdate()
		{
			$user_id   = $this->input->post('user_id');
			$old_image = $this->input->post('old_img');
			$first_name = $this->input->post('first_name');
			$last_name = $this->input->post('last_name');

            $profile_img      = $this->file_upload($old_image);
             if($profile_img != "")
             {
              $update['profile_img']  = $profile_img;
             }
             $update['first_name']   = $first_name;
             $update['last_name']    = $last_name;
             $update['full_name']    = $first_name.' '.$last_name;
             $update['update_on']    = now;


             $whereUpdate = array('id'=>$user_id);
	         $updateData = $this->User->UpdateData('users',$update,$whereUpdate);
	         if($updateData)
	         {
	         	 $responce['first_name']   = $first_name;
	             $responce['last_name']    = $last_name;
	             $responce['full_name']    = $first_name.' '.$last_name;

	         	$responce['profile_img']  = ($profile_img && !empty($profile_img))?base_url('uploads/profile/').$profile_img:"";
	            $responce['profile_img_thumb'] = ($profile_img && !empty($profile_img))?base_url('uploads/profile/thumb/').$profile_img:"";

	        	$res = array('status'=>'200','message'=>'Success','record'=> $responce);
	         }
	         else
	         {
	        	$res = array('status'=>'400','message'=>'Please Try again','record'=>array('profile_img'=>$old_image));

	         }
	            $this->response($res);
		}

		function file_upload($old_img='')
       {
	        if(!count($_FILES))
	        {
	            return "";
	        } 
	        $path = "./uploads/profile/";
                $config['upload_path']          = $path;
                $config['allowed_types']        = 'gif|jpg|png|jpeg|webp';
                $config['max_size']             = 10024;
                $config['max_width']            = 10024;
                $config['max_height']           = 10024;
                $this->load->library('upload', $config);

	            $error ='';
	               if ( ! $this->upload->do_upload('file'))
	                  {
	                     $error = $this->upload->display_errors();  
	                  }
	                  else
	                  {
	                      $fileData             = $this->upload->data();
	                      $config1 = array(
	                        'source_image' => $fileData['full_path'],
	                        'new_image' => $path.'thumb/',
	                        'quality' => '100%', 
	                        'maintain_ratio' => true,
	                        'width' => 125,
	                        'height' => 125);
	                $this->load->library('image_lib', $config1);
	                $this->image_lib->resize(); 
	        }
	        
	        if($error !='')
	        {
	         $res = array('status'=>'400','message'=>'File upload error.','error'=>$error);
	         $this->response($res);
	         return false;
	        }
	        if($old_img !='')
	        {
             $img  =  explode('/', $old_img);
             if(file_exists($path.end($img)))
             {
	         unlink($path.end($img));
             }
             if(file_exists($path.'thumb/'.end($img)))
             {
	         unlink($path.'thumb/'.end($img));
             }
	        }

	        return $fileData['file_name'];
        }


		function UploadImageByUrl($url,$type='profile')
		{
			  $path = "uploads/profile/";
			  $filename = now.rand(10000,9999999).'_'.$type.'.jpg';
		      $data = file_get_contents($url);
              $upload =file_put_contents($path.$filename, $data);            
            //create thumbnail
            $image = ImageCreateFromString($data);
		    $height = true;
		    $width  = 32;
		    $height = $height === true ? (ImageSY($image) * $width / ImageSX($image)) : $height;

       // create image 
	      $output = ImageCreateTrueColor($width, $height);
	      ImageCopyResampled($output, $image, 0, 0, 0, 0, $width, $height, ImageSX($image), ImageSY($image));

        // save image
           $thumb =  ImageJPEG($output, 'uploads/profile/thumb/'.$filename, 95); 
           if($upload && $thumb)
           {
           	return $filename;
           }
           return ""; 
		}


		function feedBack()
		{
			 $pera = $this->PerameterValidation(array('user_id','comment','subject'));
		     $data = $this->emptyValidation(array('user_id','comment','subject'));


			    $insert['user_id']     = $pera['user_id'];
			    $insert['subject']     = $pera['subject'];
			    $insert['comment']     = $pera['comment'];
			    $insert['added_on']      = now;
         
            	$query = $this->User->AddData('feedback',$insert);
            
            if($query)
            {
	            $res = array('status'=>'200','message'=>'Success'); 
            }
            else
	        {
	            $res = array('status'=>'404','message'=>'User detail not found'); 
	        }
		  $this->response($res);
		}


	}
?>
