public with sharing class HotelQueueable implements Queueable {
  public List<Hotel__c> listHotel;
  public HotelQueueable(List<Hotel__c> listHotel) {
    this.listHotel = listHotel;
  }

  public void execute(QueueableContext qc) {
    for (Hotel__c eachHotel : listHotel) {
      eachHotel.Source_URL__c = 'https://www.expedia.com/';
    }

    update listHotel;
  }
}