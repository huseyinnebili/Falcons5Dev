public class AccountSchedulable implements Schedulable {
  public void execute(SchedulableContext sc) {
    AccountBatch obj = new AccountBatch();

    Database.executeBatch(obj);
  }
}