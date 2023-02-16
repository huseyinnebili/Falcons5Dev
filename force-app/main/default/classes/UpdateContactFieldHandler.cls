public class UpdateContactFieldHandler {

    public static void updateContactField(List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerOldMap,
    Map<Id, Account> accountTriggerNewMap){
        
    
    Set<Id>setIDs=new Set<Id>();
    
    for(Account acc:accountTriggerNew){
        
        if(accountTriggerOld==null && acc.Rating=='Hot'){
            
            setIDs.add(acc.id);
        }
        
        if(accountTriggerOld!=null && acc.Name!=accountTriggerOldMap.get(acc.id).Name){
            
            if(acc.Rating=='Hot'){
                
                setIDs.add(acc.Id);
            }
        }
    }
    
    if(!setIDs.isEmpty()){
    
        updateContactFieldRegardingToAccount(setIDs);
    }
    }
    

    @future
    
    public static void updateContactFieldRegardingToAccount(Set<Id>setIDs){
        
        List<Contact>updateContacs=new List<Contact>();
        
        List<Contact>listOfContact=[Select Id,AccountId,Account.Description,Description from Contact where AccountId in:setIDs];
        
        for(Contact conn:listOfContact){
            
            if(conn.Description==null){
                
                conn.Description=conn.Account.Description;
                
                updateContacs.add(conn);
            }
        }
        
        update updateContacs;
    }

}