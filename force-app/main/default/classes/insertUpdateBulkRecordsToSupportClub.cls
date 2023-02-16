public with sharing class insertUpdateBulkRecordsToSupportClub {
  public static void insertBulkRecords() {
    Sport_Club__c obj1 = new Sport_Club__c();
    obj1.Branch_Name__c = 'Baseball';
    obj1.Club_Name__c = 'PS2 Athletics';
    obj1.Required_Age__c = 12;

    Sport_Club__c obj2 = new Sport_Club__c();
    obj2.Branch_Name__c = 'Basketball';
    obj2.Club_Name__c = 'Essex County Sports';
    obj2.Required_Age__c = 8;

    List<Sport_Club__c> listSportClub = new List<Sport_Club__c>{ obj1, obj2 };

    if (!listSportClub.isEmpty()) {
      insert listSportClub;
    }
  }

  public static void updateBulkRecords() {
    list<Sport_Club__c> listReturned = [
      SELECT id, name, Club_Fee__c
      FROM Sport_Club__c
    ];

    for (Sport_Club__c eachSport : listReturned) {
      eachSport.Club_Fee__c = 324;
    }

    if (!listReturned.isEmpty()) {
      update listReturned;
    }
  }

  public static void updateBulkRecordsTwo() {
    list<Sport_Club__c> listReturned = [
      SELECT id, name, Club_Reviews__c
      FROM Sport_Club__c
      WHERE Club_Reviews__c = NULL
    ];

    for (Sport_Club__c eachSport : listReturned) {
      eachSport.Club_Reviews__c = 'Beautiful facility, everything you need to train to up your game whether its  asketball, volleyball, or my favorite baseball,and the others.';
    }

    if (!listReturned.isEmpty()) {
      update listReturned;
    }
  }

  //Database.insert (sObject,AllOrNothing)=>true or false
  public static void insertRecordsViaDatabaseInsert() {
    Sport_Club__c obj1 = new Sport_Club__c();
    obj1.Branch_Name__c = 'Baseball';
    obj1.Club_Name__c = 'PS2 Athletics';
    obj1.Required_Age__c = 12;

    Sport_Club__c obj2 = new Sport_Club__c();
    obj2.Branch_Name__c = 'Basketball';
    obj2.Club_Name__c = 'Essex County Sports';
    obj2.Required_Age__c = 8;

    Sport_Club__c obj3 = new Sport_Club__c();
    Sport_Club__c obj4 = new Sport_Club__c();

    List<Sport_Club__c> listSportClub = new List<Sport_Club__c>{
      obj1,
      obj2,
      obj3,
      obj4
    };

    List<Database.SaveResult> results = Database.insert(listSportClub, false);
    for (Database.SaveResult eachClub : results) {
      if (eachClub.isSuccess()) {
        System.debug(
          'Sport Club successfully inserted.Branch id is ' + eachClub.getId()
        );
      } else {
        System.debug('Errors ' + eachClub.getErrors());
      }
    }
  }
}