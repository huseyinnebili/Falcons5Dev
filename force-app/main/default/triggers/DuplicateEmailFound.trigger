trigger DuplicateEmailFound on Contact (before insert,before update) {
    
    Map<String,Contact>mapContact=new Map<String,Contact>();
    
           
    for(Contact conn:Trigger.new){
        
        if((conn.Email!=null) && (Trigger.old==null ||(conn.Email!=Trigger.oldMap.get(conn.Id).Email))){
            
            if(mapContact.containsKey(conn.Email)){
                
                conn.Email.addError('Another new Contact has the same email address!');
                
            }else{
                
                mapContact.put(conn.Email,conn);
            }
        }
    }
    
  
    
    for(Contact con:[Select id,Email from Contact where Email in:mapContact.keySet()]){
        
        Contact newCon = mapContact.get(con.Email);
        
        newCon.Email.addError('A Contact with this email address already exists');
    }

}