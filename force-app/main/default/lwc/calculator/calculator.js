import { LightningElement } from "lwc";

export default class Calculator extends LightningElement {
  num1 = 0;
  num2 = 0;
  total = 0;

  changeHandler(event) {
    var comp = event.target.name;

    if (comp === "num1") {
      this.num1 = event.target.value;
    } else {
      this.num2 = event.target.value;
    }
    this.total = Number(this.num1) + Number(this.num2);
  }
}