import { LightningElement } from "lwc";

export default class DiplayListOfCountries extends LightningElement {
  countries = ["United States", "Germany", "Canada", "France", "Italy"];

  get displayCountry() {
    return this.countries;
  }
}