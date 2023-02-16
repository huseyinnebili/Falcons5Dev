public with sharing class scoreCardTriggerHandler {
  public static void delRelScore(
    List<Account> accTriggerOld,
    Map<Id, Account> accTriggerOldMap
  ) {
    Set<Id> setIDs = accTriggerOldMap.keySet();

    Map<Id, Contact> mapContact = new Map<Id, Contact>();

    List<Contact> listContact = [
      SELECT id, AccountId
      FROM Contact
      WHERE AccountId IN :setIDs
    ];

    for (Contact conn : listContact) {
      if (conn.AccountId != null) {
        mapContact.put(conn.AccountId, conn);
      }
    }

    for (Account acc : accTriggerOld) {
      if (mapContact.containsKey(acc.Id)) {
        acc.addError(
          'You can not delete rocords associated with Contact records.'
        );
      }
    }
  }
}