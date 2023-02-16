trigger CaseTrigger on Case(before insert, before update) {
  if (Trigger.isInsert) {
    System.debug('before insert case');
  }

  if (Trigger.isUpdate) {
    CaseTriggerHandler.countTriggerExecution++;

    System.debug(
      '# of times trigger executed : ' +
      CaseTriggerHandler.countTriggerExecution
    );

    CaseTriggerHandler.countRecordsUpdated += Trigger.size;
    System.debug(
      '# of records updated : ' + CaseTriggerHandler.countRecordsUpdated
    );
  }
}