class RemeraLisa {
	const property talle = 32
	const color = "Blanco"
	const precioTallesChicos = 80
	const precioTallesGrandes = 100
	method costo() = self.costoBasico() + if(not self.esDeColorBasico()) self.costoBasico() * 0.1 else 0
	method costoBasico() = if(talle.between(32, 40)) precioTallesChicos else precioTallesGrandes
	method esDeColorBasico() = self.coloresBasicos().contains(color)
	method coloresBasicos() = #{"Blanco","Gris","Negro"}
	method porcentajeDescuento() = 10
}

class RemeraBordada inherits RemeraLisa {
	const cantidadDeColoresBordado = 0
	override method costo() = super() + 20.max(10 * cantidadDeColoresBordado)
	override method porcentajeDescuento() = 2
}

class RemeraSublimada inherits RemeraLisa {
	const anchoSublimado = 0
	const altoSublimado = 0
	const sublimadoDeEmpresa = false
	var empresa
	override method costo() = super() + self.costoSublimado()
	method superficieSublimado() = anchoSublimado * altoSublimado
	method costoSublimado() = self.superficieSublimado() * 0.5 + if(sublimadoDeEmpresa) empresa.precioDerechosAutor() else 0 
	override method porcentajeDescuento() = if(sublimadoDeEmpresa and empresa.tieneConvenio()) 20 else super()
}

class Empresa {
	const property tieneConvenio = false
}
