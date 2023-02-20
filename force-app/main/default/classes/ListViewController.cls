public with sharing class ListViewController {

    /**This is the list which will be passed to Visualforce Page and in turn passed to Flow from Visualforce**/
    public List < String > LstSelectedAccounts {
        get;
        set;
    }
    public String accountId {
        get;
        set;
    }
    public ListViewController(ApexPages.StandardSetController listcontroller) {
      
        Set < Id > accountsSelectedIds = new set < Id > ();
        LstSelectedAccounts = new List <String >();
            
        for (softinnovas144__Subscription__c a: (softinnovas144__Subscription__c[]) listcontroller.getSelected()) {
            accountsSelectedIds.add(a.id);
        }
        accountId = ApexPages.CurrentPage().getparameters().get('id');
        /**Querying on the Selected records and fetching fields which are required in Flow **/
        for(softinnovas144__Subscription__c sub : [select Id,Name from softinnovas144__Subscription__c where id in: accountsSelectedIds]){
            LstSelectedAccounts.add(sub.Id);
        }
        
    }
}