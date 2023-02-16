public with sharing class SportClubQueuable implements Queueable {
  public List<Sport_Club__c> listSportClub;

  public SportClubQueuable(List<Sport_Club__c> listSportClub) {
    this.listSportClub = listSportClub;
  }

  public void execute(QueueableContext qc) {
    for (Sport_Club__c eachClub : listSportClub) {
      eachClub.Club_State__c = 'NJ';
    }
    update listSportClub;
  }
}