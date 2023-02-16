import { LightningElement } from "lwc";

export default class ChildModal extends LightningElement {
  clickHandler() {
    //create an event named close and sent it

    const closeEvent = new CloseEvent("close", { bubbles: false });
    this.dispatchEvent(closeEvent);

    console.log("close event has been created and sent with bubbles option");
  }

  divHandler() {
    console.log("div handler which is a step up to button has been called");
  }

  topDivHandler() {
    console.log("div handler which is two steps up to button has been called");
  }
}