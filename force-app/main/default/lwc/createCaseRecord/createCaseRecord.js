import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import Account from "@salesforce/schema/Account";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateCaseRecord extends LightningElement {
  formData = {};

  changeHandler(event) {
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  createAccount() {
    const recordInput = {
      apiName: Account.objectApiName,
      fields: this.formData
    };

    createRecord(recordInput)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.accountRecord").reset();
        this.formData = {};
        this.creatToast(
          "Success",
          "Record has been created successfully",
          "success"
        );
      })

      .catch((error) => {
        console.error(error);
        this.creatToast("Error", "Error has occurred!..", "error");
      });
  }

  creatToast(title, message, variant) {
    const toast = new ShowToastEvent({ title, message, variant });
    this.dispatchEvent(toast);
  }
}