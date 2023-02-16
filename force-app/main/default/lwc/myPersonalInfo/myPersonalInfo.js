import { LightningElement, track } from "lwc";

export default class MyPersonalInfo extends LightningElement {
  @track myInfo = {
    firstName: "Zlatan",
    lastName: "Obran",
    age: 42,
    state: "NJ"
  };

  showContent = false;

  handleClick() {
    this.showContent = true;
  }

  handleChangeFirstName(event) {
    this.myInfo.firstName = event.target.value;
  }
  handleChangeLastName(event) {
    this.myInfo.lastName = event.target.value;
  }
  handleChangeAge(event) {
    this.myInfo.age = event.target.value;
  }
  handleChangeState(event) {
    this.myInfo.state = event.target.value;
  }
}