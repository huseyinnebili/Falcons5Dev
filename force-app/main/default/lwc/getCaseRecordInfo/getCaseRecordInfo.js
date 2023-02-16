import { LightningElement, wire } from "lwc";

import Reason from "@salesforce/schema/Case.Reason";
import Origin from "@salesforce/schema/Case.Origin";
import Priority from "@salesforce/schema/Case.Priority";
import Type from "@salesforce/schema/Case.Type";
import Status from "@salesforce/schema/Case.Status";
import { getRecord } from "lightning/uiRecordApi";

const Fields = [Reason, Origin, Priority, Type, Status];

export default class GetCaseRecordInfo extends LightningElement {
  recordId = "5008V00001QAxC0QAL";
  caseReason;
  casePriority;
  caseType;
  caseStatus;
  caseOrigin;
  error;

  @wire(getRecord, { recordId: "$recordId", fields: Fields })
  caseHandle({ data, error }) {
    if (data) {
      console.log(data);

      this.caseReason = data.fields.Reason.value;
      this.caseOrigin = data.fields.Origin.value;
      this.caseType = data.fields.Type.value;
      this.caseStatus = data.fields.Status.value;
      this.casePriority = data.fields.Priority.value;
    }

    if (error) {
      console.error(error);
      this.error = error;
    }
  }
}