import { LightningElement } from "lwc";

export default class Getters extends LightningElement {
  names = ["Anna", "Kenedy", "Isabella"];

  num1 = 10;
  num2 = 20;

  num3 = "20";
  num4 = "30";

  get multiplyNums() {
    var mul = this.num1 * this.num2;

    return mul;
  }

  get firstname() {
    return this.names[1];
  }

  get sumOfNums() {
    return Number(this.num3) + Number(this.num4);
  }
}