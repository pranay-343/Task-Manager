<?php
  class CommanModal extends CI_Model
  {
  	function AddData($table,$data)
 	{
 		$this->db->insert($table, $data);
	    $q = $this->db->insert_id();
	    return $q;
 	}

    function AddMultiple($table,$data)
    {
      $this->db->insert_batch($table, $data);
        $q = $this->db->insert_id();
        return $q;
    }

 	function updateData($table,$set,$where)
    {
         return $this->db->update($table,$set,$where);
    }
    function DeleteData($table,$where)
    {
         return $this->db->delete($table,$where);
    }

    function GetData($table,$coloum,$where)
    {
      $this->db->select($coloum);
      $this->db->from($table);
      if($where && !empty($where))
      {
      $this->db->where($where);
      }
      $q = $this->db->get();
      // return $this->db->last_query();
      if($q->num_rows())
      {
        return $q->result_array();
      }
      return false;
    }

      function RowData($table,$coloum,$where)
      {
        $this->db->select($coloum);
        $this->db->from($table);
        $this->db->where($where);
        $q = $this->db->get();
        // return $this->db->last_query();
        if($q->num_rows())
        {
          return $q->row();
        }
        return false;
      }

      function NumRows($table,$where)
      {
        $this->db->select("id");
        $this->db->from($table);
        $this->db->where($where);
        $q = $this->db->get();
        // return $this->db->last_query();
        if($q->num_rows())
        {
          return $q->num_rows();
        }
        return false;
      }
      
    function JoinTable($table,$coloum='*',$where,$joinTable,$join_condition,$page_no='',$order_by='',$order='DESC')
    {
             $this->db->select($coloum);
             $this->db->from($table);
             if($where && !empty($where))
             {
              $this->db->where($where);
             }
             if(($joinTable && !empty($joinTable)) && ($join_condition && !empty($join_condition)))
             {
              $this->db->join($joinTable,$join_condition);
             }

              if($order_by !='')
              {
               $this->db->order_by($order_by,$order);
              }
             
             if($page_no !='')
             {
               $perpage = 20;
               $offset    = (intval($page_no)*intval($perpage))-intval($perpage);
               if($offset<=0)
               {
                $offset = 0;
               }
                $this->db->limit($perpage,$offset);

                $query =  $this->db->get();

                $data['record'] =  $query->result_array();
                $PageCount           = $this->PageCount(explode('LIMIT', $this->db->last_query())[0],$perpage);
                
                $arr['pageCount']   = intval($PageCount); 
                $arr['currentPage'] = intval($page_no);
                $arr['per_page']    = intval($perpage);
                $data['pagination'] = $arr;
                return $data;
             }

               return $this->db->get()->result_array();
             return $this->db->last_query();
             
    }

    function Pagination($table, $coloum='*',$where,$page_no='1',$order_by='id',$order='DESC')
    {
        $perpage = 20;
        $offset    = (intval($page_no)*intval($perpage))-intval($perpage);
           if($offset<=0)
           {
            $offset = 0;
           }
          $this->db->select($coloum);
          $this->db->from($table);
          $this->db->where($where);
          $this->db->order_by($order_by,$order);
          $this->db->limit($perpage,$offset);
          $query  = $this->db->get();
                 
          $data['record'] =  $query->result_array();
          $PageCount           = $this->PageCount(explode('LIMIT', $this->db->last_query())[0],$perpage);
          
          $arr['pageCount']   = intval($PageCount); 
          $arr['currentPage'] = intval($page_no);
          $arr['per_page']    = intval($perpage);
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

  }
?>