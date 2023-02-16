public with sharing class CaseCtrl {
  @AuraEnabled(cacheable=true)
  public static List<Case> getCaseRecords() {
    return [
      SELECT CaseNumber, Origin, Reason, CreatedDate, Priority, Status
      FROM Case
      WHERE Priority = 'High'
      ORDER BY ClosedDate
      LIMIT 5
    ];
  }
}