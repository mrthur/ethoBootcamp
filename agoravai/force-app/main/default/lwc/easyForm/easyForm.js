import { LightningElement } from 'lwc';

export default class EasyForm extends LightningElement {
    changeNome(event) {
        alert(event.target.value);
    }
}