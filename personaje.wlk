import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "mplayer.png"

	var property oro = 0

	const cosecha = []
	const aspersores = []

	method paraVender() {return cosecha }

	method sembrar(cultivo){
		self.validarSembrar()
		game.addVisual(cultivo)
		cultivo.sembradoPor(self)
	}

	method instalar(aparato){
		self.validarUbicacion(aparato)
		aspersores.add(aparato)
		game.addVisual(aparato)
	}

	method encenderAspersor(){
        game.onTick(1 * 1000, "riego Aspersor", {
			aspersores.forEach({
				aparato => aparato.regarRango()
        		}
			)}
		) 
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

	method venderAMercado() {
		const venta = cosecha.sum({cultivo => cultivo.valor()})
		granja.hayMercado(position)
		self.validarVentaAMercado()	
		granja.obtenerMercadoEn(position).recibirDe(self)
		oro += venta
		game.say(self, "gané" + venta + " oro")
		cosecha.clear()
	}

	method validarVentaAMercado() {
		return 	if (!granja.obtenerMercadoEn(position).puedeComprar(self) ){
			self.error("mercado no tiene fondos suficientes")
		}
	}

	method totalCosecha() {
		return cosecha.sum({cultivo => cultivo.valor()})
	}
/*
	method vendido() {
	}
*/

	method validarSembrar() {
		const posicion = self.position()
		return if(granja.hayCultivo(posicion)) {
			game.say(self, "no puedo sembrar aquí")
			self.error("ya hay un cultivo aquí")	 
		} 
	}

	method validarUbicacion(aparato) {
		const posicion = self.position()
		return if(!granja.hayCultivo(posicion) && granja.hayAspersor(posicion)) {
			game.say(self, "no puedo sembrar aquí")
			self.error("ya hay un cultivo aquí")	 
		} 
	}

	method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = false
	method esCultivo() = false
	method esAspersor() = false
	method esMercado() = false


}

object granja {

	// const utilidades = []

	method obtenerCultivoEn(posicion) {
		return game.getObjectsIn(posicion).find({cultivo => 
		cultivo.esCultivo()})
	}

	method validarRegar(posicion){
		if (not self.hayCultivo(posicion)){
			game.say(personaje, "Acá no hay cultivo para regar")
			self.error("Acá no hay cultivo para regar")
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

	method hayAspersor(posicion) {
		return game.getObjectsIn(posicion).any({
			cosa => cosa.esAspersor()
		})
	}

	method hayMercado(posicion){
		return game.getObjectsIn(posicion).any({
			cosa => cosa.esMercado()
		})
	}

	method obtenerMercadoEn(posicion) {
		return game.getObjectsIn(posicion).find({cosa => 
			cosa.esMercado()})
	}

		 /*if (self.hayMaiz(posicion)) {
			return new Maiz(position = posicion)}
			else if (self.hayTomaco(posicion)) {new Tomaco(position = posicion)}
			else if (self.hayTrigo(posicion)){new Trigo(position = posicion)}
			else {
				return self.error("no hay cultivo")
			}*/
	

	}



