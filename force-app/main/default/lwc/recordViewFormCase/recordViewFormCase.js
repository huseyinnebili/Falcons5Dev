import { LightningElement } from "lwc";

import CASE from "@salesforce/schema/Case";
import Origin from "@salesforce/schema/Case.Origin";
import Reason from "@salesforce/schema/Case.Reason";
import PotentialLiability from "@salesforce/schema/Case.PotentialLiability__c";
import Type from "@salesforce/schema/Case.Type";
import Status from "@salesforce/schema/Case.Status";
import ProductId from "@salesforce/schema/Case.ProductId";
export default class RecordViewFormCase extends LightningElement {
  recordId = "5008V00001QAxC2QAL";
  objectApiName = CASE;

  showCase = true;
  fields = {
    Origin,
    Reason,
    PotentialLiability,
    Type,
    Status,
    ProductId
  };
}