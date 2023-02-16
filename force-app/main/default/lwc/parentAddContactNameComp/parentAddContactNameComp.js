import { LightningElement } from "lwc";

export default class ParentAddContactNameComp extends LightningElement {
  studentName;
  changeHandler(event) {
    this.studentName = event.target.value;
  }

  handleClick() {
    this.template
      .querySelector("c-child-add-contact-name-comp")
      .addContact(this.studentName);
    this.studentName = "";
  }
}