public with sharing class AccountQueueable implements Queueable {
  public List<Account> listAcc;

  public AccountQueueable(List<Account> listAcc) {
    this.listAcc = listAcc;
  }

  public void execute(QueueableContext qc) {
    for (Account eachAcc : listAcc) {
      eachAcc.Name = eachAcc + '--SI';
      eachAcc.Industry = 'Energy';
    }

    update listAcc;
  }
}