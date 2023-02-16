public with sharing class PublicAPIsCallOut {
  public static HttpResponse getAPIsInfo() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.publicapis.org/entries');
    request.setMethod('GET');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonToString = response.getBody();
      System.debug('jsonToString = ' + jsonToString);

      //   Map<String, Object> info = (Map<String, Object>) JSON.deserializeUntyped(
      //     jsonToString
      //   );

      //   List<Object> entries = (List<Object>) info.get('entries');

      //   for (Object entry : entries) {
      //     System.debug('entries = ' + entry);
      //   }
      // } else {
      //   System.debug('Some error occurred!..');
      // }

      List<PublicAPIsCallOutWrapper.Entries> entriesPayLoad = (List<PublicAPIsCallOutWrapper.Entries>) JSON.deserialize(
        jsonToString,
        List<PublicAPIsCallOutWrapper.Entries>.class
      );

      insertRecordsToCommentObjRespectToUserResponse(entriesPayLoad);
    }
    return response;
  }

  public static void insertRecordsToCommentObjRespectToUserResponse(
    List<PublicAPIsCallOutWrapper.Entries> entries
  ) {
    List<Account> insertToAccounts = new List<Account>();
    for (PublicAPIsCallOutWrapper.Entries entry : entries) {
      Account acc = new Account();
      acc.Description = entry.Description;
      acc.Name = entry.API;
      acc.Category__c = entry.Category;
      acc.Link__c = entry.Link;

      insertToAccounts.add(acc);
    }

    insert insertToAccounts;
  }
}