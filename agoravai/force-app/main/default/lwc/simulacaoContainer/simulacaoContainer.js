import { LightningElement, wire, track } from 'lwc';
import selectAll from "@salesforce/apex/SimulacaoContainerController.getRoundsJogadores";

export default class SimulacaoContainer extends LightningElement {
    @wire(selectAll) roundsData;

    get rounds() {
        return this.roundsData.data;
    }

    //http://sfdccodepractices.blogspot.com/2020/10/lwc-combobox-example.html

    //variable responsibles for holding the array for records with value & label.
    @track objItems = [];
    //variable responsibles for holding errors.
    @track objError;
    //variable responsibles for holding the selected object value of combo-box.
    @track selectedObjValue = '';

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

    //Return list of Objects for combobox.
    get objectOptions() {
        return this.objItems;    
    }

    nomeRound='';
    @track roundId;
    //Holding onchange object under tracking variable 'selectedObjValue'.
    handleObjectChange(event) {
        this.roundId = event.target.value;

        this.selectedObjValue = event.detail.value;
        this.nomeRound = event.target.options.find(opt => opt.value === event.detail.value).label;
        this.jogadoresRound(this.selectedObjValue);
    }

    selecionouRound = false;
    listaJogadores = [];
    jogadoresRound(roundSelecionado) {
        this.listaJogadores = [];
        
        for (var i = 0; i < this.roundsData.data.length; i++) {
            for (var j = 0; j < this.roundsData.data[i].Jogadores__r.length; j++) {

                if (this.roundsData.data[i].Id == roundSelecionado) {
                    
                    let novoItem = {
                        'Id': this.roundsData.data[i].Jogadores__r[j].Id,
                        'Name': this.roundsData.data[i].Jogadores__r[j].Name,
                        'Candidato': this.roundsData.data[i].Jogadores__r[j].Candidato__r.Name
                    }
                    this.listaJogadores.push(novoItem);
                }
            }
        }
        
    }

    /*
    @wire(selectAll) jogadoresRound({ error, data }) {
        if (data) {
            for (var i=0; i < data.length; i++) {
                for (var j=0; j < data[i].Jogadores__r.length; j++) {

                    let novoItem = {
                        'Id': data[i].Jogadores__r[j].Id,
                        'Name': data[i].Jogadores__r[j].Name,
                        'Candidato': data[i].Jogadores__r[j].Candidato__r.Name
                    }
                    this.listaJogadores.push(novoItem);
                }
            }
        } else if (error) {
            this.objError = error;
            this.objects = undefined;
        }
    }
    */

    startSimulationClick(event) {
        alert(this.roundsData.data);
        alert(listaJogadores);
    }



}