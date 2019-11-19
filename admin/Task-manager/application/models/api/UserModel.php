<?php 
    require_once "CommanModal.php";
	class UserModel extends CommanModal
	{     
    	

	 	function SignUpData($where)
	    {
	      $this->db->select('users.*');
	      $this->db->from('users');
	      $this->db->where($where);
	      $query  = $this->db->get();
	      // return $this->db->last_query();
	      if($query->num_rows()>0)
	      {
	        return $query->row();
	      }
	      return false;
	    }

	    
	    
    }
?>