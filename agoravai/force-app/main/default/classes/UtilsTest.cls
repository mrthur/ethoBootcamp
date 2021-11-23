@isTest
public with sharing class UtilsTest {
    
    @isTest
    static void testSetValueException() {
        Jogador__c jog = new Jogador__c();
        String errorMessage;
        
        Test.startTest();
        try {
            Utils.setValue(jog, Jogador__c.Name, 'Renato');
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
        Test.stopTest();

        System.assert(errorMessage.contains('Field Name is not editable'), 'O campo name não deveria ser editável');
    }

    @isTest
    static void testSetValue() {
        Jogador__c jog = new Jogador__c();
        Integer vel = 10;
        Integer frc = 30;

        
        Test.startTest();
        Utils.setValue(jog, Jogador__c.Velocidade__c, vel);
        Utils.setValue(jog, Jogador__c.Forca__c, frc);
        Test.stopTest();

        System.assertEquals(jog.Velocidade__c, vel, 'A velocidade deveria ser ' + vel);
        System.assertEquals(jog.Forca__c, frc, 'A força deveria ser ' + frc);
    }
    

}