trigger updateContact on Product2(after update, after insert) {
  if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
    //updateContact.createOpportunitiesTwo(Trigger.new); 
  }
  }