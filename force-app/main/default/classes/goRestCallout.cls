public with sharing class goRestCallout {
  public static HttpResponse getUsers() {
    HttpRequest request = new HttpRequest();

    request.setEndpoint('https://gorest.co.in/public/v2/users');
    request.setMethod('GET');

    Http http = new Http();
      //request.setTimeout(20000);

    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();
      System.debug('jsonString = ' + jsonString);
      List<UserResponse> listUsers = (List<UserResponse>) JSON.deserialize(
        jsonString,
        List<UserResponse>.class
      );
      processUserResponse(listUsers);
    } else {
      //log an error
      System.debug('Some error occurred!..');
    }

    return response;
  }

  public static void processUserResponse(List<UserResponse> userResponse) {
    Set<String> names = new Set<String>();
    //Map<String, Contact> contacts = new Map<String, Contact>();
    Map<String, UserResponse> mapUser = new Map<String, UserResponse>();
    List<Contact> contactsToUpdate = new List<Contact>();

    for (UserResponse response : userResponse) {
      // names.add(response.name);
      mapUser.put(response.name, response);
    }

    for (Contact conn : [
      SELECT Name, Gender__c, Status__c, Email
      FROM Contact
      WHERE Name IN :mapUser.keySet()
    ]) {
      //   contacts.put(conn.Name, conn);
      // }

      // for (UserResponse resp : userResponse) {
      // if (contacts.containsKey(resp.name)) {
      if (mapUser.containsKey(conn.Name)) {
        //Contact con = contacts.get(resp.name);
        UserResponse resp = mapUser.get(conn.name);
        conn.Email = resp.email;
        conn.Gender__c = resp.gender;
        conn.Status__c = resp.status;
        contactsToUpdate.add(conn);
      }
    }

    update contactsToUpdate;
  }
}