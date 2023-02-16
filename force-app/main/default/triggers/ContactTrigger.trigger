trigger ContactTrigger on Contact(before update, before insert) {
  if (Trigger.isInsert) {
    System.debug('Before insert contact trigger!...');
  }

  if (Trigger.isUpdate) {
    System.debug('Before update contact trigger!...');
  }
}