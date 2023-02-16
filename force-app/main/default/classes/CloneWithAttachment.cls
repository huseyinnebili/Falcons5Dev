public class CloneWithAttachment {
 private Apexpages.StandardController controller{get;set;}
    private Case ca{get;set;}
    
    //set the id of the record that is created.It is only used by the test class.
    public ID newRecordId{get;set;}
    public String oldRecordId{get;set;}
    public String caseRecordId{get;set;}
    
    public CloneWithAttachment(Apexpages.StandardController controller){
        
        this.controller=controller;
        ca=(Case)controller.getRecord();
        oldRecordId = apexpages.currentpage().getparameters().get('id'); 
    }
    
        public Pagereference cloneWithItems(){
        
        Savepoint sp=Database.setSavepoint();
        oldRecordId = apexpages.currentpage().getparameters().get('id'); 
        Case caseCopy;
        
        try{
            
            List<ContentDocumentLink>content=new List<ContentDocumentLink>();
            List<Attachment>attachments=new List<Attachment>();
            
            Case cs=[Select id,AccountId,Origin,Reason  from  case  where  id =:ca.id];
            cs.ParentId=ca.Id;
            caseCopy=cs.clone(false,true);
            
            insert caseCopy;
            newRecordId=caseCopy.id;
            
            List<ContentDocumentLink>contents=[Select ContentDocumentId,Visibility,ContentDocument.CreatedDate,
                                               ContentDocument.Title,ShareType,LinkedEntityId from ContentDocumentLink where 
                                               LinkedEntityId =:cs.id];
            
            for(ContentDocumentLink con:contents){
                
                ContentDocumentLink conCopy=con.clone(false,true);
                conCopy.LinkedEntityId=caseCopy.id;
                content.add(conCopy);
            }
            
            insert content;
            
            List<Attachment> attachedFiles = [
        SELECT Id, Name, Body, ContentType,ParentId
        FROM Attachment
        WHERE ParentId = :cs.id
      ];

      for (Attachment attach : attachedFiles) {
        Attachment attachCopy = attach.clone(false, true);
        attachCopy.ParentId = caseCopy.Id;
        attachments.add(attachCopy);
      }
      insert attachments;
            
        }catch(Exception e){
            
            Database.rollback(sp);
            Apexpages.addMessages(e);
            return null;
        }
		system.debug('newRecordId'+newRecordId);
        //return new Pagereference('/'+ca.id);
        return null;
           // return new Pagereference('/'+caseCopy.id+'/e?retURL=%2F'+caseCopy.id);
    }
}