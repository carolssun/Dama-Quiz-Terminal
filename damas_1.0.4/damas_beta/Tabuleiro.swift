import Foundation
import Darwin

class Tabuleiro {
    var matriz: [[Int]]
    var turno : Int
    var comeu : Bool
    
    init() {
        self.matriz = [
            [3,0,0,1,0,0,0,1],
            [0,2,1,0,1,0,1,0],
            [0,0,0,0,0,0,0,2],
            [0,0,0,2,0,0,0,0],
            [0,0,0,2,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,2,0,2,0,2,0,2],
            [2,0,2,0,2,0,2,0]
        ]
        self.turno = 0
        self.comeu = false
        
    }
    
    
    // exibe o tabuleiro de INT convertendo para uma string dependendo do INT
    func exibir() {
        (largura, altura) = tamanhoTerminal()
        
        let larguraTabuleiro = 15
        let deslocamento = (largura - larguraTabuleiro) / 2
        
        let espacos = String(repeating: " ", count: deslocamento)
        print()
        print(espacos, terminator: "")  // Imprime os espaços à esquerda
        print("1 2 3 4 5 6 7 8\n")
        
        var contador = 1
        var casa : Bool = true
        for linha in matriz {
            casa = !casa
            print(espacos, terminator: "")
            
            for valor in linha {
                casa = !casa
                switch valor {
                case 1:
                    fputs("\u{001B}[38;5;166m♠︎ \u{001B}[38;5;166m", stdout)
                case 2:
                    fputs("\u{001B}[38;5;64m♠︎ \u{001B}[38;5;64m", stdout)
                case 3:
                    fputs("\u{001B}[38;5;196m♚ \u{001B}[38;5;196m", stdout)
                case 4:
                    fputs("\u{001B}[38;5;36m♚ \u{001B}[38;5;36m", stdout)
                default:
                    if casa {
                        fputs("\u{001B}[38;5;249m◼︎ \u{001B}[38;5;249m", stdout)
                    } else {
                        fputs("\u{001B}[38;5;249m◻︎ \u{001B}[38;5;249m", stdout)
                    }
                }
            }
            print(" \u{001B}[0;37m \(contador) \u{001B}[0;37m")
            contador += 1
        }
        print()
    }
    
    //Funcao principal, utiliza todas as validacoes para realizar o movimento da peca selecionada
    func movePeca() {
        comeu = false // Utilizado para verificar se o jogador pode realizar mais um movimento
        var (linhaO, colunaO) = jogo.selecionaPeca(matriz: matriz)
        var (linhaD, colunaD) = jogo.selecionaJogada(matriz: matriz)
        
        var peca = matriz[linhaO][colunaO]
        
        //Utilizado para verificar a variancia do movimento da peca pela matriz, classificando o movimento como valido ou nao
        var deltaLinha = linhaD - linhaO
        var deltaColuna = colunaD - colunaO
        
        var passoLinha = deltaLinha > 0 ? 1 : -1
        var passoColuna = deltaColuna > 0 ? 1 : -1
        
        let jogador = jogo.quemJoga()
        
        //nao permite mover a peca do adversario
        while jogo.quemJoga() == 1 && peca % 2 == 0{
            print()
            centralizaString(palavra: "Atenção jogador, voce pode apenas mover a sua peça")
            
            (linhaO, colunaO) = jogo.selecionaPeca(matriz: matriz)
            (linhaD, colunaD) = jogo.selecionaJogada(matriz: matriz)
            
            peca = matriz[linhaO][colunaO]
            
        }
        
        while jogo.quemJoga() == 2 && peca % 2 != 0{
            print()
            centralizaString(palavra: "Atenção jogador, voce pode apenas mover a sua peça")
            (linhaO, colunaO) = jogo.selecionaPeca(matriz: matriz)
            (linhaD, colunaD) = jogo.selecionaJogada(matriz: matriz)
            
            peca = matriz[linhaO][colunaO]
            
        }
        
        let ehDama = (peca == 3 || peca == 4)
        
        //realiza as verificacoes para a dama
        if ehDama {
            if validaJogadaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga()) {
                // com base no resultado da tupla, define se pode ou nao comer a peca adversaria
                if comePecaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga()) == (-1,-1){
                }else{
                    if !comeu{
                        
                        
                        var l :Int = 0
                        var c :Int = 0
                        
                        (l,c) = comePecaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga())
                        matriz[l][c] = 0
                        (linhaD, colunaD) = (l + passoLinha,c + passoColuna)
                        print()
                        centralizaString(palavra: "Dama movida para casa adjacente a peça inimiga")
                        matriz[linhaD][colunaD] = peca
                        matriz[linhaO][colunaO] = 0
                        comeu = true
                    }
                }
                matriz[linhaD][colunaD] = peca
                matriz[linhaO][colunaO] = 0
                
            } else {
                print()
                centralizaString(palavra: "Jogada inválida para dama")
                // caso o usuario digite uma posicao invalida, ele recebe mais uma chance de mover a peca
                if !validaJogadaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga()){
                    (linhaD, colunaD) = jogo.selecionaJogada(matriz: matriz)
                    deltaLinha = linhaD - linhaO
                    deltaColuna = colunaD - colunaO
                    
                    passoLinha = deltaLinha > 0 ? 1 : -1
                    passoColuna = deltaColuna > 0 ? 1 : -1
                    
                    if validaJogadaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga()) {
                        if comePecaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga()) == (-1,-1){
                        }else{
                            if !comeu{
                                
                                
                                var l :Int = 0
                                var c :Int = 0
                                
                                (l,c) = comePecaDama(linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD, jogador: jogo.quemJoga())
                                matriz[l][c] = 0
                                (linhaD, colunaD) = (l + passoLinha,c + passoColuna)
                                print()
                                centralizaString(palavra: "Dama movida para casa adjacente a peça inimiga")
                                matriz[linhaD][colunaD] = peca
                                matriz[linhaO][colunaO] = 0
                                comeu = true
                            }
                        }
                        matriz[linhaD][colunaD] = peca
                        matriz[linhaO][colunaO] = 0
                    }
                    
                }
                
            }
        } else {
            // nao permite o peao andar da mesma forma que a dama
            while (linhaO - linhaD) > 2{
                centralizaString(palavra: "Jogada Invalida")
                (linhaD, colunaD) = jogo.selecionaJogada(matriz: matriz)
                deltaLinha = linhaD - linhaO
                deltaColuna = colunaD - colunaO
                
                
                //verifica se o peao come outra peca
                if comePeca(jogador: jogo.quemJoga(), linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD) {
                    if !comeu{
                        matriz[linhaD][colunaD] = peca
                        matriz[linhaO][colunaO] = 0
                        
                        let meioLinha = (linhaO + linhaD) / 2
                        let meioColuna = (colunaO + colunaD) / 2
                        matriz[meioLinha][meioColuna] = 0 // Remove peça adversária
                        comeu = true
                    }
                } else {
                    matriz[linhaD][colunaD] = peca
                    matriz[linhaO][colunaO] = 0
                }
                
                // Verifica se vira dama
                if jogador == 1 && linhaD == 7 && peca == 1 {
                    matriz[linhaD][colunaD] = 3 // Vira dama
                } else if jogador == 2 && linhaD == 0 && peca == 2 {
                    matriz[linhaD][colunaD] = 4
                }
                
            }
            if validaJogada(jogador: jogo.quemJoga(), linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD) {
                if comePeca(jogador: jogo.quemJoga(), linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD) {
                    if !comeu{
                        matriz[linhaD][colunaD] = peca
                        matriz[linhaO][colunaO] = 0
                        
                        let meioLinha = (linhaO + linhaD) / 2
                        let meioColuna = (colunaO + colunaD) / 2
                        matriz[meioLinha][meioColuna] = 0 // Remove peça adversária
                        comeu = true
                    }
                } else {
                    matriz[linhaD][colunaD] = peca
                    matriz[linhaO][colunaO] = 0
                }
                
                // Verifica se vira dama
                if jogador == 1 && linhaD == 7 && peca == 1 {
                    matriz[linhaD][colunaD] = 3 // Vira dama
                } else if jogador == 2 && linhaD == 0 && peca == 2 {
                    matriz[linhaD][colunaD] = 4
                }
                
            } else {
                print()
                centralizaString(palavra: "Jogada inválida")
                if !validaJogada(jogador: jogo.quemJoga(), linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD){
                    (linhaD, colunaD) = jogo.selecionaJogada(matriz: matriz)
                    let deltaLinha = linhaD - linhaO
                    let deltaColuna = colunaD - colunaO
                    
                    passoLinha = deltaLinha > 0 ? 1 : -1
                    passoColuna = deltaColuna > 0 ? 1 : -1
                    
                    if comePeca(jogador: jogo.quemJoga(), linhaO: linhaO, colunaO: colunaO, linhaD: linhaD, colunaD: colunaD) {
                        if !comeu{
                            matriz[linhaD][colunaD] = peca
                            matriz[linhaO][colunaO] = 0
                            
                            let meioLinha = (linhaO + linhaD) / 2
                            let meioColuna = (colunaO + colunaD) / 2
                            matriz[meioLinha][meioColuna] = 0 // Remove peça adversária
                            comeu = true
                        }
                    } else {
                        matriz[linhaD][colunaD] = peca
                        matriz[linhaO][colunaO] = 0
                    }
                    
                    // Verifica se vira dama
                    if jogador == 1 && linhaD == 7 && peca == 1 {
                        matriz[linhaD][colunaD] = 3 // Vira dama
                    } else if jogador == 2 && linhaD == 0 && peca == 2 {
                        matriz[linhaD][colunaD] = 4
                    }
                }
            }
        }
    }
    
    
    // validacao basica para a peca
    func validaJogada(jogador: Int, linhaO: Int, colunaO: Int, linhaD: Int, colunaD: Int) -> Bool {
        let pecaDes :Int = matriz[linhaD][colunaD]
        
        if pecaDes != 0 {
            return false
        
        }
        
        if matriz[linhaO][colunaO] == 2 && jogador == 1{
            return false
        }else if matriz[linhaO][colunaO] == 1 && jogador == 2{
            return false
        }
        
        
        if matriz[linhaD][colunaD] == 0 {
            let deltaLinha = linhaD - linhaO
            let deltaColuna = colunaD - colunaO
            
            if deltaLinha > 2 {
                return false
            }
            
            if abs(deltaLinha) == abs(deltaColuna) {
                return true
            }
        }
        
        
        return false
    }
    
    // regras diferenciadas para a dama ( pode se mover de forma diferente)
    func validaJogadaDama(linhaO: Int, colunaO: Int, linhaD: Int, colunaD: Int, jogador: Int) -> Bool {
        let deltaLinha = linhaD - linhaO
        let deltaColuna = colunaD - colunaO
        
        if abs(deltaLinha) == abs(deltaColuna) {
            return true  // Movimento não é diagonal
        }
        
        let passoLinha = deltaLinha > 0 ? 1 : -1
        let passoColuna = deltaColuna > 0 ? 1 : -1
        
        var l = linhaO + passoLinha
        var c = colunaO + passoColuna
        
        while l != linhaD && c != colunaD {
            let peca = matriz[l][c]
            if peca != 0 {
                if (jogador == 1 && (peca % 2 != 0)) || (jogador == 2 && (peca  % 2 == 0)) {
                    if matriz[l + passoLinha][c + passoLinha] == 0 {
                        return true
                    }else{
                        return false
                    }
                    
                } else {
                    return false  // Peça do próprio jogador bloqueando o caminho
                }
            }
            l += passoLinha
            c += passoColuna
        }
        
        if matriz[linhaD][colunaD] != 0 {
            return false  // Destino não está vazio
        }
        
        return true  // Movimento válido
    }
    
    // validacoao para verificar se a dama pode comer a peca inimiga
    func comePecaDama (linhaO: Int, colunaO: Int, linhaD: Int, colunaD: Int, jogador: Int) -> (Int, Int){
        
        let deltaLinha = linhaD - linhaO
        let deltaColuna = colunaD - colunaO
        
        let passoLinha = deltaLinha > 0 ? 1 : -1
        let passoColuna = deltaColuna > 0 ? 1 : -1
        
        var l = linhaO + passoLinha
        var c = colunaO + passoColuna
        
        // como é verdade, ele ja viu se tem peca no caminho sem ser seguidas
        var peca = matriz[l][c]
        
        while l != linhaD{
            if peca != 0 {
                return (l, c)
            }
            l += passoLinha
            c += passoColuna
            peca = matriz[l][c]
        }
        
        return (-1, -1)
    }
    
    func comePeca(jogador: Int, linhaO: Int, colunaO: Int, linhaD: Int, colunaD: Int) -> Bool {
        let dentroDosLimites = { (linha: Int, coluna: Int) -> Bool in
            return linha >= 0 && linha < 8 && coluna >= 0 && coluna < 8
        }
        
        if !dentroDosLimites(linhaO, colunaO) || !dentroDosLimites(linhaD, colunaD) {
            return false // Fora do tabuleiro
        }
        
        let deltaLinha = linhaD - linhaO
        let deltaColuna = colunaD - colunaO
        
        // Captura válida é pular 2 casas na diagonal
        if abs(deltaLinha) == 2 && abs(deltaColuna) == 2 {
            let meioLinha = linhaO + deltaLinha / 2
            let meioColuna = colunaO + deltaColuna / 2
            
            if dentroDosLimites(meioLinha, meioColuna) {
                let pecaMeio = matriz[meioLinha][meioColuna]
                let pecaDestino = matriz[linhaD][colunaD]
                
                if pecaDestino != 0 {
                    return false // Não pode capturar se destino estiver ocupado
                }
                
                // Verifica se peça no meio é inimiga
                if jogador == 1 && (pecaMeio == 2 || pecaMeio == 4) {
                    return true
                }
                if jogador == 2 && (pecaMeio == 1 || pecaMeio == 3) {
                    return true
                }
            }
        }
        
        return false // Não é um movimento de captura válido
    }
    
    // funcao que varre a matriz para verificar se ainda resta a peca de algum dos times
    func fimDeJogo() -> Bool {
        var jogador1TemPeca = false
        var jogador2TemPeca = false
        
        for linha in matriz {
            for valor in linha {
                if valor == 1 || valor == 3 { jogador1TemPeca = true }
                if valor == 2 || valor == 4 { jogador2TemPeca = true }
            }
        }
        
        return !(jogador1TemPeca && jogador2TemPeca)
    }
    
    
    
    // funcao que caso a resposta for correta, remove uma peca adversaria de forma aleatoria
    func explodePeca() -> [Int: [(Int, Int)]]{
        var posicoes: [Int: [(Int, Int)]] = [:]
        
        for (linha, row) in matriz.enumerated() {
            for (coluna, valor) in row.enumerated() {
                posicoes[valor, default: []].append((linha, coluna))
            }
        }
        return posicoes
    }
    
    func sortearPosicao(para valor: Int) -> (Int, Int)? {
        if let lista = explodePeca()[valor], !lista.isEmpty {
            return lista.randomElement()
            
        }
        return nil
    }
    
    // chama a funcao das perguntas
    func iniciarQuiz(indice: Int) {
        var respostaValida = false
        while !respostaValida {
            Pergunta.exibirPergunta(ind: indice)
            print(" ",terminator: centralizarX())
            if let resposta = readLine(), !resposta.isEmpty {
                if let respostaInt = Int(resposta),
                   Pergunta.verificarResposta(alt: respostaInt, ind: indice) {
                    if jogo.quemJoga() % 2 == 0 {
                        if let posicao = sortearPosicao(para: 1){
                            let l = posicao.0
                            let c = posicao.1
                            matriz[l][c] = 0
                            print()
                            centralizaString(palavra: "Peça na posição (\(l + 1),\(c + 1)) do jogador rival removida com sucesso")
                        }else{
                            print()
                            centralizaString(palavra: "Erro(Nao entrou no if let) consulte um dev do jogo")
                        }
                        
                    }else{
                        if let posicao = sortearPosicao(para: 2){
                            let l = posicao.0
                            let c = posicao.1
                            matriz[l][c] = 0
                            print()
                            centralizaString(palavra: "Peça na posição (\(l + 1), \(c + 1)) do jogador rival removida com sucesso")
                            
                            
                        }else{
                            print()
                            centralizaString(palavra: "Erro(Nao entrou no if let) consulte um dev do jogo")
                        }
                    }
                    print()
                    centralizaString(palavra: "Resposta correta!")
                    // explode a peca aleatoria do adversario
                    
                } else {
                    print()
                    centralizaString(palavra: "Resposta incorreta!")
                }
                
                respostaValida = true
            } else {
                print()
                centralizaString(palavra: "Nenhuma resposta foi escolhida. Tente novamente.")
            }
        }
    }
    
}
