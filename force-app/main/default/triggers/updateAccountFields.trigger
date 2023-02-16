trigger updateAccountFields on Opportunity(after update) {
  Map<Id, Opportunity> mapOpp = new Map<Id, Opportunity>();

  for (Opportunity opp : Trigger.new) {
    if (opp.Opportunity_Email__c != null || opp.Opportunity_Phone__c != null) {
      if (opp.StageName != Trigger.oldMap.get(opp.id).StageName) {
        mapOpp.put(opp.AccountId, opp);
      }
    }
  }

  List<Account> listAcc = new List<Account>();

  for (Account acc : [
    SELECT
      id,
      Account_Email__c,
      Phone,
      (
        SELECT Id, AccountId, Opportunity_Email__c, Opportunity_Phone__c
        FROM Opportunities
      )
    FROM Account
    WHERE Id IN :mapOpp.keySet()
  ]) {
    if (mapOpp.containsKey(acc.id)) {
      acc.Phone = mapOpp.get(acc.id).Opportunity_Phone__c;
      acc.Account_Email__c = mapOpp.get(acc.id).Opportunity_Email__c;

      listAcc.add(acc);
    }
  }

  if (!listAcc.isEmpty()) {
    update listAcc;
  }

}