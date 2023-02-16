trigger CountingContactRecords on Contact (after insert, after update, after delete, after undelete) {

//Trigger to count number of contacts associated with an account
 
    set<id>accountIds=new set<id>();
    
    
    if(Trigger.new!=null){
        
        for(Contact con:Trigger.new){
            
            if(con.accountId!=null){
                
                accountIds.add(con.accountId);
            }
        }
        
    }
    
    if(Trigger.old!=null){
        
        for(Contact conn:Trigger.old){
            
            if(conn.accountId!=null){
                
                accountIds.add(conn.accountId);
            }
        }
    }
    
    List<Account>accounts=[Select Id,NumberofContacts__c,(Select Id from Contacts) from Account where Id in:accountIds];
    
    if(!accounts.isEmpty()){
        
        for(Account acc:accounts){
            
            acc.NumberofContacts__c=acc.Contacts.size();
        }
    }
    
    update accounts;
        
}