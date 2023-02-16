public with sharing class BookstoreToolsqaCallOut {
  public static HttpResponse getBooks() {
    HttpRequest request = new HttpRequest();

    request.setEndpoint('https://bookstore.toolsqa.com/BookStore/v1/Books');
    request.setMethod('GET');

    Http http = new Http();

    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      String jsonToString = response.getBody();

      List<UserResponseToolsqaBook.Books> toolsqaBooks = (List<UserResponseToolsqaBook.Books>) JSON.deserialize(
        jsonToString,
        List<UserResponseToolsqaBook.Books>.class
      );

      //   for (UserResponseToolsqaBook book : listBooks) {
      //     Book__c bo = new Book__c();

      //     bo.Isbn__c = book.isbn;
      //     bo.Author__c = book.author;
      //     bo.Pages__c = book.pages;
      //     bo.PublishDate__c = book.publish_date;
      //     bo.Publisher__c = book.publisher;
      //     bo.SubTitle__c = book.subTitle;
      //     bo.Title__c = book.title;
      //     bo.Website__c = book.website;
      //     insertToBookObj.add(book);
      //   }
      // }
      // insert insertToBookObj;
      // return response;
    }

    return response;
  }
}