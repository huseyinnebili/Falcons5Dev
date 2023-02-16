import { LightningElement } from "lwc";

export default class PaymentInformationTemplateLooping extends LightningElement {
  payments = [
    {
      id: 1,
      type: "Internet Allowance",
      amount: 100.0,
      paid: true
    },

    { id: 2, type: "Work From Home Allowance", amount: 200.0, paid: false },

    { id: 1, type: "Well Being Allowance", amount: 1000.0, paid: true }
  ];
}