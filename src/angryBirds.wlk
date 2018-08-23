class Pajaro {	
	var ira
	
	method enojarse(){
		ira *= 2
	}
	
	method tranquilizarse()	{
		ira -= 5
	}
	method fuerza()	{
		return ira * 2
	}
	method esFuerte(){
		return self.fuerza()>50
	}
	method puedeDerribar(obstaculo){
		return self.fuerza() > obstaculo.resistencia()
	}
}

class Rencoroso inherits Pajaro{
	var cantCosasEnojar = 0
	var multiplicador
	
	
	override method enojarse() {
		cantCosasEnojar += 1
		super()
	}
	
	override method fuerza(){
		return ira * multiplicador * cantCosasEnojar
	}	
}

object bomb inherits Pajaro(ira = 10){	
	var maximoFuerza = 9000
	override method fuerza()	{ 
		return super().min(maximoFuerza)
	}	
}

object chuck inherits Pajaro(ira = 10){	
	var velocidad = 100
	
	override method fuerza(){ 
		return 150 + 5 * 0.max(velocidad - 80)
	}	
	
	override method enojarse(){ 
		velocidad *= 2
	}
	override method tranquilizarse(){ 
	}	
}

object matilda inherits Pajaro(ira = 10){
	var huevos = [new Huevo(peso=5),new Huevo(peso = 3)]		
	override method fuerza(){ 
		return super() + huevos.sum({huevo => huevo.fuerza()})
	}
		
	override method enojarse()	{ 
		huevos.add(new Huevo(peso = 2))
	}		
}

class Huevo {
	var peso
	
	method fuerza()	{
		return peso
	}
}

object islaPajaro {
	var pajaros = []

	method agregarPajaro(pajaro){
		pajaros.add(pajaro)
	}
	
	method pajarosFuertes()	{  
		return pajaros.filter({pajaro => pajaro.esFuerte()})
	}
	
	method fuerza()	{
		return self.pajarosFuertes().sum({pajaro => pajaro.fuerza()})
	}
	method suceder(evento){
		pajaros.forEach({pajaro => evento.alterar(pajaro)})
	}
	
	method atacar(isla) {
		pajaros.forEach{pajaro => isla.recibirAtaque(pajaro)}
	}

}

object sesionDeManejoDeLaIra{
	method alterar(pajaro){
		pajaro.tranquilizarse()
	}
}	

class InvasionDeCerditos{
	var cantidadInvasores
	

	method alterar(pajaro){
		cantidadInvasores.div(100).times({x=>pajaro.enojarse()})
	}
}
	
class FiestaSorpresa{
	var homenajeados
	
	method alterar(pajaro){
		if(homenajeados.contains(pajaro))
			pajaro.enojarse()
		else if (homenajeados.isEmpty())
			throw new Exception("No puede haber una fiesta sorpresa sin homenajeados")
	}
}	
class SerieDeEventosDesafortunados{
	var eventos = [] 
	
	method alterar(pajaro){
		eventos.forEach{evento=>evento.alterar(pajaro)}
	}
}

object islaCerdito
{
	var obstaculos = []
	
	method agregarObstaculo(obstaculo) {
		obstaculos.add(obstaculo)
	}

	method libreDeObstaculos() {
		return obstaculos.isEmpty()
	}
	method recibirAtaque(pajaro) {
		if (!self.libreDeObstaculos() and pajaro.puedeDerribar(obstaculos.head())) 
			obstaculos.remove(obstaculos.head())
	}
}

class Pared
{
	var ancho
	var material // algo resistente

	method resistencia() {
		return material.resistencia()*ancho
	}
}

class Resistente {
	var property resistencia

}

object cerditoObrero {
	method resistencia(){
		return 50
	}
}

class CerditoArmado {
	var elemento // algo resistente
	
	method resistencia() {
		return 10 * elemento.resistencia()
	}
}
