trigger updateContactTrigger on Account(after insert) {
  updateContact.createOpportunities(Trigger.new);
}