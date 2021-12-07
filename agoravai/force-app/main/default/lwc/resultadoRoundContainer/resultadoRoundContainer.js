import { LightningElement, api } from "lwc";

export default class ResultadoRoundContainer extends LightningElement {

    @api roundSelecionado;

    get maioresAssassinos() {
        if (this.roundSelecionado) {
            let maiorValor = this.roundSelecionado.Jogadores__r[0].QuantidadeAssassinatos__c;
            return this.roundSelecionado.Jogadores__r.filter(
                (jogador) => jogador.QuantidadeAssassinatos__c === maiorValor
            );
        }
        return [];
    }

}