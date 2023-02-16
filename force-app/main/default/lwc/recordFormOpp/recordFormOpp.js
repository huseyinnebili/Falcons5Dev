import { LightningElement } from "lwc";

import OPPORTUNITY_OBJECT from "@salesforce/schema/Opportunity";

import Name from "@salesforce/schema/Opportunity.Name";
import StageName from "@salesforce/schema/Opportunity.StageName";
import CloseDate from "@salesforce/schema/Opportunity.CloseDate";
import AccountId from "@salesforce/schema/Opportunity.AccountId";
import LeadSource from "@salesforce/schema/Opportunity.LeadSource";
import Type from "@salesforce/schema/Opportunity.Type";
import CurrenGenarator from "@salesforce/schema/Opportunity.CurrentGenerators__c";
import DeliveryInstallationStatus__c from "@salesforce/schema/Opportunity.DeliveryInstallationStatus__c";

import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class RecordFormOpp extends LightningElement {
  objectName = OPPORTUNITY_OBJECT;
  reordId = "";
  fields = [
    Name,
    StageName,
    CloseDate,
    AccountId,
    LeadSource,
    Type,
    DeliveryInstallationStatus__c,
    CurrenGenarator
  ];

  showToast() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "The opportunity has been saved successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}