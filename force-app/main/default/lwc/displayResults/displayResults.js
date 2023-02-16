import { LightningElement, api } from "lwc";

export default class DisplayResults extends LightningElement {
  @api results;
  @api columns;
}