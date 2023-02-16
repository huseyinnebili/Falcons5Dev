import { LightningElement } from "lwc";

export default class ChildModalTwo extends LightningElement {
  clickHandler() {
    const closeEvent = new CloseEvent("close");
    this.dispatchEvent(closeEvent);
  }
}