import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	var oro = 0

	const cosecha = []

	method sembrar(cultivo){
		self.celdaVacia()
		cultivo.sembrado()
	}

	method regar(posicion) {
		granja.validarRegar(posicion)
		
	}


	method cosechar(posicion) {
		
		cosecha.add()
		
	}

	method vender() {
		const renta = cosecha.sum({cultivo => cultivo.valor()})
		oro += renta 
		cosecha.claer()
	}

	method celdaVacia() {
		const posicion = self.position()
		return if(game.getObjectsIn(posicion).size()>1) {
			 self.error("celda llena")	
		} 
	}


}

object granja {

	method obtenerCultivoEn(posicion) {
		return if (self.hayTomaco(posicion)) {tomaco}
			else if (self.hayMaiz(posicion)) {maiz}
			else if (self.hayTrigo(posicion)){trigo}
			else {
				self.error("no hay cultivo")
			}
	}
	

	method validarRegar(posicion){
		if (not self.hayCultivo(posicion)){
			self.error("Acá no hay cultivo para regar")
		}
	}

	method hayCultivo(posicion) {
		return  self.hayTrigo(posicion) or self.hayMaiz(posicion)
				 or self.hayTomaco(posicion)
				
	}

	method hayTrigo(posicion) {
		return game.getObjectsIn(posicion).contains(trigo)
	}

	method hayMaiz(posicion) {
		return game.getObjectsIn(posicion).contains(maiz)
	}

	method hayTomaco(posicion) {
		return game.getObjectsIn(posicion).contains(tomaco)
	}




}
