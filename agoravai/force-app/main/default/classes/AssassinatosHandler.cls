public with sharing class AssassinatosHandler {

    public static void execute() {
        List<Jogador__c> jogadores = new List<Jogador__c>();//JogadoresSelector.selectJogadoresNaoEliminados(statusList);
        Assassinato__c ass = execute(jogadores);
        if (ass != null) {
            insert ass;
        }        
    }

    public static Assassinato__c execute(List<Jogador__c> jogadores) {
        Set<String> statusList = new Set<String>{'Em Andamento'};

        //TODO: validar se a lista de jogadores é de pelo menos 2

        Integer totalJogadoresNaoEliminados = jogadores.size();

        Integer aleatorio1 = Utils.geraNumero(0, totalJogadoresNaoEliminados -1, null);
        Integer aleatorio2 = Utils.geraNumero(0, totalJogadoresNaoEliminados -1, aleatorio1);

        Jogador__c assassino = new Jogador__c();
        assassino = jogadores.get(aleatorio1);
        Jogador__c assassinado = new Jogador__c();
        assassinado = jogadores.get(aleatorio2);

        return confronto(assassino, assassinado, false);
    }

    @TestVisible
    private static Assassinato__c confronto(Jogador__c atacante, Jogador__c defensor, Boolean contraAtaque) {
        Assassinato__c ass;
        Integer dadoAtaque = Utils.geraNumero(1, 20, null);
        Boolean ataqueVenceu = ataqueVenceuDefesa(dadoAtaque, atacante, defensor);
        if (ataqueVenceu) { //se o ataque venceu, já registra a informacao e acabou.
            ass = registraAssassinato(atacante, defensor);
        } else { //não conseguiu matar
            //TODO: colocar esse IF como funcao, para 1)manter o padrao e 2)se a regra de negocio aumentar, o codigo ja esta pronto
            if (dadoAtaque == 1 && !contraAtaque) { //e tirou 1 no dado D20 E não é contra-ataque, contra-ataca
                confronto(defensor, atacante, true);
            }
        }

        return ass;
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
    private static Assassinato__c registraAssassinato(Jogador__c assassino, Jogador__c assassinado) {
        return new Assassinato__c(
            Assassinado__c = assassinado.Id,
            Assassino__c = assassino.Id,
            DataHora__c =  System.now()
        );
    }
}