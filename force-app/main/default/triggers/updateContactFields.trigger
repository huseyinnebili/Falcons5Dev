trigger updateContactFields on Account(after update) {
  Map<Id, Account> mapAccount = new Map<Id, Account>();

  for (Account acc : Trigger.new) {
    if (acc.Phone != null || acc.Account_Email__c != null)
      mapAccount.put(acc.id, acc);
  }

  List<Contact> listContact = new List<Contact>();

  for (Contact conn : [
    SELECT id, phone, accountId, Email
    FROM Contact
    WHERE AccountId IN :mapAccount.keySet()
  ]) {
    if (mapAccount.containsKey(conn.AccountId)) {
      conn.Phone = mapAccount.get(conn.AccountId).Phone;
      conn.Email = mapAccount.get(conn.AccountId).Account_Email__c;
      conn.LastName = mapAccount.get(conn.AccountId).Name + ' Contact';
      listContact.add(conn);
    }
  }

  if (!listContact.isEmpty()) {
    update listContact;
  }

}