import wollok.game.*

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

class Trigo {
	var property evolucion = trigo0
	var property position 

	method image() {
		return evolucion.image()
	}

	method sembrado(sembrador){
		const trigo = new Trigo(position = sembrador.position())
		game.addVisual(trigo)


	}

	method esCultivo() = true


	method regado(){
		
	}

	method valor(){

	}

	method cosechado(){
		
	}

	method listoParaCosechar(){
		return evolucion > 2
	}

	method esMaiz() = false
	method esTrigo() = true
	method esTomaco() = false
	
}

object trigo0 {

	method image() {
		return "wheat_0.png"
	}

	method listoParaCosechar() = false

}

class Tomaco {
	const valor = 80
	var property position

	method valor() {return valor}

	method image() {
		return "tomaco_baby.png"
	}

	method sembrado(){
		
	}

	method esCultivo() = true


	method regado(){
		
	}

	method cosechado(){
		
	}

	method listoParaCosechar() = true

	method esMaiz() = false
	method esTrigo() = false
	method esTomaco() = true
	

}

