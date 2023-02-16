import { LightningElement } from "lwc";
import CONTACT from "@salesforce/schema/Contact";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateRecordOnContact extends LightningElement {
  formData = {};

  changeHandler(event) {
    const { name, value } = event.target;
    this.formData[name] = value;
  }

  createContact() {
    const recordInput = {
      apiName: CONTACT.objectApiName,
      fields: this.formData
    };

    createRecord(recordInput)
      .then((result) => {
        console.log(result);
        this.template.querySelector("form.contactRecord").reset();
        this.showToast(
          "Succes",
          "Record has been craeted succesfully",
          "success"
        );
        this.formData = {};
      })
      .catch((error) => {
        console.error(error);
        this.showToast("Error", error.message, "error");
      });
  }

  showToast(title, message, variant) {
    const event = new ShowToastEvent({ title, message, variant });

    this.dispatchEvent(event);
  }
}