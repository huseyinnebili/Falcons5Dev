trigger FindDuplicateEmail on Contact (before insert,before update) {
    
    Set<String>setEmail=new Set<String>();
  
   List<Contact>listContactsNew=[Select Id,Email, DuplicateFound__c from Contact];
    
    for(Contact con:listContactsNew){
        
        if(con.Email!=null){
            
           setEmail.add(con.Email);
            
        }
    
    }
    
        for(Contact cn:Trigger.new){
         
         if(Trigger.old==null || Trigger.old!=null){
             
        if(setEmail.contains(cn.Email)){
            
          cn.DuplicateFound__c=true;
            
            }
   
         } 
         
    }
}