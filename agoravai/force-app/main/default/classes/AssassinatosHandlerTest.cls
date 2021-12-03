@isTest
public with sharing class AssassinatosHandlerTest {
    //private static void confronto(Jogador__c atacante, Jogador__c defensor, Boolean contraAtaque)
    //public static void execute()

    @isTest
    static void registraAssassinatoTest() {
        /*TESTES
        1. assassino e assassinado preenchidos
        2. assassino null
        3. assassinado null
        4. os 2 null
        */
        //prepara
        Jogador__c assassino = new Jogador__c(Id='a015f000009o0lfAAA');
        Jogador__c assassinado = new Jogador__c(Id='a015f00000Cnhc0AAB');
        //executa
        Test.startTest();
        AssassinatosHandler.registraAssassinato(assassino, assassinado);
        AssassinatosHandler.registraAssassinato(null, assassinado);
        AssassinatosHandler.registraAssassinato(assassino, null);
        AssassinatosHandler.registraAssassinato(null, null);
        Test.stopTest();
        //relatorio
    }

    @isTest
    static void ataqueVenceuDefesaTest() {
        /* TESTES
        1. ataque maior que defesa
        2. defesa maior que ataque
        3. ataque menor que defesa E d20 = 1***
        3. ataque null
        4. defesa null
        */
        //prepara o teste
        Jogador__c atacante = new Jogador__c(Id='a015f000009o0lfAAA', Forca__c = 10);
        Jogador__c defensorQueVive = new Jogador__c(Id='a015f00000Cnhc0AAB', Velocidade__c = 1, Inteligencia__c = 10);
        Jogador__c defensorQueMorre = new Jogador__c(Id='a015f00000Cnhc0AAB', Velocidade__c = 1, Inteligencia__c = 1);

        //executa o teste
        Test.startTest();
        Boolean ataqueVenceu = AssassinatosHandler.ataqueVenceuDefesa(13, atacante, defensorQueMorre);
        Boolean ataquePerdeu = AssassinatosHandler.ataqueVenceuDefesa(2, atacante, defensorQueVive);
        Boolean ataquePerdeuFalhaCritica = AssassinatosHandler.ataqueVenceuDefesa(1, atacante, defensorQueVive);
        Boolean atacanteNull = AssassinatosHandler.ataqueVenceuDefesa(5, null, defensorQueVive);
        Boolean defensorNull = AssassinatosHandler.ataqueVenceuDefesa(5, atacante, null);
        Boolean tudoNull = AssassinatosHandler.ataqueVenceuDefesa(5, null, null);
        Test.stopTest();
        //relatorio de teste
        System.assertEquals(true, ataqueVenceu, 'O atacante deveria vencer (true), retornou '+ataqueVenceu);
        System.assertEquals(false, ataquePerdeu, 'O atacante deveria perder (false), retornou '+ataquePerdeu);
        System.assertEquals(false, ataquePerdeuFalhaCritica, 'O atacante deveria perder (false) com D1, retornou '+ataquePerdeuFalhaCritica);
        System.assertEquals(false, atacanteNull, 'O atacante sendo null, tem que retornar false, retornou '+atacanteNull);
        System.assertEquals(false, tudoNull, 'Os 2 sendo null, tem que retornar false, retornou '+tudoNull);
    }

    @isTest
    static void confrontoTest() {
        /* TESTES
        1. ataque vence
        2. defesa vence
        3. contra-ataque
        */
        //Prepara o teste
        Jogador__c atacante = new Jogador__c(Id='a015f000009o0lfAAA', Forca__c = 10);
        Jogador__c defensorQueVive = new Jogador__c(Id='a015f00000Cnhc0AAB', Velocidade__c = 1, Inteligencia__c = 10);
        Jogador__c defensorQueMorre = new Jogador__c(Id='a015f00000Cnhc0AAB', Velocidade__c = 1, Inteligencia__c = 1);
        Test.startTest();
        //private static void confronto(Jogador__c atacante, Jogador__c defensor, Boolean contraAtaque)
        AssassinatosHandler.confronto(atacante, defensorQueVive, false);
        AssassinatosHandler.confronto(atacante, defensorQueVive, true);
        AssassinatosHandler.confronto(atacante, defensorQueMorre, false);
        AssassinatosHandler.confronto(atacante, defensorQueMorre, true);
        Test.stopTest();
        //Executa o teste
        //Relatorio do teste
    }

    @isTest
    static void executeTest() {
        //Prepara o teste
        Round__c roundAtivo = new Round__c(Status__c='Em Andamento');
        insert roundAtivo;
        List<Round__c> rounds = [SELECT Id FROM Round__c];
        Id roundId = rounds.get(0).Id;
        Jogador__c jogador1 = new Jogador__c(Eliminado__c = false, Round__c=roundId);
        Jogador__c jogador2 = new Jogador__c(Eliminado__c = true, Round__c=roundId);
        Jogador__c jogador3 = new Jogador__c(Eliminado__c = false, Round__c=roundId);
        Jogador__c jogador4 = new Jogador__c(Eliminado__c = false, Round__c=roundId);
        Jogador__c jogador5 = new Jogador__c(Eliminado__c = true, Round__c=roundId);
        //List<Jogador__c> jogadores = new List<Jogador__c>{jogador1, jogador2, jogador3, jogador4, jogador5};
        List<Jogador__c> jogadores = new List<Jogador__c>();
        jogadores.add(jogador1);
        jogadores.add(jogador2);
        jogadores.add(jogador3);
        jogadores.add(jogador4);
        jogadores.add(jogador5);
        insert jogadores;

        //Executa o teste
        Test.startTest();
        AssassinatosHandler.execute();
        Test.stopTest();
        //Relatorio do teste
    }

}