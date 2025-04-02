import Foundation
 
// MARK : - construindo classe
class Jogo {
    var tabuleiro: Tabuleiro
    var jogador1: Jogador
    var jogador2: Jogador
    var turno: Int
    var contPerg: Int
    
    init() {
        self.tabuleiro = Tabuleiro()
        self.jogador1 = Jogador(numero: 1)
        self.jogador2 = Jogador(numero: 2)
        self.turno = 1
        self.contPerg = 0
    }
    
    // Funçao que gerencia o funcionamento do jogo
    func iniciar() {
        
        // MARK: - Lógica do Jogo
        /* Game loop principal 
            verifica contador de jogada e turno do jogador  para verificar 
        */
        while !tabuleiro.fimDeJogo() {
            if contJogada%3==0 && turno==1 || contJogada%3==1 && turno==2{
                print()
                centralizaString(palavra: "---------------------------------------------------------------------------")
                print()
                centralizaString(palavra:"Turno do jogador \(turno)")
                tabuleiro.iniciarQuiz(indice: contPerg)
                contPerg += 1
                alternarTurno()
            }else{
                print()
                centralizaString(palavra: "---------------------------------------------------------------------------")
                print()
                centralizaString(palavra:"Turno do jogador \(turno)")
                tabuleiro.exibir()
                tabuleiro.movePeca()
                while tabuleiro.comeu{
                    print()
                    centralizaString(palavra: "---------------------------------------------------------------------------")
                    print()
                    centralizaString(palavra:"Turno do jogador \(turno)")
                    tabuleiro.exibir()
                    print()
                    centralizaString(palavra: "Jogue novamente!")
                    tabuleiro.movePeca()
                }
                alternarTurno()
            }
            tabuleiro.exibir()
            contJogada += 1
            if contJogada > 30{
                if empataJogo(){
                    Menu.exibeFim()
                    break
                }
            }
            
        }
       
    }
    
    // realiza a troca do turno ( utilizada em calculos de validacao posteriormente
    func alternarTurno(){
        turno = (turno == 1) ? 2 : 1
    }
    
    func quemJoga() -> Int{
        if turno == 1{
            return 1
        }
        return 2
    }
    
    // TODO: - Entrada de Usuário
    func readInt() -> (Int, Int) {
        print(" ",terminator: centralizarX())
        if let entrada = readLine() {
            let partes = entrada.split(separator: " ")
            if partes.count == 2,
               let valorLinha = Int(partes[0]),
               let valorColuna = Int(partes[1]) {
                return (valorLinha, valorColuna)
            }
        }
        return (-1, -1)
    }
    
    func selecionaPeca(matriz: [[Int]]) -> (Int, Int) {
        var linha = 0
        var coluna = 0
        
        centralizaString(palavra: "Digite a linha e a coluna da peça que deseja mover separadas por 'Espaco': ")
        
        (linha, coluna) = readInt()
        linha -= 1
        coluna -= 1
        
        //validacao basica para garantir que voce selecionou uma peca valida
        while linha < 0 || linha >= 8 || coluna < 0 || coluna >= 8 || matriz[linha][coluna] == 0 {
                print()
                centralizaString(palavra: "Nenhuma peça no local selecionado ou posição inválida")
                centralizaString(palavra: "Digite novamente a linha e a coluna da peça que deseja mover:")
                
            

            (linha, coluna) = readInt()
            linha -= 1
            coluna -= 1
        }
        print()
        centralizaString(palavra: "Linha e coluna selecionadas com sucesso")
        //print("\nLinha e coluna selecionadas com sucesso")
        return (linha, coluna)
    }
    
    func selecionaJogada(matriz: [[Int]]) -> (Int, Int) {
        var linha = 0
        var coluna = 0
        
        print()
        centralizaString(palavra: "Digite a linha e a coluna para onde deseja mover a peça separadas por 'Espaco': ")
        (linha, coluna) = readInt()
        linha -= 1
        coluna -= 1
        
        while linha < 0 || linha >= 8 || coluna < 0 || coluna >= 8 {
            print()
            centralizaString(palavra: "Local selecionado inválido.")
            centralizaString(palavra: "Digite novamente a linha e a coluna para onde deseja mover a peça:")
            (linha, coluna) = readInt()
            linha -= 1
            coluna -= 1
        }
        
        print()
        centralizaString(palavra: "Linha e coluna de destino selecionadas com sucesso")
        return (linha, coluna)
    }
    
   
    // recomenda o empate do jogo
    func empataJogo () -> Bool{
        var op1 = 0
        var op2 = 0
        
        print()
        print()
        centralizaString(palavra: "Atenção jogadores é recomendado o empate da partida. Digite 1 para confirmar.")
        centralizaString(palavra: "(digite a opçao de cada jogador separada por espaço)")
        
        (op1,op2) = readInt()
        
        if op1 == op2{
            return true
        }else{
            return false
        }
        
    }
    
    
    
}


