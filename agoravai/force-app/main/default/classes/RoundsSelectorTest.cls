@isTest
public with sharing class RoundsSelectorTest {
    
    @TestSetup
    static void setup() {
        Round__c r = new Round__c();
        Round__c r2 = new Round__c();  
        List<Round__c> rounds = new List<Round__c>();
        rounds.add(r);
        rounds.add(r2);      
        insert rounds;
    }

    @isTest
    static void test1() {
        Map<Id, Round__c> roundsMap = new Map<Id, Round__c>([SELECT Id FROM Round__c]);

        Test.startTest();
        List<Round__c> roundsAux = RoundsSelector.selectByRoundsIdsWithJogadores(roundsMap.keySet());
        Test.stopTest();

        System.assertEquals(2, roundsAux.size());
    }

    @isTest
    static void test2() {
        List<Round__c> rounds = [SELECT Id FROM Round__c];
        Id roundId = rounds.get(0).Id;
        Id roundId2 = rounds.get(1).Id;
        Set<Id> ids = new Set<Id>{roundId,roundId2};
        Jogador__c jog1 = new Jogador__c(Round__c = roundId, Eliminado__c = true);
        Jogador__c jog2 = new Jogador__c(Round__c = roundId, Eliminado__c = false);        
        Jogador__c jog3 = new Jogador__c(Round__c = roundId2, Eliminado__c = true);
        List<Jogador__c> jogadores = new List<Jogador__c>{jog1,jog2,jog3};
        insert jogadores;

        Test.startTest();
        List<Round__c> roundsAux = RoundsSelector.selectByRoundsIdsWithJogadores(ids);
        Test.stopTest();        

        for (Round__c round : roundsAux) {
            if (round.Id.equals(roundId2)) {
                System.assertEquals(1, round.Jogadores__r.size(), 'Só deveria ter 1 jogador no round 2');
            }
            for (Jogador__c jog : round.Jogadores__r) {
                if (round.Id.equals(roundId)) {
                    System.assertNotEquals(jog.Id, jog2.Id, 'Jogador 2 não deveria ter retornado nessa query');
                } else if (round.Id.equals(roundId2)) {
                    System.assertEquals(jog.Id, jog3.Id, 'Brotou algum jogador que não era o 3, deu alguma merda.');
                }
            }
        }
    }

}