import { LightningElement } from "lwc";

export default class LifeCycleChild extends LightningElement {
  //we create three hooks called Construcor,connectedCallback,and renderedCallback
  constructor() {
    super();

    console.log("Child constructor called!..");
  }
  connectedCallback() {
    console.log("Child connectedCallBack called!..");
  }

  renderedCallback() {
    console.log("Child renderedCallback called!..");
  }
}