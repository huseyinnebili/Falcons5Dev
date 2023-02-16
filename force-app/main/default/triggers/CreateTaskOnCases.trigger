trigger CreateTaskOnCases on Case (after insert,after update) {

    List<Task>insertTask=new List<Task>();
    User us=[SELECT Name,Alias,Department,Division from User where Alias='rose' ]; 
    for(Case cs:Trigger.new){
       
        if(cs.Priority=='High'){
            
            Task t=new Task();
            t.WhatId=cs.Id;
            t.Subject='Call';
            t.Priority='High';
            t.Description='Gather all information about new Case';
            t.OwnerId=us.Id;
            
            insertTask.add(t);
            
        }
      
    }
    
    if(!insertTask.isEmpty()){
        
        insert insertTask;
    }
}