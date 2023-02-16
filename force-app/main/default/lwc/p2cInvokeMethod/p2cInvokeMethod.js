import { LightningElement, api, track } from "lwc";

export default class P2cInvokeMethod extends LightningElement {
  @track value = 100;
  @api invokeChild() {
    if (this.value === 100) {
      this.value = 200;
    } else {
      this.value = 100;
    }
  }
}