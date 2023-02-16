public with sharing class AccountScheduleable_8_11_22 implements Schedulable {
  public void execute(SchedulableContext sc) {
    AccountBatch obj = new AccountBatch();
    Database.executeBatch(obj);
  }
}