public with sharing class Sorteio {

    public static Integer GeraNumero() {
        Integer valor1D20 = Integer.valueof((Math.random() * 20)); //d20
        Integer valor1D10 = Integer.valueof((Math.random() * 10)); //d10
        Integer valor2D10 = Integer.valueof((Math.random() * 10)); //d10
    }

}


/*
CRIAR OBJETO:
    Assassinato
        Nome: código automático
            ASS-{0000}
        Assassino(a) - mestre detalhe (jogador)            
        Assassinado(a) - pesquisa (jogador)      

CLASSE AGENDADA
    - Rodar primeira vez manualmente
    - A partir da primeira vez, a classe irá se
    reagendar para "x" horas depois.
        - 12 <= x <= 36
            - Resumindo: acontecerá UM, E SOMENTE UM assassinato a cada "x" horas.
            Onde "x" nunca será menor que 12 e nunca será maior que 36.

    - Execução:
        - Buscar jogadores vivos do round em andamento. - ok
            - Selecionar assassino e assassinado de forma aleatória. - +- ok
            - Calcular
                - Para o assassino vencer: 
                    (1D20 + FORÇA) > (2D10 + INTELIGENCIA + VELOCIDADE)
                        Assassino                 Assassinado   
                - Contra-golpe:
                    - Caso o assassino tire 1, o assassinado tem a chance de assassinar
                        (1D20 + FORÇA) > (2D10 + INTELIGENCIA + VELOCIDADE)
                    - Não existe contra-golpe de contra-golpe
*/