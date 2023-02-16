public class scoreCardTriggerHandlerShort {

    public static void preventDeletionAcc(List<Account>accTriggerOld){
        
    Map<Id,Account>mapAccount=new Map<Id,Account>([Select Id,(Select Id from Contacts) from Account where Id in:accTriggerOld]);
    
        
        for(Account acc:accTriggerOld){
            
            if(mapAccount.containsKey(acc.Id) && mapAccount.get(acc.Id).Contacts.size()>0){
                
                acc.addError('You can not delete rocords associated with Contact records.');
            }
        }
   }
}