global with sharing class AccountJSONWrapper {
  global class Account {
    public String name;
    public String type;
    public String phone;
  }

  global class Response {
    global Boolean success;
    global String message;
  }
}