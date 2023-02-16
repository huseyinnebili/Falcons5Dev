import { LightningElement } from "lwc";

export default class MyUsernameAndCity extends LightningElement {
  username = "zlatan";

  city;

  get cities() {
    return [
      { label: "Wayne", value: "wayne" },
      { label: "Passaic", value: "passaic" },
      { label: "Clifton", value: "clifton" }
    ];
  }

  handleCitiesChange(event) {
    this.city = event.detail.value;
  }
  handleUsernameChange(event) {
    this.username = event.target.value;
  }
}