import { LightningElement, track } from "lwc";

export default class ParentLwcComponent extends LightningElement {
  @track parentValue = 100;

  handleChild() {
    if (this.parentValue === 100) {
      this.parentValue = 200;
    } else {
      this.parentValue = 100;
    }
  }
}