public with sharing class AccountQueueableCopado implements Queueable {
  public List<Account> listAcc;

  public AccountQueueableCopado(List<Account> listAcc) {
    this.listAcc = listAcc;
  }

  public void execute(QueueableContext qc) {
    for (Account eachacc : listAcc) {
      eachacc.Type = 'Installation Partner';
    }

    update listAcc;
  }
}