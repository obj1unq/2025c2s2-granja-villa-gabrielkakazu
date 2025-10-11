import wollok.game.*
import personaje.*
import bonus.*

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

	method esMaiz() = true
	method esTrigo() = false
	method esTomaco() = false
	method esCultivo() = true
	method esAspersor() = false

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


	method regado(){
		if (position.y() == game.height()-1  )
			//&& not granja.hayCultivo(game.at(position.x(), 0)) )
		 	{position = game.at(position.x(), 0 )
		} else if (not granja.hayCultivo(self.position().up(1)))
		{
			self.position(self.position().up(1))
		}
	}

	method cosechado(){
		if (self.listoParaCosechar()){
			game.removeVisual(self)
		}	
	}

	method listoParaCosechar() = true
	method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = true
	method esCultivo() = true
	method esAspersor() = false
	

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
		evolucion.valor()
	}

	method cosechado(){
		if (self.listoParaCosechar()){
			game.removeVisual(self)
		}
	}

	method listoParaCosechar(){
		return evolucion.listoParaCosechar()
	}

	method esMaiz() = false
	method esTrigo() = true
	method esTomaco() = false
	method esCultivo() = true
	method esAspersor() = false
	
}

object trigo0 {

	method image() {
		return "wheat_0.png"
	}

	method regado(){
		return trigo1
	}

	method valor() = 0

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

	method valor() = 0
}

object trigo2 {

	method valor() = 100

	method image() {
		return "wheat_2.png"
	}
	method regado(){
		return trigo3
	}

	method listoParaCosechar() = true

}

object trigo3 {

	method valor() = 200

	method image() {
		return "wheat_3.png"
	}
	method regado(){
		return trigo0
	}

	method listoParaCosechar() = true
}

