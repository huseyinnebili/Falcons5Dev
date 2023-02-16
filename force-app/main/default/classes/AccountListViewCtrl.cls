public class AccountListViewCtrl {
    @AuraEnabled
    public static List<SObject> getEntity(String entityType){
        List<SObject> sobj = new List<SObject>();
        String query = '';
        if(entityType != null) {
            if(entityType == 'Contact' || entityType == 'Lead' || entityType == 'Opportunity') {
                query = 'SELECT Id, Name, Account.Name, Phone FROM '+ entityType ;
            }else if (entityType == 'Tasks') {
                query = 'SELECT Id, CallType FROM '+ entityType ;
            } else {
                query = 'SELECT Name, Id, Phone FROM '+entityType ;
                
            }
        }
        if(query != '' && query != NULL) {
            sobj = database.query(query);
        }
        return sobj;
    }
}