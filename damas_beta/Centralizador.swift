import Foundation

var jogo = Jogo()
var tabuleiro = Tabuleiro()
var contJogada = 1
let centralizarMatriz = centralizar(cena: tabuleiro.matriz)
var largura = 0
var altura = 0

// MARK: - Funções de Auxilio de Print

/*
Utiliza funçoes darwin para calcular o tamanho da janela do terminal e da tela do computador.
Retorna uma tupla de inteiros referentes ao valor do tamanho da largura e altura
*/
func tamanhoTerminal() ->(largura: Int, altura: Int) {
    var tamJanela = winsize()
    let z = ioctl(STDOUT_FILENO,TIOCGWINSZ, &tamJanela)
    if (z==0){
        print(" ")  
    }
    
    return (Int(tamJanela.ws_col), Int(tamJanela.ws_row))
}

/*
utilizada para centralizar ASCII art. 
cena é a matriz de 1 coluna e n linhas a ser centralizada
*/
func centralizar(cena:[[Int]])->String {
    let (larguraTerminal, alturaTerminal) = tamanhoTerminal()
    let alturaCena: Int = cena.count
    let larguraCena: Int = 76 // tamanho da linha em caracteres da matriz
    let espacoX = max((larguraTerminal / 2) - larguraCena / 2, 0)
    let espacoY = max((alturaTerminal/2) - alturaCena / 2, 0)

    // Prints vazios mostrados antes da linha das artes
    for _ in 0..<espacoY{
        print("\n", terminator: " ")
    }
    
    let margemLinha = String(repeating: " ", count: espacoX)
    return margemLinha 
}

/*
Calcula somente o deslocamento horizontal do terminal. utilizado para centralizar
o cursor (local de input) 
*/
func centralizarX()->String {
    let (larguraTerminal, _) = tamanhoTerminal()//tamanho do terminal
    let larguraCena: Int = 1// tamanho da linha em caracteres
    let espacoX = max((larguraTerminal / 2) - larguraCena / 2, 0)
    let margemLinha = String(repeating: " ", count: espacoX)
    return margemLinha
}

/*
Com base na largura do terminal e no tamanho da String a ser exibida, calcula o deslocamento
para centralizá-la.
palavra é a string a ser exibida
*/
func centralizaString(palavra : String){
    var l = 0
    (l, _) = tamanhoTerminal()
    let tamPalavra = palavra.count
    var espacos = (l - tamPalavra) / 2
    
    if espacos < 0{
        espacos = espacos * -1
    }
    
    let blank = String(repeating: " ", count: espacos)
    print(blank, terminator: " ")
    print(palavra)
}

/*
Quando necessário exibir um grupo de palavras com um mesmo padding, utiliza a 'palavra' como parâmeto
para calcular a margem lateral, e a lista 'palavras' que é o conjunto de strings a serem exibidos em seguida
*/
func centralizaStringJunto(palavra : String, palavras :[String]){
    var l = 0
    (l, _) = tamanhoTerminal()
    let tamPalavra = palavra.count
    let espacos = (l - tamPalavra) / 2
    let blank = String(repeating: " ", count: espacos)
    
    print()
    for p in palavras{
        print(blank, terminator: " ")
        print(p)
        print()
    }
}
