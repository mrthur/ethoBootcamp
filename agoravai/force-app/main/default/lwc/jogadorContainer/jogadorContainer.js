import { api, LightningElement } from 'lwc';

export default class JogadorContainer extends LightningElement {
    @api jogador;
    @api index;
}