import { LightningElement } from "lwc";

export default class ChildLwcComponent extends LightningElement {
  handleClick() {
    const selectedEvent = new CustomEvent("clickme");
    this.dispatchEvent(selectedEvent);
  }
}