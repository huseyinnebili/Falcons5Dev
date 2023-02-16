import { LightningElement } from "lwc";

import { ShowToastEvent } from "lightning/platformShowToastEvent";
import Contact from "@salesforce/schema/Contact";
import { createRecord } from "lightning/uiRecordApi";

export default class CreateRecordContact extends LightningElement {
  formData = {};

  changeHandler(event) {
    const { name, value } = event.target;

    this.formData[name] = value;
  }

  createContact() {
    const recordInput = {
      apiName: Contact.objectApiName,
      fields: this.formData
    };

    createRecord(recordInput)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.contactform").reset();
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