public with sharing class BranchQueueable implements Queueable {
  public List<Branch__c> listBranch;

  public BranchQueueable(List<Branch__c> listBranch) {
    this.listBranch = listBranch;
  }

  public void execute(QueueableContext qc) {
    for (Branch__c eachBranch : listBranch) {
      eachBranch.Registration_Confirmation_Status__c = 'In Progress';
    }

    update listBranch;
  }
}