<?php 
    require_once "CommanModal.php";
	class UserModel extends CommanModal
	{     
    	

	 	function SignUpData($where)
	    {
	      $this->db->select('device_info.device_id, device_info.fcm_token, users.*');
	      $this->db->from('users');
	      $this->db->join('device_info','users.id=device_info.user_id','left');
	      $this->db->where($where);
	      $query  = $this->db->get();
	      // return $this->db->last_query();
	      if($query->num_rows()>0)
	      {
	        return $query->row();
	      }
	      return false;
	    }

	 	function map($task_id) {
	     $this->db->limit(23);
         $query = $this->db->get_where('task_tracker', array('task_id' => $task_id));
           
         if($query->num_rows()>0)
	      {
	        return $query->result_array();
	      }
	      return false;
	    }
	    function comment($task_id) {

	      $this->db->select('c.*,uby.full_name as comment_by_name ,uby.profile_img as comment_by_image,uto.full_name as comment_to_name ,uto.profile_img as comment_to_image');
	      $this->db->from('comments as c');
	      $this->db->join('users as uby','uby.id=c.comment_by','left');
	      $this->db->join('users as uto','uto.id=c.comment_to','left');

	      $this->db->where(array('c.task_id'=>$task_id,));
          $query  = $this->db->get();

         if($query->num_rows()>0)
	      {
	        return $query->result_array();
	      }
	       return false;
	    }
	     function UpdateCount($task_id,$coloum='total_comment')
      {
          $this->db->set($coloum, $coloum.'+ 1',false);
          $this->db->where(array('id'=>$task_id));   
          return $q = $this->db->update('task');
      }
    }
?>