trigger DuplicateNameFound on Account(before insert, before update) {
  Map<String, Account> mapAccount = new Map<String, Account>();

  for (Account acc : Trigger.new) {
    if (acc.Name != null) {
      if (Trigger.old == null || acc.Name != Trigger.oldMap.get(acc.Id).Name) {
        if (!mapAccount.containsKey(acc.Name)) {
          mapAccount.put(acc.Name, acc);
        } else {
          acc.Name.addError(
            'An Acccount has already been created through this name'
          );
        }
      }
    }
  }

  List<Account> listOfAccount = [
    SELECT id, Name
    FROM Account
    WHERE Name IN :mapAccount.keySet()
  ];

  if (!listOfAccount.isEmpty()) {
    for (Account account : listOfAccount) {
      Account newAccount = mapAccount.get(account.Name);

      newAccount.Name.addError(
        'An Acccount has already been created through this name!..'
      );
    }
  }

}