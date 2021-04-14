object macowins {

	const ventas = []
	
	
	method ventasSegunFecha(unaFecha) =  ventas.filter({unaVenta => unaVenta.tieneFecha(unaFecha)})
	
	method ganancias(fecha){		
		self.ventasSegunFecha(fecha).sum({unaVentaSegunUnaFecha => unaVentaSegunUnaFecha.monto()})
	}
	
}

class Ventas {
	const fechaVenta
	const metodoPago
	const articulosVendidosPorVenta = []
	method tieneFecha(unaFecha) = unaFecha == fechaVenta
		
	method monto() = metodoPago.calcularMonto(self)
	method montoDeArticulosVentidos() = articulosVendidosPorVenta .sum({artVenta => artVenta.monto()})
    method sumaDeFraccionDeArticulosVentidos(fraccion) = articulosVendidosPorVenta .sum({artVenta => artVenta.fraccionDeMonto(fraccion)})
	
	
	
	//method montoArtVentidos()  = articulosVendidosPorVenta.sum({unArticuloPorVenta => unArticuloPorVenta.precioPorArticulos()})
}

class Efectivo {
	//citando a rasta: objeto chetardo ;)
	//method calculoDeMonto (unaVenta)  = unaVenta.montoArtVentidos()
	method calcularMonto(venta) = venta.montoDeArticulosVentidos()
}

class Tarjeta inherits Efectivo{
	
	const cuotas
	const coef
	// acá no sé qué onda si cumple a rajatabla lo que dice el enunciado xd (me confunde lo del valor de cada prenda, deberia ser responsabilida de
	// cada prenda calcularlo?? 
	// method calculoDeMonto (unaVenta) = cuotas * coef + 0.01 * unaVenta.montoArtVentidos()
	override method calcularMonto(venta) =  super(venta) + self.calcularRecargo(venta)
	method calcularRecargo(venta) = cuotas * coef + self.fraccionDeConceptos(0.01, venta)
    method fraccionDeConceptos(fraccion, venta) = venta.sumaDeFraccionDeArticulosVentidos(fraccion)
	
	
	
}

class Articulo {
	
	const prenda 
	const cantidad 
	method monto() = cantidad * prenda.precio()
    method fraccionDeMonto(fraccion) = cantidad * prenda.fraccionDePrecio(fraccion)
	
}
class Prenda {
	
	var property precio
	const estado
	method precioFinal() = estado.calculoAplicado(precio)
    method fraccionDePrecio(fraccion) = self.precio() * fraccion
}

class Pantalon inherits Prenda {
	
}

class Saco inherits Prenda {
	
}

class Camisa inherits Prenda {
	
}

object nueva {
	
	method calculoAplicado(precioPrenda) = precioPrenda 
}

class Promocion {
	
	const valorADescontar	
	method calculoAplicado(precioPrenda) = precioPrenda - valorADescontar
	
}

object liquidacion {
	
	method calculoAplicado(precioPrenda)  = precioPrenda * 0.5 
	
	
}


