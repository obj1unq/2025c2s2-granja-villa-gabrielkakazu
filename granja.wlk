import wollok.game.*
import personaje.*
import cultivos.*
import bonus.*

object granja {

	// const utilidades = []

	method obtenerMercadoEn(posicion) {
		return game.getObjectsIn(posicion).find({cosa => 
			identificador.esMercado(cosa)})
	}

	method obtenerCultivoEn(posicion) {
		return game.getObjectsIn(posicion).find({cultivo => 
		identificador.esCultivo(cultivo)})
	}

	method validarRegar(posicion){
		if (not self.hayCultivo(posicion)){
			game.say(personaje, "Acá no hay cultivo para regar")
			self.error("Acá no hay cultivo para regar")
		}
	}

	method hayVisual(posicion) {
		return self.hayCultivo(posicion) or self.hayAparato(posicion)
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
			cultivo => identificador.esTrigo(cultivo)
		})
	}

	method hayMaiz(posicion) {
		return game.getObjectsIn(posicion).any({
			cultivo => identificador.esMaiz(cultivo)
		})
	}

	method hayTomaco(posicion) {
		return game.getObjectsIn(posicion).any({
			cultivo => identificador.esTomaco(cultivo)
		})
	}

	method hayAspersor(posicion) {
		return game.getObjectsIn(posicion).any({
			cosa => identificador.esAspersor(cosa)
		})
	}

	method hayMercado(posicion){
		return game.getObjectsIn(posicion).any({
			cosa => identificador.esMercado(cosa)
		})
	}

	method obtenerObjetoEn(esObjeto, posicion) {
		return game.getObjectsIn(posicion).find({cosa => 
		cosa.apply{esObjeto}})
	}

    method obtenerAspersorEn(posicion) {
		return game.getObjectsIn(posicion).find({cosa => 
			identificador.esAspersor(cosa)})
	}

}

object identificador{
	method esMaiz(cosa)  {return 
				cosa.image() == "corn_baby.png" 
				or cosa.image() == "corn_adult.png"}
	method esTrigo(cosa) {return 
			cosa.image() == "wheat_0.png" or
			cosa.image() == "wheat_1.png" or
			cosa.image() == "wheat_2.png" or
			cosa.image() == "wheat_3.png" }
	method esTomaco(cosa) {return cosa.image() == "tomaco_baby.png"}
	method esCultivo(cosa) {return 
		self.esMaiz(cosa) or self.esTrigo(cosa) or self.esTomaco(cosa)}
	method esAspersor(cosa) {return cosa.image() == "aspersor.png"}
	method esMercado(cosa) {return cosa.image() == "market.png"}
    method esPj(cosa) {return cosa.image() == "mplayer.png"}
	method noEsCultivo(cosa){return not cosa.esCultivo(cosa)}
	method noEsAspersor(cosa) {return not self.esAspersor(cosa)}
	method noEsMercado(cosa) {return not cosa.esMercado(cosa)}
}
