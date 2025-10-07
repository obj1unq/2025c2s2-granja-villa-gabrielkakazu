import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	var oro = 0

	const cosecha = []

	method sembrar(cultivo){
		self.validarSembrar()
		game.addVisual(cultivo)
		cultivo.sembradoPor(self)
	}

	method regar(posicion) {
		granja.validarRegar(posicion)
		granja.obtenerCultivoEn(posicion).regado()		
	}


	method cosechar(posicion) {
		const cultivo = granja.obtenerCultivoEn(posicion)
		cultivo.cosechado()
		cosecha.add(cultivo)				
	}

	method vender() {
		const renta = cosecha.sum({cultivo => cultivo.valor()})
		game.say(self, "gané " + renta + " oro")
		oro += renta 
		cosecha.clear()
	}

	method validarSembrar() {
		const posicion = self.position()
		return if(granja.hayCultivo(posicion)) {
			 self.error("ya hay un cultivo aquií")	
			 game.say(self, "no puedo sembrar aquí")
		} 
	}

	method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = false
	method esCultivo() = false


}

object granja {
	method obtenerCultivoEn(posicion) {
		return game.getObjectsIn(posicion).find({cultivo => 
		cultivo.esCultivo()})
	}

	method validarRegar(posicion){
		if (not self.hayCultivo(posicion)){
			self.error("Acá no hay cultivo para regar")
			game.say(personaje, "Acá no hay cultivo para regar")
		}
	}

	method hayCultivo(posicion) {
		return  self.hayTrigo(posicion) or self.hayMaiz(posicion)
				 or self.hayTomaco(posicion)
				
	}

	method hayTrigo(posicion) {
		return game.getObjectsIn(posicion).any({
			cultivo => cultivo.esTrigo()
		})
	}

	method hayMaiz(posicion) {
		return game.getObjectsIn(posicion).any({
			cultivo => cultivo.esMaiz()
		})
	}

	method hayTomaco(posicion) {
		return game.getObjectsIn(posicion).any({
			cultivo => cultivo.esTomaco()
		})

	}

		 /*if (self.hayMaiz(posicion)) {
			return new Maiz(position = posicion)}
			else if (self.hayTomaco(posicion)) {new Tomaco(position = posicion)}
			else if (self.hayTrigo(posicion)){new Trigo(position = posicion)}
			else {
				return self.error("no hay cultivo")
			}*/
	}



