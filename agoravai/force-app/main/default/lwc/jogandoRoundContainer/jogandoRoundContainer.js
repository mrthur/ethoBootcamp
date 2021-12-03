import { LightningElement, api } from 'lwc';

export default class JogandoRoundContainer extends LightningElement {
    @api round;
    @api jogadores;
}