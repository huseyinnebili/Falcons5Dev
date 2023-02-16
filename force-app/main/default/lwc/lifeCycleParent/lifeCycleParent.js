import { LightningElement } from "lwc";

export default class LifeCycleParent extends LightningElement {
  //we create three hooks called Construcor,connectedCallback,and renderedCallback
  constructor() {
    super();

    console.log("Parent constructor called!..");
  }

  //Generally connectedCallbachk is used!...
  connectedCallback() {
    console.log("Parent connectedCallBack called!..");
  }

  //Never use renderedCallback!...
  renderedCallback() {
    console.log("Parent renderedCallback called!..");
  }

  disconnectedCallback() {
    console.log("Parent disconnectedCallback called!..");
  }

  input;

  changeHandler(event) {
    this.input = event.target.value;
  }

  showChild = true;

  childHandler() {
    this.showChild = false;
  }
}