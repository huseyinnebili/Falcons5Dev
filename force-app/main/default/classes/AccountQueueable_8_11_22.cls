public with sharing class AccountQueueable_8_11_22 implements Queueable {
  public List<Account> listAcc;
  public AccountQueueable_8_11_22(List<Account> listAcc) {
    this.listAcc = listAcc;
  }

  public void execute(QueueableContext qc) {
    for (Account eachAcc : listAcc) {
      eachAcc.CustomerPriority__c = 'Medium';
    }
    update listAcc;
  }
}