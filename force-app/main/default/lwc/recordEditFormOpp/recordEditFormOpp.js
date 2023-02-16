import { LightningElement } from "lwc";

import OPPORTUNITY from "@salesforce/schema/Opportunity";
import Name from "@salesforce/schema/Opportunity.Name";
import AccoundId from "@salesforce/schema/Opportunity.AccountId";
import StageName from "@salesforce/schema/Opportunity.StageName";
import Amount from "@salesforce/schema/Opportunity.Amount";
import CloseDate from "@salesforce/schema/Opportunity.CloseDate";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class RecordEditFormOpp extends LightningElement {
  recordId = "0068b00001LcDg0AAF";
  objectName = OPPORTUNITY;
  fields = {
    name: Name,
    accoundId: AccoundId,
    stageName: StageName,
    amount: Amount,
    closeDate: CloseDate
  };

  showToast() {
    const event = new ShowToastEvent({
      title: "success",
      message: "Opportunity has been created successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}