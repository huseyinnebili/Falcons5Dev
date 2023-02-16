import { LightningElement } from "lwc";

export default class MyRegistrationCard extends LightningElement {
  username = "zlatan@gmail.com";
  password = "123@zltan";
  age = 41;
  gender;

  get genders() {
    return [
      { label: "Male", value: "male" },
      { label: "Female", value: "female" },
      { label: "Other", value: "other" }
    ];
  }

  handleChange(event) {
    this.gender = event.detail.value;
  }

  changeHandler(event) {
    var com = event.target.name;

    if (com === "username") {
      this.username = event.target.value;
    } else if (com === "password") {
      this.password = event.target.value;
    } else {
      this.age = event.target.value;
    }
  }
}