public class CloneTestingRecordClass{
public PageReference clonedRec() {
Account selectedRecord = [select Id,name from Account where id=:rId];
Account lstnew = selectedRecord.clone(false);
insert lstnew;
pagereference ref = new pagereference('/apex/cloneRecordTesting');
ref.setredirect(true);
return ref;
}
public String rId{get;set;}
List<Account> lstdlt = new List<Account>();
public List<Account> getRecords() {
lstdlt = [select Id,name from Account];
return lstdlt;
}
}