public with sharing class AssassinatosHandler {
    public static void execute() {
        Set<String> statusList = new Set<String>{'Em Andamento'};
        List<Jogador__c> jogadores = JogadoresSelector.selectJogadoresNaoEliminados(statusList);

        //TODO: validar se a lista de jogadores é de pelo menos 2

        Integer totalJogadoresNaoEliminados = jogadores.size();

        Integer aleatorio1 = Utils.geraNumero(0, totalJogadoresNaoEliminados -1, null);
        Integer aleatorio2 = Utils.geraNumero(0, totalJogadoresNaoEliminados -1, aleatorio1);

        Jogador__c assassino = new Jogador__c();
        assassino = jogadores.get(aleatorio1);
        Jogador__c assassinado = new Jogador__c();
        assassinado = jogadores.get(aleatorio2);

        confronto(assassino, assassinado, false);
    }

    @TestVisible
    private static void confronto(Jogador__c atacante, Jogador__c defensor, Boolean contraAtaque) {
        Integer dadoAtaque = Utils.geraNumero(1, 20, null);
        Boolean ataqueVenceu = ataqueVenceuDefesa(dadoAtaque, atacante, defensor);
        if (ataqueVenceu) { //se o ataque venceu, já registra a informacao e acabou.
            registraAssassinato(atacante, defensor);

        } else { //não conseguiu matar
            //TODO: colocar esse IF como funcao, para 1)manter o padrao e 2)se a regra de negocio aumentar, o codigo ja esta pronto
            if (dadoAtaque == 1 && !contraAtaque) { //e tirou 1 no dado D20 E não é contra-ataque, contra-ataca
                confronto(defensor, atacante, true);
            }
        }
    }

    //TODO: retirar os return false desnecessarios
    @TestVisible
    private static Boolean ataqueVenceuDefesa(Integer valorD20, Jogador__c atacante, Jogador__c defensor) {
        if (atacante != null && defensor != null) {
            //TODO: testar forca, inteligencia, velocidade null E tratar, pois já vi que dá erro
            //TODO: criar uma funcao para a jogada dos dados, para manter o padrao de codigo
            Integer ataque = valorD20 + atacante.Forca__c.intValue();
            Integer defesa = Utils.geraNumero(1, 10, null) + Utils.geraNumero(1, 10, null) + defensor.Inteligencia__c.intValue() + defensor.Velocidade__c.intValue();
            if (ataque > defesa) { //se o ataque acertou
                return true;
            } else {
                return false;
            }
        } else return false;
    }

    @TestVisible
    private static void registraAssassinato(Jogador__c assassino, Jogador__c assassinado) {
        Assassinato__c jogadorAssassinado = new Assassinato__c(
            Assassinado__c = assassinado.Id,
            Assassino__c = assassino.Id,
            DataHora__c =  System.now()
        );
        insert jogadorAssassinado; //lembrando que tem o trigger aqui
    }
}