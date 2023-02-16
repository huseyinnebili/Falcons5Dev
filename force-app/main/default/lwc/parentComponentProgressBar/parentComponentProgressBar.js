import { LightningElement } from "lwc";
//Create a child component with input type number and any update on this input box,
//the progress bar should update in the Parent component(custom event should be handled in parent comp.)

//Handle the custom event in parent component coming from child component

export default class ParentComponentProgressBar extends LightningElement {
  progressValue = 50;

  handleProgress(event) {
    this.progressValue = event.detail;
  }
}