import { LightningElement } from "lwc";

export default class ChildComponentProgressBar extends LightningElement {
  progressValue;

  handleChange(event) {
    this.progressValue = event.target.value;

    //create Custom Event with action
    const selectedEvent = new CustomEvent("progressvaluechange", {
      detail: this.progressValue
    });

    this.dispatchEvent(selectedEvent);
  }
}