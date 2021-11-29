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

    @isTest
    static void geraNumeroTest() {
        /* Testes:
        1. valorFinal MAIOR que valor valorInicial
        2. valorFinal MENOR que valor valorInicial
        3. valorFinal null
        4. valorInicial null
        5. os 2 numeros null
        */
        //prepara o teste
        Integer valorInicial = 1;
        Integer valorFinal = 2;
        Integer valorParaSeEvitar = 2;

        //executa o teste
        Test.startTest();
        Integer numeroGeradoCorreto = Utils.geraNumero(valorInicial, valorFinal, valorParaSeEvitar);

        valorInicial = 10;
        valorFinal = 5;
        Integer numeroGeradoErrado = Utils.geraNumero(valorInicial, valorFinal, valorParaSeEvitar);
        Integer numeroGeradoFinalNull = Utils.geraNumero(valorInicial, null, valorParaSeEvitar);
        Integer numeroGeradoInicialNull = Utils.geraNumero(null, valorFinal, valorParaSeEvitar);
        Integer numeroGeradoTudoNull = Utils.geraNumero(null, null, null);
        Test.stopTest();
        //relatorio do teste
        System.assertEquals(1, numeroGeradoCorreto, 'Numero gerado deveria ser 1, gerou '+numeroGeradoCorreto);
        System.assertEquals(-1, numeroGeradoErrado, 'Numero gerado deveria ser -1, gerou '+numeroGeradoErrado);
        System.assertEquals(-1, numeroGeradoFinalNull, 'Numero gerado deveria ser -1, gerou '+numeroGeradoFinalNull);
        System.assertEquals(-1, numeroGeradoInicialNull, 'Numero gerado deveria ser -1, gerou '+numeroGeradoInicialNull);
        System.assertEquals(-1, numeroGeradoTudoNull, 'Numero gerado deveria ser -1, gerou '+numeroGeradoTudoNull);
    }
    

}