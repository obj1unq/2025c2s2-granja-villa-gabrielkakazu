import wollok.game.*
import personaje.*
import cultivos.*

class Aspersor{
    
    var property position
    method image() {return "aspersor.png"}

    const property rango = [self.position().up(1), 
                    self.position().down(1), 
                    self.position().left(1), 
                    self.position().right(1)]

    method regarRango() {

        self.rango().forEach({
                posicion => (
                    if (granja.hayCultivo(posicion) ) {
                        granja.obtenerCultivoEn(posicion).regado()}
                    
                    )
            })
        
    }

    method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = false
	method esCultivo() = false
    method esAspersor() = true

	
}
/*
object alrededor() {
    
}*/

class Mercado {
    var property position
    var property fondos = 10000
    const stock = []

    method image() { return "market.png"}

    method recibirDe(proveedor){
        //stock.addAll(proveedor.vendido())
    }

    method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = false
	method esCultivo() = false
    method esAspersor() = false
    method esMercado() = true
    

}

const mercado1 = new Mercado(position = game.at(0,0))
const mercado2 = new Mercado(position = game.at(10,0))
const mercado3 = new Mercado(position = game.at(0,10))