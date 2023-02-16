import { LightningElement, wire } from "lwc";
import AssistantName from "@salesforce/schema/Contact.AssistantName";
import AssistantPhone from "@salesforce/schema/Contact.AssistantPhone";
import CleanStatus from "@salesforce/schema/Contact.CleanStatus";
import Description from "@salesforce/schema/Contact.Description";
import Email from "@salesforce/schema/Contact.Email";
import HomePhone from "@salesforce/schema/Contact.HomePhone";
import LeadSource from "@salesforce/schema/Contact.LeadSource";
import { getRecord } from "lightning/uiRecordApi";

const FIELDS = [
  AssistantName,
  CleanStatus,
  AssistantPhone,
  Description,
  Email,
  HomePhone,
  LeadSource
];

export default class GetRecordOnContact extends LightningElement {
  recordId = "0038V00002ZTJiMQAX";
  conAssistantPhone;
  conAssistantName;
  conCleanStatus;
  conDescription;
  conEmail;
  conHomePhone;
  conLeadSource;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  getRecordInfo({ data, error }) {
    if (data) {
      console.log(data);

      this.conAssistantPhone = data.fields.AssistantPhone.value;
      this.conAssistantName = data.fields.AssistantName.value;
      this.conCleanStatus = data.fields.CleanStatus.value;
      this.conDescription = data.fields.Description.value;
      this.conEmail = data.fields.Email.value;
      this.conHomePhone = data.fields.HomePhone.value;
      this.conLeadSource = data.fields.LeadSource.value;
    }

    if (error) {
      console.error(error);
    }
  }
}