trigger CountingLeadRecordsOnOpp on Lead (after insert,after update,after delete,after undelete) {
    
    Set<Id>setOfIDs=new Set<Id>();
    
    if(Trigger.new!=null){
        
        for(Lead l:Trigger.new){
            
            if(l.Opportunity__c!=null){
                
                setOfIDs.add(l.Opportunity__c);
            }
        }
    }
    
    if(Trigger.old!=null){
        
        for(Lead l:Trigger.old){
            
            if(l.Opportunity__c!=null){
                
                setOfIDs.add(l.Opportunity__c);
            }
        }
    }
    
    List<Opportunity>listOfOpp=[Select id,Count_Lead_Records__c,(Select id from Leads__r) from Opportunity where id in:setOfIDs];
   
    for(Opportunity opp:listOfOpp){
        
        if(!listOfOpp.isEmpty()){
            
            opp.Count_Lead_Records__c=opp.Leads__r.size();
            
        }
    }
    
    update listOfOpp;
    
    

}