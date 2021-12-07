import { LightningElement, wire } from "lwc";
import selectAll from "@salesforce/apex/SimulacaoContainerController.getRoundsJogadores";
import tentarMatar from "@salesforce/apex/SimulacaoContainerController.tentativaAssassinato";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class JogarContainer extends LightningElement {
  //aux = { Name: "Bla" };
  rounds = [];
  roundSelecionado;
  @wire(selectAll) listOfObjectDetails({ error, data }) {
    if (data) {
      this.rounds = data;
    } else if (error) {
      console.log("error: " + error);
    }
  }

  get roundsCombobox() {
    if (!this.rounds) {
      return [];
    }

    return [
      ...this.rounds.map((round) => {
        return {
          label: round.Name,
          value: round.Id
        };
      })
    ];
  }

  roundSelecionadoChange(event) {
    this.roundSelecionado = event.target.value;
  }

  get roundSelecionadoCerto() {
    if (this.rounds) {
      return this.rounds.find((round) => round.Id == this.roundSelecionado);
    }
    return {};
  }

  handleClick(event) {
    event.preventDefault();
    //this.aux.Name = "Ble";
    //this.aux = { ...this.aux, Name: "Ble" };
    tentarMatar({ jogadores: this.roundSelecionadoCerto.Jogadores__r })
      .then((result) => {
        if (result) {
          const assassinato = result.Assassinato;
          if (assassinato) {
            const assassino = this.getJogadorById(assassinato.Assassino__c);
            const assassinado = this.getJogadorById(assassinato.Assassinado__c);
            this.rounds = result.Rounds;
            //this.updateRound(assassinato.Assassinado__c);
            let message = "Assassino: " + assassino.Name + "\n";
            message += "Assassinado: " + assassinado.Name;
            this.showToast("Assassinato", message, "success", "sticky");
          } else {
            this.showToast(
              "Assassinato",
              "Ninguém morreu",
              "warning",
              "sticky"
            );
          }
        }
      })
      .catch((error) => {
        console.log("erro: " + JSON.stringify(error));
      });
  }

  getJogadorById(id) {
    return this.roundSelecionadoCerto.Jogadores__r.find(
      (jogador) => jogador.Id == id
    );
  }

  showToast(title, message, variant, mode) {
    const event = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant,
      mode: mode
    });
    this.dispatchEvent(event);
  }

  updateRound(idAssassinado) {
    let round = this.roundSelecionadoCerto;
    let jogadoresRound = [...round.Jogadores__r];
    jogadoresRound = [
      ...jogadoresRound.map((jogador) => {
        if (jogador.Id == idAssassinado) {
          return { ...jogador, Morreu__c: true };
        }
        return { ...jogador };
      })
    ];

    round = { ...round, Jogadores__r: jogadoresRound };
    this.rounds = [
      ...this.rounds.map((roundAux) => {
        if (roundAux.Id == round.Id) {
          return { ...round };
        }
        return { ...roundAux };
      })
    ];
  }
}