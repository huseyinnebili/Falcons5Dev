trigger UpdateCaseFieldRespectToAccount on Account (after update) {

    Map<Id,Account>accMap=new Map<Id,Account>();
    
        for(Account acc:Trigger.new){
            
            if(Trigger.oldMap!=null){
                
                if(acc.Description!=Trigger.oldMap.get(acc.id).Description){
                    
                    accMap.put(acc.Id,acc);
                }
            }
        }
    
    List<Contact>returnedContacts=[Select LastName,LeadSource,Id,AccountId,Account.Description,Description from Contact where AccountId in:accMap.keySet()];
    List<Contact>updateContacts=new List<Contact>();
    Map<Id,Contact>mapContact=new Map<Id,Contact>();
    
    for(Contact conn:returnedContacts){
        
        if(accMap.containsKey(conn.AccountId)){
            
            if(conn.LeadSource=='Web'){
                
                conn.Description=accMap.get(conn.AccountId).Description;
                
                updateContacts.add(conn);
            }
        }
    }
    
    mapContact.putAll(updateContacts);
    
    if(mapContact.size()>0){
        
        update mapContact.values();
    }
}