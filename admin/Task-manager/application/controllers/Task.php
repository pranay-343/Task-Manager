<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
require_once("CommanControllers.php");

class Task extends CommanControllers {
	    function __construct()
    	{
    		parent:: __construct();
    		$this->load->model('UserModel',"Task");
            $this->checkLogin();
    	}

 
    	function assignTask()
    	{
    		$user = $this->Task->GetData('users','id,full_name,email,profile_img',array("status !="=>'4'));
    		$data['title']    = 'Assign Task';
			$data['contents'] = 'assign-task';
			$data['users']    = ($user)?$user:array();
            // print_r($data);die();
			$this->load->view("theme/template",$data);
    	}
        function List()
     {
            $tasks = $this->Task->GetData("task","*",array());      
            $data['title'] = 'Task List';
            $data['contents'] = 'task-list';
            $data['tasks'] = ($tasks)?$tasks:array();
            $data['message']     = "";
            $this->load->view("theme/template",$data);
     }

     function deletetask($task_id='')
     {
             if($task_id) {
                $update['status']   = $status;
                $update['update_on']   = strtotime(date('d-m-Y H:i:s'));

                $query   = $this->User->DeleteData('task',array('id'=>$task_id));
                if($query)
                {
                    redirect('Task/list');
                }
                else
                {
                    redirect('Task/list');
                }
            }
     }
          
          function edit($task_id)
        {
         
               $user = $this->Task->GetData('users','id,full_name,email,profile_img',array("status !="=>'4',"user_type >"=>'2'));
             $task = $this->Task->RowData('task','*',array("id"=>$task_id));
             // print_r($task);
            $data['title']    = 'Edit Task';
            $data['contents'] = 'assign-task';
            $data['users']    = ($user)?$user:array();
            $data['task']    = ($task)?$task:array();
            $data['task_id']    = $task_id;
           
            $this->load->view("theme/template",$data);
            

        }

        function AddComment()
        {
            
               if($this->input->post()){
                 
           $this->form_validation->set_rules('user_id', 'User id ', 'required');
            $this->form_validation->set_rules('task_id', 'Task id', 'required');
            $this->form_validation->set_rules('comment', 'Comment', 'required');
             $this->form_validation->set_rules('comment_to', 'Comment to', 'required');
                if ($this->form_validation->run() == true)
            {
                     $insert  = array();
                     $insert['task_id']          = $this->input->post('task_id'); 
                     $insert['comment_by']       = $this->input->post('user_id'); 
                     $insert['comment']          = $this->input->post('comment'); 
                     $insert['added_on']         = now;
                     $insert['update_on']         = now;
                     $insert['comment_to']      = $this->input->post('comment_to'); 
                     $insert['ip']               = $this->input->ip_address();
                     
                     $comment_id = $this->Task->AddData('comments',$insert);

                     if($comment_id)
                     {
                        $this->Task->UpdateCount($this->input->post('task_id'));

                       $res=array('status'=>'200',
                        'message'=>"Success",
                        "record"=>array('comment_id'=>$comment_id));
                     }
                     else
                     {
                      $res=array('status'=>'400','message'=>"Unable to save comment.Try again");
                     }
                     }else {
                          $res=array('status'=>'400','message'=> validation_errors());
               
           }
           echo   json_encode($res,true);
         }

        }
    	function addTask()
    	{
           $ses_data =  $this->session->userdata('securelogin');
          
            if($this->input->post()){
             print_r($this->input->post()); die();
    		$this->form_validation->set_rules('title', 'Title', 'required');
			$this->form_validation->set_rules('note', 'Special note', 'required');
			$this->form_validation->set_rules('start_date', 'Start Date', 'required');
			$this->form_validation->set_rules('dead_line_date', 'Dead line date', 'required');
			$this->form_validation->set_rules('description', 'Task Description', 'required');
			$this->form_validation->set_rules('assign_to[]', 'Assign to ', 'required');

			if ($this->form_validation->run() == true)
			{
			

              //   foreach ($this->input->post('assign_to') as $key => $to) {
                  
                     $insert  = array();
                     $insert['task_titile']          =$this->input->post('title');
                     $insert['special_note']       =$this->input->post('note');
                     $insert['start_date']          = strtotime($this->input->post('start_date'));
                     $insert['start_time']      =  strtotime($this->input->post('start_time'));
                     $insert['dead_line_date']      = strtotime($this->input->post('dead_line_date'));
                     $insert['dead_line_time']      = strtotime($this->input->post('dead_line_time'));
                     $insert['description']      = $this->input->post('description');
                      $insert['assign_to']      = implode(",",$this->input->post('assign_to'));
                     $insert['added_on']         = now;
                     $insert['task_by']               =$ses_data['id'];
                     $task_id  =$this->input->post('task_id');
                     if($task_id) {
                          $id   = $this->Task->updateData('task',$insert,array('id'=>$task_id)); 
                         $msg =  'Task update successfully';
                      }else {
                     $id = $this->Task->AddData('task',$insert);
                          $msg =  'Task save successfully';
                 }

                      
                     //  }
                if($id){
               $this->session->set_flashdata('success', $msg );
           }else{
              $this->session->set_flashdata('error', 'Something is wrong.');
          }
           }else {
                 $this->session->set_flashdata('error', 'validaton error');
           }
			}
         

          $user = $this->Task->GetData('users','id,full_name,email,profile_img',array("status !="=>'4',"user_type >"=>'2'));
            $data['title']    = 'Assign Task';
            $data['contents'] = 'assign-task';
            $data['users']    = ($user)?$user:array();
              $data['task_id']    = '';
            $this->load->view("theme/template",$data);
    		

    	}

           function taskDetails($task_id)
     {
           if($task_id ==''){
            redirect('/Task/list');
           }
           $task = $this->Task->RowData('task','*',array("id"=>$task_id)); 
            $comment = $this->Task->comment($task_id);
            $data['title'] = 'Task List';
            $data['contents'] = 'task-details';
            $data['task'] = ($task)?$task:array();
             $data['comment'] = ($comment)?$comment:array();  

            $data['message']     = "";
            $this->load->view("theme/template",$data);
     }


}