
import Foundation
//Lista de Struct com as perguntas, alternativas e respostas
let perguntas: [Perguntas] = [
    Perguntas(pergunta: "Onde se localiza Machu Picchu?",
              alternativas: ["Colômbia", "Peru", "China", "Bolívia", "Índia"],
              resposta:  2),
    
    Perguntas(pergunta: "De quem é a famosa frase “Penso, logo existo”?",
              alternativas: ["Platão", "Galileu Galilei", "Descartes", "Sócrates", "Francis Bacon"],
              resposta: 3),
    
    Perguntas(pergunta: "Quantos ossos temos no nosso corpo?",
              alternativas: ["126", "206", "218", "300", "200"],
              resposta: 2),
    
    Perguntas(pergunta: "Um anel tem 3 pedras preciosas. Quantas pedras preciosas têm 11 anéis?",
              alternativas: ["33", "110", "333", "30", "14"],
              resposta: 1),
    
    Perguntas(pergunta: "Quem pintou Guernica?",
              alternativas: ["Leonardo da Vinci", "Salvador Dalí", "Van Gogh", "Tarsila do Amaral", "Pablo Picasso"],
              resposta: 5),
    
    Perguntas(pergunta: "Quem escreveu Os Lusíadas?",
              alternativas: ["Carlos Drummond de Andrade", "Fernando Pessoa", "Jorge Amado", "Almeida Garrett", "Luís Vaz de Camões"],
              resposta: 5),
    Perguntas(pergunta: "Que grande evento histórico aconteceu em 1822 no Brasil?",
              alternativas: ["Descobrimento do Brasil", "Ditadura Militar", "Revolução de 1930", "Independência do Brasil", "Construção de Brasília"],
              resposta: 4),
    Perguntas(pergunta:"Em que país se localiza o Taj Mahal?",
              alternativas:["Egito", "Índia", "Inglaterra", "Brasil", "França"],
              resposta: 2),
    Perguntas(pergunta: "Qual a primeira mulher a ganhar um prêmio Nobel?",
              alternativas: ["Marie Curie", "Rosalind Franklin", "Ada Lovelace", "Lise Meitner", "Dorothy Hodgkin"],
              resposta: 1),
    Perguntas(pergunta: "De onde é a invenção do chuveiro elétrico?",
              alternativas: ["Estados Unidos", "Itália", "Brasil", "Alemanha", "Japão"],
              resposta: 3),
    Perguntas(pergunta: "Qual é a capital da Checoslováquia?",
              alternativas: ["Paris", "Praga", "Tashkent", "Tirana", "Naipidau"],
              resposta: 2 ),
    Perguntas(pergunta: "Quem escreveu Dom Quixote?",
              alternativas: ["William Shakespeare", "Miguel de Cervantes", "Gabriel García Márquez", " Fiódor Dostoiévski", "Fernando Pessoa"],
              resposta: 2),
    Perguntas(pergunta: "Em que ano ocorreu a Revolução Francesa?",
              alternativas: ["1776", "1815", "1798", "1789", "1898"],
              resposta: 4),
    Perguntas(pergunta: "Qual é o elemento químico representado pelo símbolo O?",
              alternativas: ["Oxigênio", "Ouro", "Osmium", "Ósmio", "Oganessônio"],
              resposta: 1),
    Perguntas(pergunta: "Qual é o maior oceano do mundo?",
              alternativas: ["Oceano Atlântico", "Oceâno Índico", "Oceâno Pacífico", "Oceâno Ártico", "Oceâno Antártico"],
              resposta: 3),
    Perguntas(pergunta: "Qual é a moeda oficial do Japão?",
              alternativas: ["Yuan", "Baht", "Won", "Dólar", "Yen"],
              resposta: 5),
    Perguntas(pergunta: "Qual é a capital do Canadá?",
              alternativas: ["Ottawa", "Tornoto", "Vancouver", "Montreal", "Quebec"],
              resposta: 1),
    Perguntas(pergunta: "Qual é o nome do processo pelo qual as plantas produzem alimento?",
              alternativas: ["Respiração", "Fotossíntese", "Fermentação", "Digestão", "Osmose"],
              resposta: 2),
    Perguntas(pergunta: "Qual é o nome do maior mamífero terrestre?",
              alternativas: ["Elefante Africano", "Baleia Azul", "Rinoceronte", "Hipopótamo", "Girafa"],
              resposta: 1),
    Perguntas(pergunta: "Quantas patas uma formiga possui?",
              alternativas: ["8", "4", "10", "6", "12"],
              resposta: 4)
    
]

class Pergunta {

    
    static func verificarResposta(alt: Int, ind: Int) -> Bool {
        return alt == perguntas[ind].resposta
    }
    
    static func exibirPergunta(ind: Int) {
        if ind == perguntas.count {
            print("Você acabou as perguntas")
            exit(3)
        } else {
            print()
            centralizaString(palavra: perguntas[ind].pergunta)
            
            var w = 0
            
            (w, _) = tamanhoTerminal()
            
            let tamPalavra = perguntas[ind].pergunta.count
            var espacosBranco = (w - tamPalavra) / 2
            
            if espacosBranco < 0{
                espacosBranco = espacosBranco * -1
            }
            
            let tab = String(repeating: " ", count: espacosBranco)
        
            
            for (indice, alt) in perguntas[ind].alternativas.enumerated() {
                print(tab, terminator: " ")
                print("\(indice + 1)) \(alt) ")

            }
            //percorrer a lista de alternativas, retornar o índice (+1 pra ficar intuitivo p/usuàrio)
            // e o valor das alternativa
        }
    }
}


struct Perguntas {
    var pergunta: String
    var alternativas: [String]
    var resposta: Int
}



