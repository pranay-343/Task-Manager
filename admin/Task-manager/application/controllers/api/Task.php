<?php

defined('BASEPATH') OR exit('No direct script access allowed');
 require APPPATH . 'core/Rest_Controller.php';
 
	class Task extends Rest_Controller
	{
		function __construct()
		{
			parent::__construct();
		    $this->load->model('api/TaskModel', 'Task');   		    
		}
		function index()
		{
           $pera = $this->PerameterValidation(array('user_id'));
          
		  $responce  = $this->Task->List($pera['user_id']);
		   if( $responce){
		   $res = array('status'=>'200','record'=>$responce);
		}else{
			   $res = array('status'=>'404','message'=>'No detail found');
		}
		  $this->response($res);
		}

		function tracker_list()
		{
           $pera = $this->PerameterValidation(array('task_id'));
          
		  $responce  = $this->Task->traker_List($pera['task_id']);
		   if( $responce){ 
		   $res = array('status'=>'200','record'=>$responce);
		}else{
			   $res = array('status'=>'404','message'=>'No detail found');
		}
		  $this->response($res);
		}
		Function Detail()
		{
			$pera = $this->PerameterValidation(array('task_id','page_no'));
		    $data = $this->emptyValidation(array('task_id'));
            $task_id = $pera['task_id'];
            $page_no = ($pera['page_no'])?$pera['page_no']:1;
           
          $Task = $this->Task->TaskDetail($task_id);
          if($Task)
          {
          	// if($pera['page_no'] == '0' || $pera['page_no'] == '')
          	// {
           //   $this->Task->UpdateCount($pera['task_id'],'total_click');
          	// }

             $Task->profile_img  = (!$Task->profile_img && !empty($Task->profile_img))?$Task->profile_img:default_img;
             $Comment =  $this->Task->GetCommnet($task_id,$page_no);
                
                $all_comments = array();
                foreach($Comment['comments'] as $comments)
                {
                	$arr['id']                 = $comments['id'];
                	$arr['comment_by']         = $comments['comment_by'];
                	$arr['comment_by_name']    = $comments['comment_by_name'];
                	$arr['comment_by_profile'] = ($comments['comment_by_profile'] && !empty($comments['comment_by_profile']))?base_url('uploads/profile/').$comments['comment_by_profile']:default_img;
                	$arr['comment_by_profile_thumb'] = ($comments['comment_by_profile'] && !empty($comments['comment_by_profile']))?base_url('uploads/profile/thumb/').$comments['comment_by_profile']:default_img;
                
                	$arr['comment_to']            = $comments['comment_to'];
                	$arr['comment_to_name']       = $comments['comment_to_name'];
                	$arr['comment']            = $comments['comment'];
                	$arr['comment_on']         =  $comments['added_on'];
          

                  $all_comments[] = $arr;
                }

                $responce['img_url'] =  base_url('uploads/posts/');
                $responce['thumb_url'] =  base_url('uploads/posts/thumb/');
            	$responce['task_detail'] =  $Task; 
            	$responce['all_comments'] = $all_comments; 
            	$responce['pagination'] = $Comment['pagination']; 
            	// $responce['query'] = $Comment['query']; 
               

             $res = array('status'=>'200','message'=>'Success','record'=>$responce);
          }
          else
          {
             $res = array('status'=>'404','message'=>'No detail found');

          }
		     $this->response($res);

		}


		
		function AddComment()
		{
			 $pera = $this->PerameterValidation(array('user_id','task_id','comment','comment_to'));
			 $data = $this->emptyValidation(array('user_id','task_id','comment','comment_to'));
			    
			         $insert  = array();
				     $insert['task_id']          = $pera['task_id']; 
				     $insert['comment_by']       = $pera['user_id']; 
				     $insert['comment']          = $pera['comment']; 
				     $insert['added_on']         = now;
				     $insert['update_on']         = now;
				     $insert['comment_to']      = $pera['comment_to']; 
				     $insert['ip']               = $this->input->ip_address();
	                 
	                 $comment_id = $this->Task->AddData('comments',$insert);

	                 if($comment_id)
	                 {
	                 	$this->Task->UpdateCount($pera['task_id']);
	                   $res=array('status'=>'200','message'=>"Success","record"=>array('task_id'=>$pera['task_id'],'comment_id'=>$comment_id));
	                 }
	                 else
	                 {
	                  $res=array('status'=>'400','message'=>"Unable to save comment.Try again");
	                 }
			 $this->response($res);

		}
         
         function  task_tracker()
		{
			 $pera = $this->PerameterValidation(array('task_id','user_lat','user_long','user_id'));
			 $data = $this->emptyValidation(array('task_id','user_lat','user_long','user_id'));
			    //  `task_id`, `user_lat`, `user_long`, `added_on
			         $insert  = array();
			         $insert['user_id']          = $pera['user_id']; 
				     $insert['task_id']          = $pera['task_id']; 
				     $insert['user_lat']       = $pera['user_lat']; 
				     $insert['user_long']          = $pera['user_long']; 
				     $insert['added_on']         = now;
				 
	                 $tracker_id = $this->Task->AddData('task_tracker',$insert);

	                 if($tracker_id)
	                 {
	                 
	                   $res=array('status'=>'200','message'=>"Success","record"=>array('task_id'=>$pera['task_id'],'tracker_id'=>$tracker_id));
	                 }
	                 else
	                 {
	                  $res=array('status'=>'400','message'=>"Unable to save Task Tracker.Try again");
	                 }
			 $this->response($res);

		}
         function updateTaskStatus()
		{
			 $pera = $this->PerameterValidation(array('user_id','task_id','comment','comment_to'));
			 $data = $this->emptyValidation(array('user_id','task_id','comment','comment_to'));
			    
			         $insert  = array();
				     $insert['task_id']          = $pera['task_id']; 
				     $insert['comment_by']       = $pera['user_id']; 
				     $insert['comment']          = $pera['comment']; 
				     $insert['added_on']         = now;
				      $insert['update_on']         = now;
				       $insert['comment_to']      = $pera['comment_to']; 
				     $insert['ip']               = $this->input->ip_address();
	                 
	                 $comment_id = $this->Task->AddData('comments',$insert);

	                 if($comment_id)
	                 {
	                 	$this->Task->UpdateCount($pera['task_id']);
	                   $res=array('status'=>'200','message'=>"Success","record"=>array('task_id'=>$pera['task_id'],'comment_id'=>$comment_id));
	                 }
	                 else
	                 {
	                  $res=array('status'=>'400','message'=>"Unable to save comment.Try again");
	                 }
			 $this->response($res);

		}

		 function check_in()
		{
			 $pera = $this->PerameterValidation(array('user_id','check_in_date','in_time','task_id'));
			 $data = $this->emptyValidation(array('user_id','check_in_date','in_time','task_id'));
			  // `user_id`, `check_in_date`, `in_time`, `out_time`, `status`, `added_on`, `task_id

			         $insert  = array();
				    // $insert['task_id']          = $pera['task_id']; 
				     $insert['taskby_user_id']          = $pera['user_id']; 
				     $insert['check_in_date']    = $pera['check_in_date']; 
				     $insert['in_time']          = $pera['in_time']; 
				     $insert['status']           = 1; 
				     $insert['added_on']         = now;
				  
	               //  $cid = $this->Task->AddData('check_in_out',$insert);
                   $tid = $this->Task->updateData('task',$insert,array('id' =>$pera['task_id'])); 
	                 if($tid)
	                 {
	             
	                   $res=array('status'=>'200','message'=>"Success","record"=>array('task_id'=>$pera['task_id'],'checkin_id'=>$tid));
	                 }
	                 else
	                 {
	                  $res=array('status'=>'400','message'=>"Unable to save Check In.Try again");
	                 }
			 $this->response($res);

		}
        function check_out()
		{
			 $pera = $this->PerameterValidation(array('status','user_id','check_out_date','out_time','checkin_id','task_id'));
			 $data = $this->emptyValidation(array('status','user_id','check_out_date','out_time','checkin_id','task_id'));
			  // `user_id`, `check_in_date`, `in_time`, `out_time`, `status`, `added_on`, `task_id
			         $insert  = array(); 
				    // $insert['task_id']          = $pera['task_id']; 
				     $insert['taskby_user_id']          = $pera['user_id']; 
				     $insert['check_out_date']    = $pera['check_out_date']; 
				     $insert['out_time']         = $pera['out_time']; 
				     $insert['status']          =$pera['status']; 
				     $where_arr= array('id' =>$pera['task_id']);
	                 $cid = $this->Task->updateData('task',$insert,$where_arr);
                      

				     $where_arr= array('id' =>$pera['checkin_id']);
	                 $tid = $this->Task->updateData('task',array('status'=>$pera['status']),array('id' =>$pera['task_id'])); 
	                 if($cid)
	                 {
	                 
	                   $res=array('status'=>'200','message'=>"Success","record"=>array('task_id'=>$pera['task_id']));
	                 }
	                 else
	                 {
	                  $res=array('status'=>'400','message'=>"Unable to save comment.Try again");
	                 }
			 $this->response($res);

		}



	}
?>