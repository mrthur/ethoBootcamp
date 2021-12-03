import { LightningElement, wire, track } from 'lwc';
import selectAll from "@salesforce/apex/SimulacaoContainerController.getRoundsJogadores";
//import selectAssassinatos from "@salesforce/apex/SimulacaoContainerController.getAssassinatosByRound";

export default class JogarContainer extends LightningElement {
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
        //console.log(event.target.value);
        this.jogadoresRound();
    }

    listaJogadores = [];
    jogadoresRound() {
        this.listaJogadores = [];
        
        for (var i = 0; i < this.roundsData.data.length; i++) {
            for (var j = 0; j < this.roundsData.data[i].Jogadores__r.length; j++) {

                if (this.roundsData.data[i].Id == this.roundSelecionado) {
                    
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

    //@wire(selectAssassinatos) assassinatosData;
    //get()
}