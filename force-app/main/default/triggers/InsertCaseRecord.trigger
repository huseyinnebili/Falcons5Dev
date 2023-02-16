trigger InsertCaseRecord on Account (after insert) {
      
        for(Account acc:Trigger.new){
        
            if(Trigger.oldMap==null){
                
        Contact conn=new Contact();
        conn.LastName='Test-1';
        conn.LeadSource='Web';
        conn.Phone='2102323212';
        conn.AccountId=acc.Id;
        
        Contact conn1=new Contact();
        conn1.LastName='Test-2';
        conn1.LeadSource='Web';
        conn1.Phone='2102323222';
        conn1.AccountId=acc.Id;
        
        List<Contact>insertToContact=new List<Contact>{conn,conn1};
            
            insert insertToContact;  
            
            }
    }
            
    }