import { LightningElement } from "lwc";

export default class P2cParentInvokeMethod extends LightningElement {
  handleClick() {
    this.template.querySelector("c-p2c-invoke-method").invokeChild();
  }
}