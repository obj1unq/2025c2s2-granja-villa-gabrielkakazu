import wollok.game.*
import personaje.*
import bonus.*
import granja.*

class Maiz {

	const valor = 150
	var property position 
	var property estado = bebe

	method valor() {return valor }

	method image() {
		return estado.image()
	}

	method regado(){
		estado = adulto
	}

	 method sembradoPor(sembrador){
		const nuevoMaiz = new Maiz(position = sembrador.position())

	} 

	method cosechado(){
		if (self.listoParaCosechar()){
			game.removeVisual(self)
		}
	}

	method listoParaCosechar(){
		return estado.listoParaCosechar()
	}

	method esTrigo() = false

}

const maiz = new Maiz(position = game.at(1,1) )

object bebe {

	method image() {
		return "corn_baby.png"
	}

	method listoParaCosechar() = false

}

object adulto {

	method image() {
		return "corn_adult.png"
	}

	method listoParaCosechar() = true


}

class Tomaco {
	const valor = 80
	var property position

	method valor() {return valor}

	method image() {
		return "tomaco_baby.png"
	}

	method sembradoPor(sembrador){
		const nuevoTomaco = new Tomaco(position = sembrador.position())
	} 	

/*
	method regado0(){
		if (position.y() == game.height()-1  )
			//&& not granja.hayCultivo(game.at(position.x(), 0)) )
		 	{position = game.at(position.x(), 0 )
		} else if (not granja.hayCultivo(self.position().up(1)))
		{
			self.position(self.position().up(1))
		}
	} */


	method regado(){
		const arribaDeTodo = game.height()-1
		const abajoDeTodo = game.at(position.x(), 0)

		if (not granja.hayVisual(self.position().up(1)) 
			&& position.y() < arribaDeTodo) {
				self.position(self.position().up(1))
		} else if (position.y() == arribaDeTodo &&
			not granja.hayVisual(abajoDeTodo)) {
				position = abajoDeTodo
		}
	}

	method cosechado(){
		if (self.listoParaCosechar()){
			game.removeVisual(self)
		}	
	}

	method listoParaCosechar() = true

	method esCultivo() = true
	method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = true
	method esAspersor() = false
	method esMercado() = false

}

class Trigo {
	var property evolucion = trigo0
	var property position 

	method image() {
		return evolucion.image()
	}

	method sembradoPor(sembrador){
		const trigo = new Trigo(position = sembrador.position())
	}

	
	method regado(){
		evolucion = evolucion.regado()
	}

	method valor(){
		return evolucion.valor()
	}

	method cosechado(){
		if (self.listoParaCosechar()){
			game.removeVisual(self)
		}
	}

	method listoParaCosechar(){
		return evolucion.listoParaCosechar()
	}

	method esTrigo() = true
	method loQueSoy(cosa) = identificador.esTrigo(cosa)

	
}

object trigo0 {

	method image() {
		return "wheat_0.png"
	}

	method regado(){
		return trigo1
	}

	method valor() {return 0}

	method listoParaCosechar() = false

}

object trigo1 {

	method image() {
		return "wheat_1.png"
	}

	method regado(){
		return trigo2
	}

	method listoParaCosechar() = false

	method valor() {return 0}
}

object trigo2 {

	method valor() {return 100}

	method image() {
		return "wheat_2.png"
	}
	method regado(){
		return trigo3
	}

	method listoParaCosechar() = true

}

object trigo3 {

	method valor() {return 200}

	method image() {
		return "wheat_3.png"
	}
	method regado(){
		return trigo0
	}

	method listoParaCosechar() = true
}

