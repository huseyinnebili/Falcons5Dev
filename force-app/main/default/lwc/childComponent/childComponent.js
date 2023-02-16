import { LightningElement } from "lwc";

export default class ChildComponent extends LightningElement {
  display() {
    console.log("Hello");
  }
}