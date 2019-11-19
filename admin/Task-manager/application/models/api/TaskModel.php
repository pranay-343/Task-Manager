<?php
   require_once "CommanModal.php";
  class TaskModel extends CommanModal
  {
  	   var $coloum   = '`id`, `task_by`, `task_titile`, `task_category`, `description`, `images`, `special_note`, `assign_to`, `start_date`, `start_time`, `status`, `priority`';

	    function List($User_id)
	    { 
       
	    	$this->db->select($this->coloum);
	    	$this->db->from('task');
	    	$this->db->where(array('assign_to'=>$User_id));
        $this->db->order_by('task_titile','ASC');

	    	$q  = $this->db->get();
            if($q->num_rows() >0)
            {
              return $q->result_array();
            }
             return array(); 
	    } 
	    
        function traker_List($task_id)
      { 
       
        $this->db->select("task_tracker.*,users.full_name 'user_name',users.profile_img 'user_profile_img'");
        $this->db->from('task_tracker');
         $this->db->join('users'," task_tracker.user_id = users.id");
        $this->db->where(array('task_id'=>$task_id));
        $this->db->order_by('id','asc');

        $q  = $this->db->get();
            if($q->num_rows() >0)
            {
              return $q->result_array();
            }
             return array(); 
      } 
      
	     function TaskDetail1($post_id)
      {
        $this->db->select($this->coloum);
        $this->db->from('task');
        $this->db->where(array('task.id'=>$post_id));
        $query  = $this->db->get();
        if($query->num_rows() >0)
        { 
          return $query->row();
        }
        return false;

      }
	    function categoryList($store_id='0',$category_type='1')
	    {
            $this->db->select("id,category_name,store_id");
	    	$this->db->from('category');
	    	$this->db->where(array('status'=>'1','store_id'=>$store_id,'category_type'=>$category_type));
        $this->db->order_by('category_name','ASC');
	    	
        $q  = $this->db->get();
            if($q->num_rows() >0)
            {
              return $q->result_array();
            }
             return array(); 
	    }

      function Posts($where,$page_no='0',$perpage='20')
      {
         $offset    = (intval($page_no)*intval($perpage))-intval($perpage);
         if($offset<=0)
         {
          $offset = 0;
         }
        $this->db->select("post.id 'post_id' ,post.added_on,post.post_in_group 'post_type',post.post_by,post.product_name,post.price,post.image_type,post.image,post.store_name,post.store_id,post.category_id,post.score,post.rating,post.total_view,post.total_click,post.total_comment,post.story_expire,users.full_name 'post_by_name',users.profile_img 'post_by_profile',store.store_logo ");
        $this->db->from('post');
        $this->db->join('users'," post.post_by = users.id");
        $this->db->join('store'," post.store_id = store.id ","left");
        $this->db->where($where);
        $this->db->order_by('post.id','DESC');
        $this->db->limit($perpage,$offset);
        $query  = $this->db->get();
        // return $this->db->last_query();
        
            $data['posts'] =  $query->result_array();
            $PageCount           = $this->PageCount(explode('LIMIT', $this->db->last_query())[0],$perpage);
            
            $arr['pageCount']   = intval($PageCount); 
            // $arr['query']   = $this->db->last_query(); 
            $arr['currentPage'] = intval($page_no);
            $arr['per_page']    = intval($perpage);
            $data['pagination'] = $arr;
            return $data;

      }

      function TaskDetail($task_id)
      {
        $this->db->select("task.*, users.full_name, users.profile_img");
        $this->db->from('task');
        $this->db->join('users'," task.task_by = users.id");
        $this->db->where(array('task.id'=>$task_id));
        $query  = $this->db->get();
        if($query->num_rows() >0)
        {
          return $query->row();
        }
        return false;

      }

      function GetCommnet($task_id,$page_no='0',$perpage='20')
      {
         $offset    = (intval($page_no)*intval($perpage))-intval($perpage);
         if($offset<=0)
         {
          $offset = 0;
         }

        $this->db->select("comments.*,uby.full_name 'comment_by_name', uby.profile_img 'comment_by_profile',uto.full_name 'comment_to_name', uto.profile_img 'comment_to_profile' ");

        $this->db->from('comments');
        $this->db->join('users as uby'," comments.comment_by = uby.id");
        $this->db->join('users as uto'," comments.comment_by = uto.id");
        
        $this->db->where(array('comments.task_id'=>$task_id));

          $this->db->order_by('comments.id','DESC');

          $this->db->limit($perpage,$offset);

          $query  = $this->db->get();
           
          $PageCount           = $this->PageCount(explode('LIMIT', $this->db->last_query())[0],$perpage);
          
          // $data['query']   = $this->db->last_query(); 
          $arr['pageCount']   = intval($PageCount); 
          $arr['currentPage'] = intval($page_no);
          $arr['per_page']    = intval($perpage);
          $data['comments'] =  $query->result_array();
          $data['pagination'] = $arr;
          return $data;
      }

     function PageCount($query,$perpage='20')
     {
       $q = $this->db->query($query);
        
        $num_row =  $q->num_rows();
        $pageCount = $num_row/$perpage;
        if(strpos($pageCount,'.'))
        {
          $pageCount = floor($pageCount)+1;
        }
        return $pageCount;
        // $this->PageCount(explode('LIMIT', $this->db->last_query())[0],$perpage);
     }

      function UpdateCount($task_id,$coloum='total_comment')
      {
          $this->db->set($coloum, $coloum.'+ 1',false);
          $this->db->where(array('id'=>$task_id));   
          return $q = $this->db->update('task');
      }
	    

  }
?>