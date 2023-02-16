public with sharing class ListViewController {

    /**This is the list which will be passed to Visualforce Page and in turn passed to Flow from Visualforce**/
    public List < Account > LstSelectedAccounts {
        get;
        set;
    }
    
    public ListViewController(ApexPages.StandardSetController listcontroller) {
      
        Set < Id > accountsSelectedIds = new set < Id > ();
        LstSelectedAccounts = new List <Account >();
            
        for (Account a: (Account[]) listcontroller.getSelected()) {
            accountsSelectedIds.add(a.id);
        }
        
        /**Querying on the Selected records and fetching fields which are required in Flow **/
        LstSelectedAccounts = [select Id,Name from Account where id in: accountsSelectedIds];
    }
}