import wollok.game.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	var oro = 0

	const cosecha = []

	method sembrar(cultivo){
		cultivo.sembrado()
	}

	method regar(posicion) {
		granja.validarRegar(posicion)
		
	}


	method cosechar(posicion) {
		

	}

	method vender() {

	}

}

object granja {

	method validarRegar(posicion){
		if (not self.hayCultivo(posicion)){
			self.error("Acá no hay cultivo para regar")
		}
	}

	method hayCultivo(posicion) {
		return game.hasVisual(trigo) or game.hasVisual(maiz) or game.hasVisual(tomaco)
	}


}