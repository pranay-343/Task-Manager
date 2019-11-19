<?php 
	class RestModal extends CI_Model
	{     
	    
	    function  AddToken($data)
		{
			$this->db->insert('auth', $data);
	        $q = $this->db->insert_id();
	        return $q;
		}

		function updateToken($data,$where)
	    {
	          return $this->db->update('auth',$data,$where);
	    }

	    function  deleteToken($where)
	    {
	         return $this->db->delete('auth',$where);
	    }
	    function checkToken($token)
	    {
	        $q = $this->db->get_where('auth',$token);
	        $check = $q->num_rows();
	        if($check>0)
	        {
	        	return $q->result_array()[0];
	        }
	        return false;
	    }
	    function checkUserToken($where)
	    {
	    	 $q = $this->db->get_where('auth',$where);
	        $check = $q->num_rows();
	        if($check>0)
	        {
	        	return $q->row();
	        }
	        return false;
	    }

    }
?>