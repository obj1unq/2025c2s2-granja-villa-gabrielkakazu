import wollok.game.*
import cultivos.*
import bonus.*
import granja.*

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

	method ejecutarAspersor(){
		if (granja.hayAspersor(position)){
			granja.obtenerAspersorEn(position).ejecutar()
		}
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

// BONUS
	method venderAMercado() {
		
		const mercadito = granja.obtenerMercadoEn(position)	//obtengo el objeto mercadito
		
		 self.validarVentaAMercado()	
	
		const venta = self.valorTotalCosecha() //mi ganancia
		oro += venta	
		
		mercadito.recibirDe(self)	//paso la operación

		game.say(self, "gané" + venta + " oro")
		cosecha.clear()
	}

	method validarVentaAMercado() {
		return 	if (not granja.hayMercado(position)) {
			game.say(self, "No estoy en un mercado")
			self.error("no hay mercado")
		}		
		else if (!granja.obtenerMercadoEn(position).puedeComprar(self) ){
			game.say(self, "El mercado no me puede comprar mi cosecha")
			self.error("no hay fondos en mercado")
		}
	}

	method valorTotalCosecha() {
			return cosecha.sum({cultivo => cultivo.valor()})
	}


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



}


