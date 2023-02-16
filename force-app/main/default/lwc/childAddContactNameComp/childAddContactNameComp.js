import { LightningElement, track, api } from "lwc";

export default class ChildAddContactNameComp extends LightningElement {
  @track lstOfContacts = ["Ismael", "Anna", "Berk"];

  @api addContact(studentName) {
    this.lstOfContacts.push(studentName);
  }
}