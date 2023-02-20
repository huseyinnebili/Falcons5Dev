import { LightningElement, api } from "lwc";
import createOpportunity from "@salesforce/apex/updateContact.createOpportunities";
import updateSubscription from "@salesforce/apex/updateContact.updateSubscription";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateRecordViaTriger extends LightningElement {
  @api recordId;
  @api listViewIds;
  @api accountId;
  @api subscriptionIds;

  connectedCallback() {
    var objectData;
    if(this.subscriptionIds){
          var objectData =  this.subscriptionIds.toString().substring(1, this.subscriptionIds.toString().length-1);
          console.log('objectData '+objectData);
      }
    console.log('objectData '+typeof objectData);
    console.log('accountId '+this.accountId);
    var accountId = this.accountId.toString();
    console.log('accountId '+typeof accountId);
    updateSubscription({
      accountId: accountId,
      subscriptions: objectData
      
    })
      .then((data) => {
        if (data) {
          console.log("data : " + data);

          let result = data;
          if (result != null) {
            console.log("result : " + result);
            alert('Record has been created succesfully.');
            this.successNotification("Record has been created succesfully.");
            console.log("result2 : " + result);
          }
        }
      })
      .catch((error) => {
        this.showCopyModalSpinner = true;
        this.errorNotification(error.body.message);
      });
  }

  successNotification(message) {
    const evt = new ShowToastEvent({
      title: "Success",
      message: message,
      variant: "success"
    });
    this.dispatchEvent(evt);
  }

  errorNotification(message) {
    const evt = new ShowToastEvent({
      title: "Error",
      message: message,
      variant: "error"
    });
    this.dispatchEvent(evt);
  }
}
//   handleClick() {
//     createOpportunities({ accountIds: this.recordId })
//       .then((result) => {
//         console.log(result);
//         this.dispatchEvent(
//           new ShowToastEvent({
//             title: "Success",
//             message: "Opportunity created",
//             variant: "success"
//           })
//         );
//       })
//       .catch((error) => {
//         console.error(error);
//         this.dispatchEvent(
//           new ShowToastEvent({
//             title: "Error creating Opportunity",
//             message: error.message,
//             variant: "error"
//           })
//         );
//       });
//   }

//   creatToast(title, message, variant) {
//     const toast = new ShowToastEvent({ title, message, variant });
//     this.dispatchEvent(toast);
//   }
// }