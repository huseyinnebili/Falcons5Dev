import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import CONTACT_OBJECT from "@salesforce/schema/Contact";

import FirstName from "@salesforce/schema/Contact.FirstName";
import LastName from "@salesforce/schema/Contact.LastName";
import Title from "@salesforce/schema/Contact.Title";
import Email from "@salesforce/schema/Contact.Email";
import Phone from "@salesforce/schema/Contact.Phone";
import Department from "@salesforce/schema/Contact.Department";
import AccountId from "@salesforce/schema/Contact.AccountId";

export default class RecordFormContact extends LightningElement {
  //recordId = "0038b00002lZtBxAAK";
  objectName = CONTACT_OBJECT;
  fields = [FirstName, LastName, Title, Email, Phone, Department, AccountId];

  showToast() {
    const event = new ShowToastEvent({
      title: "Success",
      message: "The contact has been saved successfully!..",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}