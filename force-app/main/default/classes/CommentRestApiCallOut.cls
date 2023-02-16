public with sharing class CommentRestApiCallOut {
  public static HttpResponse getComment() {
    HttpRequest request = new HttpRequest();

    request.setEndpoint(
      'https://jsonplaceholder.typicode.com/comments?postId=1'
    );
    request.setMethod('GET');

    Http http = new Http();
    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();

      List<UserComments> listComments = (List<UserComments>) JSON.deserialize(
        jsonString,
        List<UserComments>.class
      );

      // insertUserCommentsToCommentObject(listComments);
      updateUserCommentsToCommentObject(listComments);
    } else {
      System.debug('Some error occurred!..');
    }

    return response;
  }

  public static void insertUserCommentsToCommentObject(
    List<UserComments> userComments
  ) {
    List<Comment__c> insertCommentsList = new List<Comment__c>();
    for (UserComments userComm : userComments) {
      Comment__c comm = new Comment__c();
      comm.Comment_ID__c = userComm.postId;
      comm.Comment_Name__c = userComm.name;
      comm.Email__c = userComm.email;
      comm.My_Id__c = userComm.id;

      insertCommentsList.add(comm);
    }

    insert insertCommentsList;
  }

  public static void updateUserCommentsToCommentObject(
    List<UserComments> userComments
  ) {
    Set<String> setNames = new Set<String>();
    Map<String, Comment__c> mapComment = new Map<String, Comment__c>();
    List<Comment__c> updateList = new List<Comment__c>();
    for (UserComments comment : userComments) {
      setNames.add(comment.name);
    }
    for (Comment__c comm : [
      SELECT Comment_ID__c, Comment_Name__c, Email__c, My_Id__c
      FROM Comment__c
      WHERE Comment_Name__c = :setNames
    ]) {
      mapComment.put(comm.Comment_Name__c, comm);
    }

    for (UserComments user : userComments) {
      if (mapComment.containsKey(user.name)) {
        Comment__c com = mapComment.get(user.name);
        com.My_Body__c = user.body;
        updateList.add(com);
      }
    }
    update updateList;
  }
}