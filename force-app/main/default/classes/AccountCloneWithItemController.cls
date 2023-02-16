public with sharing class AccountCloneWithItemController {
  private Apexpages.StandardController controller { get; set; }

  private Account account { get; set; }
  //private ContentDocumentLink content { get; set; }

  public ID newRecordId { get; set; }

  public AccountCloneWithItemController(
    Apexpages.StandardController controller
  ) {
    this.controller = controller;

    account = (Account) controller.getRecord();
    //  content = (ContentDocumentLink) controller.getRecord();
  }

  public Pagereference cloneWithItems() {
    Savepoint sp = Database.setSavepoint();
    Account accCopy;

    try {
      Account acc = [
        SELECT
          Id,
          Name,
          Active__c,
          Category__c,
          CleanStatus,
          Type,
          Industry,
          Rating
        FROM Account
        WHERE id = :account.id
      ];

      accCopy = acc.clone(false, true);

      insert accCopy;

      newRecordId = accCopy.id;

      // List<ContentDocumentLink> items = new List<ContentDocumentLink>();
      List<Contact> items = new List<Contact>();

      for (Contact conn : [
        SELECT id, AccountId, LastName
        FROM Contact
        WHERE AccountId = :acc.id
      ]) {
        Contact newCon = conn.clone(false, true);
        Contact conCopy = newCon.clone(false, true);
        conCopy.AccountId = accCopy.Id;
        items.add(conCopy);
      }

      insert items;
    } catch (Exception e) {
      Database.rollback(sp);
      Apexpages.addMessages(e);
      return null;
    }

    return new Pagereference('/' + accCopy.id + '/e?retURL=%2F' + accCopy.id);
  }
}