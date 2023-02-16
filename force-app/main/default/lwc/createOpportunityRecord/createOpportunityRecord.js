import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import Opportunity from "@salesforce/schema/Opportunity";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateOpportunityRecord extends LightningElement {
  formData = {};

  changeHandler(event) {
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  createOpportunity() {
    const recordInput = {
      apiName: Opportunity.objectApiName,
      fields: this.formData
    };

    createRecord(recordInput)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.createOpp").reset();
        this.formData = {};
        this.creatToast(
          "Success",
          "Record has been created successfully",
          "success"
        );
      })

      .catch((error) => {
        console.error(error);
        this.creatToast("Error", error.message, "error");
      });
  }

  creatToast(title, message, variant) {
    const toast = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(toast);
  }
}