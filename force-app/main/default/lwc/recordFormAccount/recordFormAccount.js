import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import TYPE_FIELD from "@salesforce/schema/AcceptedEventRelation.Type";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";

export default class RecordFormAccount extends LightningElement {
  recordId = "0018b000026d86mAAA";
  objectName = ACCOUNT_OBJECT;
  fields = [NAME_FIELD, TYPE_FIELD, INDUSTRY_FIELD, REVENUE_FIELD];

  showSuccessMessage() {
    const successToast = new ShowToastEvent({
      title: "Success",
      message: "The account has been saved successfully!..",
      variant: "success"
    });

    this.dispatchEvent(successToast);
  }
}