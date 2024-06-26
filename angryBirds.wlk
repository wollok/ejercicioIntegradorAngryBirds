class Pajaro {
	var ira
	
	method enojarse() {
		ira *= 2
	}
	
	method tranquilizarse() {
		ira -= 5
	}
	
	method fuerza() = ira * 2
	
	method esFuerte() = self.fuerza() > 50
	
	method puedeDerribar(obstaculo) = self.fuerza() > obstaculo.resistencia()
}

const pajarito = new Pajaro(ira = 10)

class Rencoroso inherits Pajaro {
	var cantCosasEnojar = 1
	const multiplicador
	
	override method enojarse() {
		cantCosasEnojar += 1
		
		super()
	}
	
	override method fuerza() = (ira * multiplicador) * cantCosasEnojar
}

const red = new Rencoroso(ira = 10, multiplicador = 10)

const terence = new Rencoroso(ira = 10, multiplicador = 2)

object bomb inherits Pajaro (ira = 10) {
	const maximoFuerza = 9000
	
	override method fuerza() = super().min(maximoFuerza)
}

object chuck inherits Pajaro (ira = 10) {
	var velocidad = 100
	
	override method fuerza() = 150 + (5 * 0.max(velocidad - 80))
	
	override method enojarse() {
		velocidad *= 2
	}
	
	override method tranquilizarse() {
		
	}
}

object matilda inherits Pajaro (ira = 10) {
	const huevos = [new Huevo(peso = 5), new Huevo(peso = 3)]
	
	override method fuerza() = super() + huevos.sum({ huevo => huevo.fuerza() })
	
	override method enojarse() {
		huevos.add(new Huevo(peso = 2))
	}
}

class Huevo {
	var property peso
	
	method fuerza() = peso
}

object islaPajaro {
	const pajaros = [pajarito, red, bomb, chuck, terence, matilda]
	
	method agregarPajaro(pajaro) {
		pajaros.add(pajaro)
	}
	
	method pajarosFuertes() = pajaros.filter({ pajaro => pajaro.esFuerte() })
	
	method fuerza() = self.pajarosFuertes().sum({ pajaro => pajaro.fuerza() })
	
	method suceder(evento) {
		pajaros.forEach({ pajaro => evento.alterar(pajaro) })
	}
	
	method atacar(isla) {
		pajaros.forEach({ pajaro => isla.recibirAtaque(pajaro) })
	}
}

object sesionDeManejoDeLaIra {
	method alterar(pajaro) {
		pajaro.tranquilizarse()
	}
}

class InvasionDeCerditos {
	var property cantidadInvasores
	
	method alterar(pajaro) {
		cantidadInvasores.div(100).times({ x => pajaro.enojarse() })
	}
}

class FiestaSorpresa {
	var property homenajeados
	
	method alterar(pajaro) {
		if (homenajeados.contains(pajaro)) {
			pajaro.enojarse()
		} else {
			if (homenajeados.isEmpty()) {
				throw new Exception(
					message = "No puede haber una fiesta sorpresa sin homenajeados"
				)
			}
		}
	}
}

class SerieDeEventosDesafortunados {
	const eventos = []
	
	method alterar(pajaro) {
		eventos.forEach({ evento => evento.alterar(pajaro) })
	}
}

object islaCerdito {
	const obstaculos = [
		paredPiedra,
		paredVidrio,
		paredMadera,
		otraParedVidrio,
		cerditoObrero,
		cerditoCasco,
		cerditoEscudo,
		cerditoObrero
	]
	
	method agregarObstaculo(obstaculo) {
		obstaculos.add(obstaculo)
	}
	
	method libreDeObstaculos() = obstaculos.isEmpty()
	
	method recibirAtaque(pajaro) {
		if ((!self.libreDeObstaculos()) and pajaro.puedeDerribar(obstaculos.head()))
			obstaculos.remove(obstaculos.head())
	}
}

class Resistente {
	var property resistencia
}

const vidrio = new Resistente(resistencia = 10)

const madera = new Resistente(resistencia = 25)

const piedra = new Resistente(resistencia = 50)

const casco = new Resistente(resistencia = 20)

const escudo = new Resistente(resistencia = 50)

class Pared {
	var property ancho
	var property material // algo resistente
	
	method resistencia() = material.resistencia() * ancho
}

const paredPiedra = new Pared(ancho = 5, material = piedra)

const paredMadera = new Pared(ancho = 2, material = madera)

const paredVidrio = new Pared(ancho = 10, material = vidrio)

const otraParedVidrio = new Pared(ancho = 1, material = vidrio)

object cerditoObrero {
	method resistencia() = 50
}

class CerditoArmado {
	var property elemento // algo resistente
	
	method resistencia() = 10 * elemento.resistencia()
}

const cerditoCasco = new CerditoArmado(elemento = casco)

const cerditoEscudo = new CerditoArmado(elemento = escudo)