@isTest
public with sharing class JogadoresTriggerHandlerTest {

    @isTest
    static void morreuTest() {
        Jogador__c j1 = new Jogador__c(Morreu__c = true);
        Jogador__c j2 = new Jogador__c();

        Test.startTest();
        Boolean morreuAux = JogadoresTriggerHandler.morreu(j1, j2);
        //Boolean naoMorreuAux = JogadoresTriggerHandler.morreu(j1, j1);
        Test.stopTest();
        System.assert(morreuAux, 'msg de erro');

    }

    @isTest
    static void foiEliminadoTest() {
        Jogador__c j1 = new Jogador__c(Eliminado__c = true);
        Jogador__c j2 = new Jogador__c(Eliminado__c = false);

        Test.startTest();
        //errado
        Boolean foiEliminadoAux = JogadoresTriggerHandler.foiEliminado(j1, j2);
        Test.stopTest();
        System.assertEquals(false, foiEliminadoAux, 'Esperado false pois o jogador já estava eliminado. Recebido: '+foiEliminadoAux);
    }

    @isTest
    static void ehJogadorPadraoTest() {
        //preparar o teste
        Id recordTypeIdPadrao = Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_JOGADOR_PADRAO).getRecordTypeId();
        Id recordTypeIdStaff = Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_MEMBRO_STAFF).getRecordTypeId();
        Jogador__c jogadorPadrao1 = new Jogador__c(RecordTypeId = recordTypeIdPadrao);
        Jogador__c jogadorStaff1 = new Jogador__c(RecordTypeId = recordTypeIdStaff);

        Jogador__c jogadorStaffNull1 = new Jogador__c();
        //fazer o teste
        Test.startTest();
        //Boolean jogadorPadraoAux = JogadoresTriggerHandler.ehJogadorPadrao(jogadorPadrao1);
        //Boolean jogadorStaffAux = JogadoresTriggerHandler.ehJogadorPadrao(jogadorStaff1);
        jogadorStaff1.RecordTypeId = null;
        Boolean jogadorStaffAux2 = JogadoresTriggerHandler.ehJogadorPadrao(jogadorStaff1);
        Test.stopTest();
        //relatorio do teste
        //System.assertEquals(true, jogadorPadraoAux, 'Esperado: true. Recebido: '+jogadorPadraoAux);
        //System.assertEquals(false, jogadorStaffAux, 'Esperado: false. Recebido: '+jogadorStaffAux);
    }

    @isTest
    static void handleEliminacaoMorteTest() {
        //preparar o teste
        String errorMessage1 = '';
        String errorMessage2 = '';
        String errorMessage3 = '';
        String errorMessage4 = '';
        Id recordTypeIdPadrao = Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_JOGADOR_PADRAO).getRecordTypeId();
        Id recordTypeIdStaff = Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_MEMBRO_STAFF).getRecordTypeId();
        Jogador__c jNormalEliminadoOld = new Jogador__c(Eliminado__c = false, RecordTypeId = recordTypeIdPadrao);
        Jogador__c jNormalEliminado = new Jogador__c(Eliminado__c = true, RecordTypeId = recordTypeIdPadrao);
        Jogador__c jNormalMortoOld = new Jogador__c(Morreu__c = false, RecordTypeId = recordTypeIdPadrao);
        Jogador__c jNormalMorto = new Jogador__c(Morreu__c = true, RecordTypeId = recordTypeIdPadrao);
        Jogador__c jStaffEliminadoOld = new Jogador__c(Eliminado__c = false, RecordTypeId = recordTypeIdStaff);
        Jogador__c jStaffEliminado = new Jogador__c(Eliminado__c = true, RecordTypeId = recordTypeIdStaff);
        Jogador__c jStaffMortoOld = new Jogador__c(Morreu__c = false, RecordTypeId = recordTypeIdStaff);
        Jogador__c jStaffMorto = new Jogador__c(Morreu__c = true, RecordTypeId = recordTypeIdStaff);
        //fazer o teste
        Test.startTest();
        try {
            JogadoresTriggerHandler.handleEliminacaoMorte(jNormalEliminado, jNormalEliminadoOld);
        } catch(Exception e) {
            errorMessage1 = e.getMessage();
        }

        try {
            JogadoresTriggerHandler.handleEliminacaoMorte(jNormalMorto, jNormalMortoOld);
        } catch(Exception e) {
            errorMessage2 = e.getMessage();
        }
        
        try {
            JogadoresTriggerHandler.handleEliminacaoMorte(jStaffEliminado, jStaffEliminadoOld);
        } catch(Exception e) {
            errorMessage3 = e.getMessage();
        }

        try {
            JogadoresTriggerHandler.handleEliminacaoMorte(jStaffMorto, jStaffMortoOld);
        } catch(Exception e) {
            errorMessage4 = e.getMessage();
        }
        Test.stopTest();
        //relatorio do teste
        System.assertEquals('', errorMessage1, '1. Esperado: . Recebido: '+errorMessage1);
        System.assertEquals('', errorMessage2, '2. Esperado: . Recebido: '+errorMessage2);
        System.assertEquals('', errorMessage3, '3. Esperado: . Recebido: '+errorMessage3);
        System.assertEquals('', errorMessage4, '4. Esperado: . Recebido: '+errorMessage4);
    }

    @isTest
    static void isChangedTest() {
        //preparar o teste
        //recordOld, record, Jogador__c.Morreu__c
        Jogador__c jogadorIsChanged1 = new Jogador__c(Eliminado__c = true);
        Jogador__c jogadorIsChanged2 = new Jogador__c(Eliminado__c = false);
        //fazer o teste
        Test.startTest();
        Boolean isChangedAux = JogadoresTriggerHandler.isChanged(jogadorIsChanged1, jogadorIsChanged2, Jogador__c.Eliminado__c);
        Test.stopTest();
        //relatorio do teste
        System.assertEquals(true, isChangedAux, 'Esperado: true. Recebido: '+isChangedAux);
    }

    @isTest
    static void beforeUpdateTest() {
        Id recordTypeIdPadrao = Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_JOGADOR_PADRAO).getRecordTypeId();
        Id recordTypeIdStaff = Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_MEMBRO_STAFF).getRecordTypeId();
        Jogador__c jogadorOld = new Jogador__c(Eliminado__c = false, RecordTypeId = recordTypeIdPadrao);
        Jogador__c jogador = new Jogador__c(Eliminado__c = true, RecordTypeId = recordTypeIdPadrao);
        String errorMessage = '';

        Test.startTest();
        try {
            JogadoresTriggerHandler.beforeUpdate(jogador, jogadorOld);
        } catch(Exception e) {
            errorMessage = e.getMessage();
        }
        Test.stopTest();
        //relatorio do teste
        System.assertEquals('', errorMessage, 'Esperado: . Recebido: '+errorMessage);

    }

    @isTest
    static void afterInsert() {

    }


    

}
