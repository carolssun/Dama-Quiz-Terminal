import Foundation

class Jogador {
    let numero: Int
    var pecasComidas: Int = 0

    init(numero: Int) {
        self.numero = numero
    }

    func incrementarComida() {
        pecasComidas += 1
    }
}

