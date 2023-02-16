import { LightningElement } from "lwc";

export default class ConditionalRenderingTwo extends LightningElement {
  showContent = false;

  handleClick() {
    this.showContent = true;
  }
}