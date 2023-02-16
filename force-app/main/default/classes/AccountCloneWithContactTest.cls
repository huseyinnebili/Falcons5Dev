@isTest
public with sharing class AccountCloneWithContactTest {
  @isTest
  public static void test() {
    // setup a reference to the page the controller is expecting with the parameters
    PageReference pref = Page.AccountCloneWithContact;
    Test.setCurrentPage(pref);

    Account acc = new Account();
    acc.Name = 'PSAV 6FOO';
    acc.Type = 'Supplier';
    insert acc;

    Attachment attach = new Attachment();
    attach.Name = 'Unit Test Attachment';
    Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
    attach.body = bodyBlob;
    attach.parentId = acc.id;
    insert attach;

    //Create Document
    ContentVersion cv = new ContentVersion();
    cv.Title = 'Test Document';
    cv.PathOnClient = 'TestDocument.pdf';
    cv.VersionData = Blob.valueOf('Test Content');
    cv.IsMajorVersion = true;
    insert cv;

    //Get Content Documents
    Id conDocId = [
      SELECT ContentDocumentId
      FROM ContentVersion
      WHERE Id = :cv.Id
    ]
    .ContentDocumentId;

    //Create ContentDocumentLink
    ContentDocumentLink cdl = new ContentDocumentLink();
    cdl.LinkedEntityId = acc.Id;
    cdl.ContentDocumentId = conDocId;
    cdl.shareType = 'V';
    insert cdl;

    // Construct the standard controller
    ApexPages.StandardController controll = new ApexPages.StandardController(
      acc
    );

    // create the controller
    AccountCloneWithContact ext = new AccountCloneWithContact(controll);

    // Switch to test context
    Test.startTest();

    // call the cloneWithItems method
    PageReference ref = ext.cloneWithItems();
    // create the matching page reference
    PageReference redir = new PageReference(
      '/' +
      ext.newRecordId +
      '/e?retURL=%2F' +
      ext.newRecordId
    );

    // make sure the user is sent to the correct url
    System.assertEquals(ref.getUrl(), redir.getUrl());

    // check that the new po was created successfully
    Account newAcc = [SELECT id FROM Account WHERE id = :ext.newRecordId];
    System.assertNotEquals(newAcc, null);

    List<Attachment> attachments = [
      SELECT id, name
      FROM Attachment
      WHERE parent.id = :acc.id
    ];
    System.assertEquals(1, attachments.size());

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

    System.assertEquals(1, content.size());

    Test.stopTest();
  }
}