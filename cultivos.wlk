import wollok.game.*

class Maiz {

	const valor = 150

	method valor() {return valor }

	method position() {
		// TODO: hacer que aparezca donde lo plante Hector
		return game.at(1, 1)
	}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_baby.png"
	}

	method sembrado(){

	}

	method regado(){

	}
}

const maiz = new Maiz()

object bebe {

}

object adulto {

}

class Trigo {
	var evolucion = 0

	method evolucion() {return }

	method position() {

	}

	method image() {
		return "wheat_0.png"
	}

	method sembrado(){

	}


	method regado(){
		
	}

	method valor(){

	}
}

const trigo = new Trigo()

class Tomaco {
	const valor = 80

	method valor() {return valor}

	method position() {

	}

	method image() {
		return "tomaco_baby.png"
	}

	method sembrado(){
		
	}


	method regado(){
		
	}

}

const tomaco = new Tomaco()

