trigger createTaskOnCase on Case (after insert,after update) {

    User u=[Select Alias from User where Alias='rose'];
    List<Task>insertToTask=new List<Task>();
    
     static boolean condition =false;
    
    for(Case c:Trigger.new){
        
        if(Trigger.old==null && c.Priority=='High'){
            
             condition=true;            
        }
        
        if(Trigger.old!=null){
            
            if(c.Priority!=Trigger.oldMap.get(c.Id).Priority){
                
                if(c.Priority=='High'){
                    
                    condition=true;
                }
            }
        }
        
        if(condition){
            
            Task t=new Task();
            
            t.WhatId=c.Id;
            t.OwnerId=u.Id;
            t.Status='In Progress';
            t.Description='Gather all information about the new Case';
            t.Subject='Send Quote';
            
            insertToTask.add(t);
        }
    }
    
    if(!insertToTask.isEmpty()){
        
        insert insertToTask;
    }
}