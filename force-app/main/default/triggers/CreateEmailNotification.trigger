trigger CreateEmailNotification on Contact(after insert, after update) {
  List<Messaging.Email> listEmail = new List<Messaging.Email>();

  for (Contact conn : Trigger.new) {
    if (
      Trigger.old == null ||
      conn.LastName != Trigger.oldMap.get(conn.Id).LastName
    ) {
      if (conn.Email != null) {
        Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();

        String[] toAddress = new List<String>{ conn.Email };
        emailMsg.setToAddresses(toAddress);

        String emailSub = 'Welcome ' + conn.LastName;
        emailMsg.setSubject(emailSub);

        String disName = 'Fatih Ari ';
        emailMsg.setSenderDisplayName(disName);

        String content =
          'Hi ' +
          conn.LastName +
          '<br/><br/>' +
          'Welcome to Salesforce ecosystem';
        emailMsg.setHtmlBody(content);

        listEmail.add(emailMsg);
      }
    }
  }
  Messaging.sendEmail(listEmail);
}