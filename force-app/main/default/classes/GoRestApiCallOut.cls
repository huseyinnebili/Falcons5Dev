public with sharing class GoRestApiCallOut {
  public static HttpResponse getUsers() {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://gorest.co.in/public/v2/posts');
    request.setMethod('GET');

    Http http = new Http();

    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();
      System.debug('jsonString = ' + jsonString);

      List<UserResponse> users = (List<UserResponse>) JSON.deserialize(
        jsonString,
        List<UserResponse>.class
      );

      // updateCommentFieldRespectToUserResponse(users);
      insertRecordsToCommentObjRespectToUserResponse(users);
    } else {
      System.debug('Some errors have occurred!..');
    }

    return response;
  }

  public static void updateCommentFieldRespectToUserResponse(
    List<UserResponse> userResponse
  ) {
    Set<String> my_IDs = new Set<String>();
    Map<String, Comment__c> comments = new Map<String, Comment__c>();
    List<Comment__c> commentToUpdate = new List<Comment__c>();

    for (UserResponse response : userResponse) {
      my_IDs.add(response.id);
    }

    for (Comment__c comm : [
      SELECT My_Body__c, Name, My_Title__c, My_Id__c
      FROM Comment__c
      WHERE My_Id__c IN :my_IDs
    ]) {
      comments.put(comm.My_Id__c, comm);
    }

    for (UserResponse res : userResponse) {
      if (comments.containsKey(res.id)) {
        Comment__c com = comments.get(res.id);
        com.My_Body__c = res.body;
        com.My_Title__c = res.title;

        commentToUpdate.add(com);
      }
    }

    update commentToUpdate;
  }

  private static void insertRecordsToCommentObjRespectToUserResponse(
    List<UserResponse> userResponse
  ) {
    List<Comment__c> insertToComments = new List<Comment__c>();

    for (UserResponse response : userResponse) {
      Comment__c comments = new Comment__c();

      comments.My_Body__c = response.body;
      comments.My_Title__c = response.title;
      comments.My_Id__c = response.id;

      insertToComments.add(comments);
    }

    insert insertToComments;
  }
}