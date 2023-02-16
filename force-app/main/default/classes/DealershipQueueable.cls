public with sharing class DealershipQueueable implements Queueable {
  public List<Dealership__c> listDealership;
  public DealershipQueueable(List<Dealership__c> listDealership) {
    this.listDealership = listDealership;
  }
  public void execute(QueueableContext qc) {
    for (Dealership__c eachDealership : listDealership) {
      eachDealership.Compare_Price_Via_URL__c = 'https://www.autolist.com/';
    }

    update listDealership;
  }
}