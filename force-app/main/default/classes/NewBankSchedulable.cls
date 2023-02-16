public with sharing class NewBankSchedulable implements Schedulable {
  public void execute(SchedulableContext sc) {
    NewBankBatch obj = new NewBankBatch();

    Database.executeBatch(obj);
  }
}