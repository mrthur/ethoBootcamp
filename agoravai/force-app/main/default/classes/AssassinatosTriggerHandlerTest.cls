@isTest
public with sharing class AssassinatosTriggerHandlerTest {
    @isTest
    static void afterInsertTest() {
        //prepara o teste
        List<Assassinato__c> records = new List<Assassinato__c>();
        records.add(
            new Assassinato__c(
                Assassinado__c = 'a015f000009o0lfAAA',
                Assassino__c = 'a015f00000Cnhc0AAB',
                DataHora__c = System.now()
            )
        );
        //executa o teste
        Test.startTest();
        AssassinatosTriggerHandler.afterInsert(records);
        Test.stopTest();
        //relatorio do teste
    }
    
}
