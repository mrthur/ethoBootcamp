import { LightningElement, wire, track } from 'lwc';
import selectAll from "@salesforce/apex/SimulacaoContainerController.getRoundsJogadores";

export default class SelecionaRoundContainer extends LightningElement {
    @wire(selectAll) roundsData;
    get rounds() {
        return this.roundsData.data;
    }

    @track objItems = [];
    @track objError;
    @track roundSelecionado = '';
    @wire(selectAll) listOfObjectDetails({ error, data }) {
        if (data) {
            for (var i=0; i < data.length; i++) {
                this.objItems = [...this.objItems, {value: data[i].Id , label: data[i].Name}]
            }
        } else if (error) {
            this.objError = error;
            this.objects = undefined;
        }
    }
    get roundsOptions() {
        return this.objItems;    
    }
    roundSelecionadoChange(event) {
        this.roundSelecionado = event.target.value;
        round = this.roundSelecionado;
        //console.log(event.target.value);
    }

}