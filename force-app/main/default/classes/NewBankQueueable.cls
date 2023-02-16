public with sharing class NewBankQueueable implements Queueable {
  List<New_Bank__c> listNewBank;

  public NewBankQueueable(List<New_Bank__c> listNewBank) {
    this.listNewBank = listNewBank;
  }

  public void execute(QueueableContext qc) {
    for (New_Bank__c eachBank : listNewBank) {
      eachBank.Bank_APR__c = 4.25;
    }

    update listNewBank;
  }
}