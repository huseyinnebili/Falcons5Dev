import { LightningElement } from "lwc";

export default class MyRegistrationChart extends LightningElement {
  email = "zlatan@gmail.com";
  password = "zlt@1234";

  handleEmail(event) {
    this.email = event.target.value;
  }

  handlePassword(event) {
    this.password = event.target.value;
  }
}