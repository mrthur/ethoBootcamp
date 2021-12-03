import { LightningElement, wire } from 'lwc';
import selectAll from "@salesforce/apex/RoundsContainerController.getRoundsJogadores";

export default class RoundsContainer extends LightningElement {
    @wire(selectAll)
    roundsData;

    get rounds() {
        return this.roundsData.data;
    }
}