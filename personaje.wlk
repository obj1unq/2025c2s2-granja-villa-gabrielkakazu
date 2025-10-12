import wollok.game.*
import cultivos.*
import bonus.*

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
		const renta = self.valorTotalCosecha()
		game.say(self, "gané " + renta + " oro")
		oro += renta 
		cosecha.clear()
	}

	method venderAMercado() {
		
			
		// granja.hayMercado(position)		//verifico que estoy en mercado
		const mercadito = granja.obtenerMercadoEn(position)	//obtengo el objeto mercadito
		
		// self.validarVentaAMercado()	
	
		const venta = self.valorTotalCosecha() //mi ganancia
		oro += venta	
		
		mercadito.recibirDe(self)	//paso la operación

		game.say(self, "gané" + venta + " oro")
		cosecha.clear()
	}

	method validarVentaAMercado() {
		return 	if (not granja.hayMercado(position)) {
			game.say(self, "No estoy en un mercado")
		//	self.error("no hay mercado")
		}		
		else if (!granja.obtenerMercadoEn(position).puedeComprar(self) ){
			game.say(self, "El mercado no me puede comprar mi cosecha")
		//	self.error("no hay fondos en mercado")
		}
	}

	method valorTotalCosecha() {
			return cosecha.sum({cultivo => cultivo.valor()})
	}
/*
	method vendido() {
	}
*/

	method validarSembrar() {
		const posicion = self.position()
		return if(granja.hayCultivo(posicion) or granja.hayAparato(posicion)) {
			game.say(self, "no puedo sembrar aquí")
			self.error("no se puede sembrar")	 
		} 
	}

	method validarUbicacion(aparato) {
		const posicion = self.position()
		return if(granja.hayCultivo(posicion) or granja.hayAspersor(posicion)) {
			game.say(self, "no se puede instalar aquí")
			self.error("no se puede instalar aquí")	 
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

	method obtenerMercadoEn(posicion) {
		return game.getObjectsIn(posicion).find({cosa => 
			cosa.esMercado()})
	}

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

	method hayAparato(posicion) {
		return  self.hayAspersor(posicion) or self.hayMercado(posicion)
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

}



