import { LightningElement } from "lwc";

export default class TemplatingLoopingStudentObject extends LightningElement {
  students = [
    {
      id: 1,
      studentName: "Zlatan",
      branchName: "Math"
    },
    {
      id: 2,
      studentName: "Anna",
      branchName: "Science"
    },
    {
      id: 3,
      studentName: "Isabella",
      branchName: "Java Developer"
    }
  ];
}