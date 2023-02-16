import { LightningElement } from 'lwc';

export default class TwoWayDataBinding extends LightningElement {




    getName() {

        this.stdName="Zlatan";

        return this.stdName;
    }

    getFullName(firstName,lastName){

        this.fullName=firstName+lastName;

        return this.fullName;
    }

    name='Zlatan';
    title='Salesforce Developer';

    handleChange(event){

        this.title=event.target.value;


    }
}