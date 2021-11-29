public with sharing class AssassinatosHandler {
    public static void execute() {
        //lista de jogadores não eliminados
        List<Jogador__c> jogadores = JogadoresSelector.selectJogadoresNaoEliminados();

        //total de jogadores nao eliminados, -1 pois começa em zero
        Integer totalJogadoresNaoEliminados = jogadores.size() - 1;
        //pega o id da lista para os jogadores aleatorioriamente, desconsiderando o primeiro resultado para o jogador 2
        Integer aleatorio1 = Utils.geraNumero(0, totalJogadoresNaoEliminados, null);
        Integer aleatorio2 = Utils.geraNumero(0, totalJogadoresNaoEliminados, aleatorio1);

        Jogador__c assassino = new Jogador__c();
        assassino = jogadores.get(aleatorio1);
        Jogador__c assassinado = new Jogador__c();
        assassinado = jogadores.get(aleatorio2);

        //faz o confronto entre assassino e assassinado
        confronto(assassino, assassinado, false);
    }

    @TestVisible
    private static void confronto(Jogador__c atacante, Jogador__c defensor, Boolean contraAtaque) {
        Integer dadoAtaque = Utils.geraNumero(1, 20, null);
        Boolean ataqueVenceu = ataqueVenceuDefesa(dadoAtaque, atacante, defensor);
        if (ataqueVenceu) { //se o ataque venceu, já registra a informacao e acabou.
            Assassinato__c jogadorAssassinado = new Assassinato__c(
                Assassinado__c = defensor.Id,
                Assassino__c = atacante.Id,
                DataHora__c =  System.now()
            );
            insert jogadorAssassinado; //lembrando que tem o trigger aqui

        } else { //não conseguiu matar
            if (dadoAtaque == 1 && !contraAtaque) { //e tirou 1 no dado D20 E não é contra-ataque, contra-ataca
                contraAtaque = true;
                confronto(defensor, atacante, contraAtaque);
            }
        }
    }

    @TestVisible
    private static Boolean ataqueVenceuDefesa(Integer valorD20, Jogador__c atacante, Jogador__c defensor) {
        if (atacante != null && defensor != null) {
            Integer ataque = valorD20 + atacante.Forca__c.intValue();
            Integer defesa = Utils.geraNumero(1, 10, null) + Utils.geraNumero(1, 10, null) + defensor.Inteligencia__c.intValue() + defensor.Velocidade__c.intValue();
            if (ataque > defesa) { //se o ataque acertou
                return true;
            } else {
                return false;
            }
        } else return false;
    }
}