trigger preventDuplicateContacts on Contact(before insert, before update) {
  Map<String, Contact> mapContact = new Map<String, Contact>();

  for (Contact conn : Trigger.new) {
    if (conn.Email != null) {
      if (
        //if => Trigger.oldMap==null is effective,then INSERT operation will be executed!..
        //if =>  conn.Email != Trigger.oldMap.get(conn.Id).Email is effective ,then UPDATE operation will be executed!..

        Trigger.oldMap == null ||
        conn.Email != Trigger.oldMap.get(conn.Id).Email
      ) {
        if (!mapContact.containsKey(conn.Email)) {
          mapContact.put(conn.Email, conn);
        } else {
          conn.Email.addError('Duplicate email has been found!.');
        }
      }
    }
  }

  List<Contact> listOfContact = [
    SELECT id, Email, Phone
    FROM Contact
    WHERE Email IN :mapContact.keySet()
  ];

  if (!listOfContact.isEmpty()) {
    for (Contact conn : listOfContact) {
      Contact newContact = mapContact.get(conn.Email);

      newContact.Email.addError('Duplicate email has been found!.');
    }
  }
}