import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {

    name='Salesforce Developer';
    experience =3;
    fruits=['Apple','Orange','Pineapple'];
    //experience=[3,6,8,12,43];
    location={

        city:'New Jersey',
        country:'USA',
        postalcode:'07470'
    };

   
}