import wollok.game.*
import personaje.*
import cultivos.*
import granja.*

class Aspersor{
    var property estado = apagado
    var property position
    method image() {return "aspersor.png"}

    const property rango = [self.position().up(1), 
                    self.position().down(1), 
                    self.position().left(1), 
                    self.position().right(1),
                    self.position().up(1).right(1), 
                    self.position().down(1).left(1), 
                    self.position().up(1).left(1), 
                    self.position().down(1).right(1)]
/*
    const listaRango = alrededor.direcciones()

    method rango() = listaRango.map{posicion => {posicion.lugar.(position) }
  */  

    method regarRango() {

        self.rango().forEach({
                posicion => (
                    if (granja.hayCultivo(posicion) ) {
                        granja.obtenerCultivoEn(posicion).regado()}
                    )
            })
        
    }

    method encender(){
        self.estado().switch()
        game.onTick(1 * 1000, "riego automatico", {self.regarRango()})
    }

    method apagar() {
        self.estado().switch()
        game.removeTickEvent("riego automatico")
    }

    method ejecutar() {
        if (not estado.siEstaOn()){
            self.encender()
        } else {
            self.apagar()
        }
    }
	
}

object apagado {
    method switch() {return encendido}
    method siEstaOn() {return false}
}

object encendido {
    method switch() {return apagado}
    method siEstaOn() {return true}
}

object alrededor {
    const diagonales = [noroeste, noreste, sudoeste, sudeste]

    const contiguos = [norte, sur, este, oeste]

    method direcciones() {return diagonales + contiguos}
}

object noroeste{
    method lugar(centro) {return centro.up(1).left(1)}
}

object noreste{
    method lugar(centro) {return centro.up(1).right(1)}
}

object sudoeste{
    method lugar(centro) {return centro.down(1).left(1)}
}

object sudeste{
    method lugar(centro) {return centro.down(1).right(1)}
}

object norte{
    method lugar(centro) {return centro.up(1)}
}

object este{
    method lugar(centro) {return centro.right(1)}
}

object oeste {
    method lugar(centro) {return centro.left(1)}
}


object sur {
    method lugar(centro) {return centro.down(1)}
}

class Mercado {
    var property position
    var property fondos = 1000
    const property stock = []

    method image() { return "market.png"}

    method recibirDe(proveedor){
        const comprado = proveedor.valorTotalCosecha()
        fondos -= comprado
        stock.addAll(proveedor.paraVender())
        game.say(self, "- " + comprado)
    }

    method puedeComprar(proveedor) {
        return fondos >= proveedor.valorTotalCosecha()
    }

}

const mercado1 = new Mercado(position = game.at(3,3))
const mercado2 = new Mercado(position = game.at(3,4))
const mercado3 = new Mercado(position = game.at(3,5))
