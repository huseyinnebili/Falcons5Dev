public with sharing class AccountCloneWithContact {
  //public String idOfRec { get; set; }
  private Apexpages.StandardController controller { get; set; }

  private Account account { get; set; }

  // set the id of the record that is created -- ONLY USED BY THE TEST CLASS
  public ID newRecordId { get; set; }

  public AccountCloneWithContact(Apexpages.StandardController controller) {
    this.controller = controller;

    account = (Account) controller.getRecord();
  }

  public Pagereference cloneWithItems() {
    Savepoint sp = Database.setSavepoint();
    Account accCopy;

    try {
      List<ContentDocumentLink> contens = new List<ContentDocumentLink>();
      List<Attachment> attachments = new List<Attachment>();

      Account acc = [
        SELECT
          ID,
          Name,
          CleanStatus,
          Countries__c,
          CustomerPriority__c,
          Description,
          Industry,
          Type,
          Rating,
          SLA__c,
          SLAExpirationDate__c,
          UpsellOpportunity__c,
          Valid_Customer__c,
          DuplicateFound__c
        FROM Account
        WHERE Id = :account.id
      ];

      acc.ParentId = account.id;
      accCopy = acc.clone(false, true);

      insert accCopy;

      // set the id of the new po created for testing
      newRecordId = accCopy.id;

      List<ContentDocumentLink> content = [
        SELECT
          ContentDocumentId,
          Visibility,
          ContentDocument.CreatedDate,
          ContentDocument.Title,
          sharetype,
          LinkedEntityId
        FROM ContentDocumentLink
        WHERE LinkedEntityId = :acc.Id
      ];

      for (ContentDocumentLink con : content) {
        ContentDocumentLink conCopy = con.clone(false, true);
        conCopy.LinkedEntityId = accCopy.Id;
        contens.add(conCopy);
      }
      insert contens;

      List<Attachment> attachedFiles = [
        SELECT Id, Name, Body, ContentType
        FROM Attachment
        WHERE ParentId = :acc.Id
      ];

      for (Attachment attach : attachedFiles) {
        Attachment attachCopy = attach.clone(false, true);
        attachCopy.ParentId = accCopy.Id;
        attachments.add(attachCopy);
      }
      insert attachments;
    } catch (Exception e) {
      Database.rollback(sp);
      Apexpages.addMessages(e);
      return null;
    }

    return new Pagereference('/' + accCopy.id + '/e?retURL=%2F' + accCopy.id);
  }
}