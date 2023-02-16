import { LightningElement } from "lwc";

export default class DisplayContactInformation extends LightningElement {
  contacts = [
    {
      name: "Anna",
      title: "Executive Chairman",
      company: "Tech Solution",
      stay: "United States"
    },
    {
      name: "Rodriques",
      title: "Chief Executive Chairman",
      company: "Alliance Solution",
      stay: "United Kingdom"
    },
    {
      name: "Gabriel",
      title: "Chief Executive Officer",
      company: "Facebook",
      stay: "Canada"
    }
  ];
}