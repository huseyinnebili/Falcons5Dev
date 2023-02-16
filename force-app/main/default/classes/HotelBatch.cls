public with sharing class HotelBatch implements Database.Batchable<sObject>, database.stateful {
  public integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [
        SELECT id, name, Source_URL__c, Type_of_The_Hotel__c
        FROM Hotel__c
        WHERE
          Type_of_The_Hotel__c = 'Resorts'
          OR Type_of_The_Hotel__c = 'All-suites'
        LIMIT 200
      ]
    );

    return ql;
  }

  public void execute(Database.BatchableContext bc, list<Hotel__c> scope) {
    List<Hotel__c> listHotelUpdate = new List<Hotel__c>();

    for (Hotel__c eachHotel : scope) {
      eachHotel.Source_URL__c = 'https://www.booking.com/';

      listHotelUpdate.add(eachHotel);
      count++;
    }

    if (!listHotelUpdate.isEmpty()) {
      update listHotelUpdate;
    }
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('done with updating all the accounts!...');
    System.debug('# of records updated: ' + count);
  }
}