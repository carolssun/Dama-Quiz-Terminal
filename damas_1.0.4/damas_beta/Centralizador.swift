
import Foundation


//Var Globais

var jogo = Jogo()
var tabuleiro = Tabuleiro()
var contJogada = 1
let centralizarMatriz = centralizar(cena: tabuleiro.matriz)
var largura = 0
var altura = 0






// Func Global
func tamanhoTerminal() ->(largura: Int, altura: Int) {
    var tamJanela = winsize()
    let z = ioctl(STDOUT_FILENO,TIOCGWINSZ, &tamJanela)
    if (z==0){
        print(" ")
        
    }
    return (Int(tamJanela.ws_col), Int(tamJanela.ws_row))
}

func centralizar(cena:[[Int]])->String {
    let (larguraTerminal, alturaTerminal) = tamanhoTerminal()//tamanho do terminal
    let alturaCena: Int = cena.count
    let larguraCena: Int = 76 // tamanho da linha em caracteres
    //calcula desolcamento
    let espacoX = max((larguraTerminal / 2) - larguraCena / 2, 0)
    let espacoY = max((alturaTerminal/2) - alturaCena / 2, 0)
    
    for _ in 0..<espacoY{
        print("\n", terminator: " ")
    }
    
    let margemLinha = String(repeating: " ", count: espacoX)
    return margemLinha
    
}

func centralizarX()->String {
    let (larguraTerminal, _) = tamanhoTerminal()//tamanho do terminal
    let larguraCena: Int = 1// tamanho da linha em caracteres
    //calcula desolcamento
    let espacoX = max((larguraTerminal / 2) - larguraCena / 2, 0)
    
    let margemLinha = String(repeating: " ", count: espacoX)
    return margemLinha
    
}



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

// em alguns casos e necessario seguir um mesmo alinhamento para um grupo de palavras
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
