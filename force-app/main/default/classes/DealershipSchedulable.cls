public with sharing class DealershipSchedulable implements Schedulable {
  public void execute(SchedulableContext sc) {
    List<Dealership__c> listDealership = [
      SELECT id, name, Compare_Price_Via_URL__c
      FROM Dealership__c
    ];

    DealershipQueueable obj = new DealershipQueueable(listDealership);
    System.enqueueJob(obj);
  }
}