import { LightningElement } from "lwc";

export default class ParentDetailTwo extends LightningElement {
  showModal = false;
  showHandler() {
    this.showModal = true;
  }

  parentCloseHandler() {
    this.showModal = false;
  }
}