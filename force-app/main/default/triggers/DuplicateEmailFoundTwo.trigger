trigger DuplicateEmailFoundTwo on Contact (before insert,before update) {
    
    Map<String,Contact>mapContact=new Map<String,Contact>();
    
           
    for(Contact conn:Trigger.new){
        
        if(conn.Email!=null) {
           
           if (Trigger.old==null ||conn.Email!=Trigger.oldMap.get(conn.Id).Email){
            
            if(!mapContact.containsKey(conn.Email)){
                
                 mapContact.put(conn.Email,conn);

                
            }else{
                conn.Email.addError('Another new Contact has the same email address!');
                           }
        }
      }
   
    }
    
    List<Contact>listOfContact=[Select id,Email from Contact where Email in:mapContact.keySet()];
    
    if(!listOfContact.isEmpty()){
        
        for(Contact con:listOfContact){
            
          Contact newCon = mapContact.get(con.Email);
        
         newCon.Email.addError('A Contact with this email address already exists');
        }
    
    
       }
   
       
    }