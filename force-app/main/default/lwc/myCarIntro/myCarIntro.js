import { LightningElement, track } from "lwc";

export default class MyCarIntro extends LightningElement {
  @track myCar = {
    carMake: "Toyota",
    carModel: "Sienna",
    carYear: 2022
  };
  handleChangeMake(event) {
    this.myCar.carMake = event.target.value;
  }

  //   handleChangeModel(event) {
  //     this.myCar.carModel = event.target.value;
  //   }

  //   handleChangeYear(event) {
  //     this.myCar.carYear = event.target.value;
  //   }
}