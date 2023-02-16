import { LightningElement, track } from "lwc";

export default class MySchoolInfoChart extends LightningElement {
  @track mySchool = {
    graduatedSchool: "Marmara",
    graduatedYear: 2001,
    graduatedDegree: 68
  };

  handleChange(event) {
    this.mySchool.graduatedSchool = event.target.value;
  }

  showContent = false;

  handleClick() {
    this.showContent = true;
  }

  myFavouriteSnacks = ["Almond", "Walnut", "Peanut", "Hazelnut"];

  get mySnackList() {
    return "My favourite snacks are " + this.myFavouriteSnacks;
  }
  handleSnack(event) {
    this.mySnackList = event.target.value;
  }
}