import { LightningElement } from "lwc";

export default class QuerySelectors extends LightningElement {
  fruits = ["Apple", "Orange", "Banana", "Watermelon"];

  clickHandler() {
    //one element
    const elem = this.template.querySelector("h1");
    console.log(elem.innerText);
    elem.style.border = "2px solid green";
    elem.style.backgroundColor = "red";
    elem.setAttribute("class", "slds-align_absolute-center");

    //multiple element
    const fruitElements = this.template.querySelectorAll(".fruit");
    fruitElements.forEach((item) => {
      console.log(item.innerText);
      item.style.border = "2px solid darkred";
      item.style.backgroundColor = "green";
      item.setAttribute("class", "slds-align_absolute-center");
    });
  }
}