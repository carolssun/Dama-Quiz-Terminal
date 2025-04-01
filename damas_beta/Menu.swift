import Foundation
import Darwin
 

// MARK: - ASCII ART
var arteDamas:[[String]] = [
    ["***************************************************************************"],
    ["*                                                                          *"],
    ["*              ____                           ___        _                 *"],
    ["*             |  _ \\  __ _ _ __ ___   __ _   / _ \\ _   _(_)____            *"],
    ["*             | | | |/ _` | '_ ` _ \\ / _` | | | | | | | | |_  /            *"],
    ["*             | |_| | (_| | | | | | | (_| | | |_| | |_| | |/ /             *"],
    ["*             |____/ \\__,_|_| |_| |_|\\__,_|  \\__\\_\\\\__,_|_/___|            *"],
    ["*                                                                          *"],
    ["*                                                                          *"],
    ["****************************************************************************"]
]


var arteRegra:[[String]] = [
    ["***************************************************************************"],
    ["*                                                                         *"],
    ["*  |  _ \\ ___  __ _ _ __ __ _ ___    __| | ___     (_) ___   __ _  ___    *"],
    ["*  | |_) / _ \\/ _` | '__/ _` / __|  / _` |/ _ \\    | |/ _ \\ / _` |/ _ \\   *"],
    ["*  |  _ <  __/ (_| | | | (_| \\__ \\ | (_| | (_) |   | | (_) | (_| | (_) |  *"],
    ["*  |_| \\_\\___|\\__, |_|  \\__,_|___/  \\__,_|\\___/   _/ |\\___/ \\__, |\\___/   *"],
    ["*             |___/                              |__/       |___/         *"],
    ["*                                                                         *"],
    ["***************************************************************************"]
]

var arteFim:[[String]] = [
    ["***************************************************************************"],
    ["*                                                                         *"],
    ["*                            _____ _                                      *"],
    ["*                            |  ___(_)_ __ ___                            *"],
    ["*                            | |_  | | '_ ` _ \\                           *"],
    ["*                            |  _| | | | | | | |                          *"],
    ["*                            |_|   |_|_| |_| |_|                          *"],
    ["*                                                                         *"],
    ["***************************************************************************"]
]


// MARK: - Exibição de menu interativo com usuário
class Menu {
    
    static func menuPrincipal() {
        for i in 0 ..< arteDamas.count{
            print("")
            for j in 0 ..< 1{
                print(centralizarMatriz + arteDamas[i][j], terminator:"")
            }
        }
    
        let principalMenu:[String] = ["Escolha uma opção:","1- Jogar Damas","2- Regras do jogo","3- Sair"]
        centralizaStringJunto(palavra: "Escolha uma opção:", palavras: principalMenu)
        
    }
    
    static func menuRegras(){
        for i in 0 ..< arteRegra.count{
            print("")
            for j in 0 ..< 1{
                print(centralizarMatriz + arteRegra[i][j], terminator:"")
            }
        }
        
        let regrasMenu:[String] = ["Escolha uma opção:","1- Movimento das peças","2- Captura de peças","3- Voltar ao menu principal","4- Sair"]
        centralizaStringJunto(palavra: "Escolha uma opção:", palavras: regrasMenu)
        
    }
    
    
/* 
 capta a opção do usuário e chama outras funções
 */
    static func exibirMenuPrincipal() {
        menuPrincipal()
        let continuar = true
        while continuar {
            print(" ",terminator: centralizarX())//centraliza cursor no meio da tela
            if let opcao = readLine(), let opcaoInt = Int(opcao) {
                switch opcaoInt {
                case 1:
                    centralizaString(palavra: "Iniciando jogo de Damas...")
                    print()
                    jogo.iniciar()
                case 2:
                    exibirMenuRegas()
                case 3:
                    exibeFim()
                    break
                default:
                    print()
                    centralizaString(palavra: "Opção inválida. Tente novamente.")
                    print()
                }
            }
        }
    }
    
    static func exibeFim(){
        print("\u{001B}[2J")
        
        for i in 0 ..< arteFim.count{
            print("")
            for j in 0 ..< 1{
                print(centralizarMatriz + arteFim[i][j], terminator:"")
            }
        }
        print()
    }
    
    
    static func exibirMenuRegas(){
        var continuar = true
        while continuar {
            menuRegras()
            print(" ",terminator: centralizarX())
            if let opcao = readLine(), let opcaoInt = Int(opcao) {
                switch opcaoInt {
                case 1:
                    print("\nRegra movimento de peças: \n")
                    RegrasMovimento()
                case 2:
                    print("\nRegar de captura de peças inimigas: \n")
                    RegrasCaptura()
                case 3:
                    exibirMenuPrincipal()
                case 4:
                    exibeFim()
                    continuar = false
                default:
                    print()
                    centralizaString(palavra: "Opção inválida. Tente novamente.")
                    print()
                }
            }
        }
        
    }
    
    static func RegrasMovimento(){
        print("""
- Para escolher a casa de origem ou destino, digite o número da linha (horizontal), clique na tecla de espaço e digite a coluna que deseja (vertical).
- As peças comuns só podem se mover para a frente, em diagonal, para uma casa livre.
- As damas podem se mover para frente e para trás, em diagonal, para qualquer casa livre.
- A dama pode andar quantas casas quiser, na diagonal e comer para trás.
- A dama não pode saltar uma peça da mesma cor.
- \u{001B}[38;5;166m♠︎\u{001B}[38;5;166m \u{001B}[0;37m essa é a peça comum do jogador 1.\u{001B}[0;37m
- \u{001B}[38;5;64m♠︎\u{001B}[38;5;64m \u{001B}[0;37m essa é a peça comum do jogador 2.\u{001B}[0;37m
- \u{001B}[38;5;196m♚\u{001B}[38;5;196m \u{001B}[0;37m essa é a dama do jogador 1.\u{001B}[0;37m
- \u{001B}[38;5;36m♚\u{001B}[38;5;36m \u{001B}[0;37m essa é a dama do jogador 2.\u{001B}[0;37m
""")
        
    }
    
    
    static func RegrasCaptura(){
        print("""
- As peças comuns podem capturar para frente peças adversárias adjacentes.
- As damas podem capturar peças distantes na diagonal, desde que o caminho entre elas esteja livre.
- Duas ou mais peças juntas, na mesma diagonal, não podem ser capturadas.
- A captura múltipla é possível, ou seja, capturar mais de uma peça em um movimento. Se houver mais de uma captura possível, o jogador pode realizar outro lance desde que capture a próxima peça.
""")
        
    }
}
