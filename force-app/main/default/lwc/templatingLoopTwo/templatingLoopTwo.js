import { LightningElement } from "lwc";

export default class TemplatingLoopTwo extends LightningElement {
  accounts = [
    {
      id: 1,
      name: "Soft Innovas",
      type: "Education"
    },

    {
      id: 2,
      name: "Facebook",
      type: "Social Networking"
    },

    { id: 3, name: "Apple", type: "Technology" }
  ];
}