import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import CASE from "@salesforce/schema/Case";
import Origin from "@salesforce/schema/Case.Origin";
import Reason from "@salesforce/schema/Case.Reason";
import PotentialLiability from "@salesforce/schema/Case.PotentialLiability__c";
import Type from "@salesforce/schema/Case.Type";
import Status from "@salesforce/schema/Case.Status";
import ProductId from "@salesforce/schema/Case.ProductId";

export default class RecordFormCaseNew extends LightningElement {
  objectApiName = CASE;
  recordId;
  fields = [Origin, Reason, PotentialLiability, Type, Status, ProductId];

  showToast() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "The Case has been saved successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}