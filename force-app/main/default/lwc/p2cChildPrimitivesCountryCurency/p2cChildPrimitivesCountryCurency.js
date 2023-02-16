import { LightningElement, api } from "lwc";

export default class P2cChildPrimitivesCountryCurency extends LightningElement {
  @api country;
  @api currency;
}