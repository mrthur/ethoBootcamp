import { api, LightningElement } from "lwc";

export default class JogadorContainer extends LightningElement {
  @api jogador;

  get vivoMortoClass() {

    //console.log('qtd assassinatos: '+this.jogador.Name +' | '+ this.jogador.QuantidadeAssassinatos__c);


    return this.jogador.Morreu__c ? "morto" : "vivo";
  }

}