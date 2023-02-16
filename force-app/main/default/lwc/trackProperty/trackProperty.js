import { LightningElement, track } from "lwc";

export default class TrackProperty extends LightningElement {
  @track contact = {
    name: "Steve",
    state: "United States",
    company: "Apple"
  };

  handleChange(event) {
    this.contact.state = event.target.value;
  }
}