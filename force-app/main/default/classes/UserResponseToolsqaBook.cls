global with sharing class UserResponseToolsqaBook {
  public List<Books> books;

  global class Books {
    global String isbn;
    global String title;
    global String subTitle;
    global String author;
    global Datetime publish_date;
    global String publisher;
    global Integer pages;
    global String description;
    global String website;
  }
}