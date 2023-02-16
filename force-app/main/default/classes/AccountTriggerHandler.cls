public with sharing class AccountTriggerHandler {
  public static void updateVIPForAllContacts(
    List<Account> accountTriggerNew,
    List<Account> accountTriggerOld,
    Map<Id, Account> accountTriggerNewMap,
    Map<Id, Account> accountTriggerOldMap
  ) {
    Set<Id> setAccoundIds = new Set<Id>();

    for (Account eachAccount : accountTriggerNew) {
      if (
        eachAccount.VIP__c != accountTriggerOldMap.get(eachAccount.id).VIP__c
      ) {
        setAccoundIds.add(eachAccount.id);
      }
    }

    List<Contact> listContacts = [
      SELECT id, name, Account.id, VIP__c
      FROM contact
      WHERE Account.id IN :setAccoundIds
    ];

    for (contact eachContact : listContacts) {
      boolean accountVIP = accountTriggerNewMap.get(eachContact.Account.id)
        .VIP__c;
      eachContact.VIP__c = accountVIP;
    }

    update listContacts;
  }
}