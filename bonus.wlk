import wollok.game.*
import personaje.*
import cultivos.*

class Aspersor{
    
    var property position
    method image() {return "aspersor.png"}

    method encender(){
        game.schedule()
    }

    method regar() {


    }

    method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = false
	method esCultivo() = false

	
}

object alrededor() {
    
}