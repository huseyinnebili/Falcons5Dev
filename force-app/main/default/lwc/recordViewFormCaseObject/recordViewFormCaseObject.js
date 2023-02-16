import { LightningElement } from "lwc";

import Case from "@salesforce/schema/Case";
import Type from "@salesforce/schema/Case.Type";
import Origin from "@salesforce/schema/Case.Origin";
import Status from "@salesforce/schema/Case.Status";
import Priority from "@salesforce/schema/Case.Priority";
import Reason from "@salesforce/schema/Case.Reason";

export default class RecordViewFormCaseObject extends LightningElement {
  recordId = "5008V00001PwF0ZQAV";
  objectApiName = Case;
  fields = {
    type: Type,
    origin: Origin,
    status: Status,
    priority: Priority,
    reason: Reason
  };
}