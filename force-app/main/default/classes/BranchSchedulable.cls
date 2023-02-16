public with sharing class BranchSchedulable implements Schedulable {
  public void execute(SchedulableContext sc) {
    BranchBatch obj = new BranchBatch();

    Database.executeBatch(obj, 10);
  }
}