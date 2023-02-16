//Write a trigger on the Account when the Account is updated check all opportunities related to the account. 
//Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today 
//and stage not equal to close won.

trigger UpdateOppFields on Account (after insert,after update) {

    Map<Id,Account>mapAccount=new Map<Id,Account>();
    
    DateTime day30=system.now()-30;
    
    for(Account acc:Trigger.new){
        
        if(acc.Rating=='Hot'){
            
            if(Trigger.old==null || acc.Name!=Trigger.oldMap.get(acc.Id).Name){
                
                mapAccount.put(acc.Id,acc);
            }
        }
    }
    
    List<Opportunity>updateToOpp=new List<Opportunity>();
    
    for(Opportunity opp:[Select id,AccountId,StageName,CreatedDate,CloseDate from Opportunity where AccountId in:mapAccount.keySet()]){
        
        if(opp.CreatedDate<day30 && opp.StageName!='Closed Won'){
            
            opp.StageName='Closed Lost';
            opp.CloseDate=system.today();
            
            updateToOpp.add(opp);
        }
        
    }
    
    update updateToOpp;
}