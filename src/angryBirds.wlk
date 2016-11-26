class IslaPajaro {
	var pajaros = []
	
	constructor (pajarosIsla)	{
		pajaros = pajarosIsla
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

class Huevo {
	var peso
	
	constructor (_peso)	{
		peso = _peso
	}
	
	method fuerza()	{
		return peso
	}
}

class Pajaro {	
	var ira
	
	constructor (_ira){
		ira = _ira
	}
	
	method enojarse(){
		ira *= 2
	}
	
	method tranquilizarse()	{
		ira -= 5
	}
	method fuerza()	{
		return ira * 2
	}
}

class Rencoroso inherits Pajaro{
	var cantCosasEnojar = 0
	var multiplicador
	
	constructor(_ira,_cosas,_multiplicador) = super(_ira) {
		cantCosasEnojar = _cosas
		multiplicador = _multiplicador
	}
	
	override method enojarse() {
		cantCosasEnojar += 1
		super()
	}
	
	override method fuerza(){
		return super() * multiplicador * cantCosasEnojar
	}	
}

object bomb inherits Pajaro(ira){	
	var maximoFuerza = 9000
	override method fuerza()	{ 
		return super().min(maximoFuerza)
	}	
}

object chuck inherits Pajaro(ira){	
	var velocidad = 1
	
	override method fuerza(){ 
		return 150 + 5 * 0.max(velocidad - 80)
	}	
	
	override method enojarse(){ 
		velocidad *= 2
	}
	override method tranquilizarse(){ 
	}	
}

object matilda inherits Pajaro(ira){
	var huevos = []		
	override method fuerza(){ 
		return super() + huevos.sum({huevo => huevo.fuerza()})
	}
		
	override method enojarse()	{ 
		huevos.add(new Huevo(2))
	}		
}

object sesionDeManejoDeLaIra{
	method alterar(pajaro){
		pajaro.tranquilizarse()
	}
}	

class InvasionDeCerditos{
	var cantidadInvasores = 100

	method alterar(pajaro){
		cantidadInvasores.div(100).times({pajaro.enojarse()})
	}
}
	
class FiestaSorpresa{
	var homenajeados = []
	
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

class IslaCerdito
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
	constructor(anchoPared, materialPared)	{
		ancho = anchoPared
		material = materialPared
	}
	method resistencia() {
		return materialPared.resistencia()*ancho
	}
}

class Resistente {
	var resistencia

	constructor(resis)	{
		resistencia = resis
	}

	method resistencia() {
		return resistencia
	}
	
}

class CerditoObrero {
	method resistencia(){
		return 50
	}
}

class CerditoArmado {
	var elemento // algo resistente
	constructor(elem)	{
		elemento = elem
	}
	
	method resistencia() {
		return 10 * elemento.resistencia()
	}
}
