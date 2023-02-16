import { LightningElement } from "lwc";

export default class MyNameAndRole extends LightningElement {
  username = "Zlatan";
  role;

  handleChange(event) {
    this.username = event.target.value;
  }

  get roles() {
    return [
      { label: "Salesforce Admin", value: "Salesforce Admin" },
      { label: "Salesforce Developer", value: "Salesforce Developer" },
      { label: "Salesforce Architech", value: "Salesforce Architech" }
    ];
  }

  handleRoleChange(event) {
    this.role = event.detail.value;
  }
}