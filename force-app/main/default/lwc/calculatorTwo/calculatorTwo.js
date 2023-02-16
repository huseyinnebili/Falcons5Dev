import { LightningElement } from "lwc";

export default class CalculatorTwo extends LightningElement {
  num1 = 0;
  num2 = 0;
  total = 0;

  changeHandler(event) {
    var com = event.target.name;

    if (com === "num1") {
      this.num1 = event.target.value;
    } else {
      this.num2 = event.target.value;
    }
    this.total = Number(this.num1) * Number(this.num2);
  }
}