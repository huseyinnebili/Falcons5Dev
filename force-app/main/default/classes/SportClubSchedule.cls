public with sharing class SportClubSchedule implements Schedulable {
  public void execute(SchedulableContext sc) {
    SportClubBatch obj = new SportClubBatch();

    database.executeBatch(obj, 10);
  }
}