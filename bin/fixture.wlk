import angryBirds.*

object fixture {

	const pajarito = new Pajaro(10)
	const red = new Rencoroso(10,10)
	const terence = new Rencoroso(10,2)
	
	const vidrio = new Resistente(10) 
	const madera = new Resistente(25) 
	const piedra = new Resistente(50) 
	const casco = new Resistente(20)
	const escudo = new Resistente(50)
	
	const paredPiedra = new Pared(5, piedra)
	const paredMadera = new Pared(2, madera)
	const paredVidrio = new Pared(10, vidrio)
	const otraParedVidrio = new Pared(1, vidrio)
	const cerditoCasco = new CerditoArmado(casco)
	const cerditoEscudo = new CerditoArmado(escudo)

	method pajarito() = pajarito
	method red() = red
	method terence() = terence

	method cerditoCasco() = cerditoCasco
	
	method iniciarIslaPajaro() {
		red.enojarse()
		terence.enojarse()
		islaPajaro.agregarPajaro(pajarito)
		islaPajaro.agregarPajaro(red)
		islaPajaro.agregarPajaro(bomb)
		islaPajaro.agregarPajaro(chuck)
		islaPajaro.agregarPajaro(terence)
		islaPajaro.agregarPajaro(matilda)
	}
	
	method iniciarIslaCerdito(){
		islaCerdito.agregarObstaculo(paredPiedra)
		islaCerdito.agregarObstaculo(paredVidrio)
		islaCerdito.agregarObstaculo(paredMadera)
		islaCerdito.agregarObstaculo(otraParedVidrio)
		islaCerdito.agregarObstaculo(cerditoObrero)
		islaCerdito.agregarObstaculo(cerditoCasco)
		islaCerdito.agregarObstaculo(cerditoEscudo)
		islaCerdito.agregarObstaculo(cerditoObrero)
	}
}