public class SportClubBatch implements Database.Batchable<sObject>, Database.stateful {
  public integer count = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator ql = database.getQueryLocator(
      [SELECT id, name, Attendee_Review_For_Club__c FROM Club_Attendee__c]
    );

    return ql;
  }

  public void execute(
    Database.BatchableContext bc,
    List<Club_Attendee__c> scope
  ) {
    List<Club_Attendee__c> listUpdate = new List<Club_Attendee__c>();

    for (Club_Attendee__c eachAtt : scope) {
      eachAtt.Attendee_Review_For_Club__c = 'Well run, super fun and I have met some great folks along the way';
      listUpdate.add(eachAtt);

      count++;
    }

    update listUpdate;
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('Update done!..');
    System.debug('# the number of updated records is ' + count);
  }
}