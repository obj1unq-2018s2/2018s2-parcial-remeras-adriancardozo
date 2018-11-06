object comercio {
	const sucursales = #{}
	const pedidos = #{}
	method registrarPedido(pedido){
		pedidos.add(pedido)
	}
	method agregarSucursal(sucursal){
		sucursales.add(sucursal)
	}
	method totalFacturado() = pedidos.sum { pedido => pedido.precio() }
	method totalFacturadoSucursal(sucursal) = (self.pedidosDe(sucursal)).sum { pedido => pedido.precio() }
	method cantidadDePedidosDeColor(color) = pedidos.count { pedido => pedido.modelo().color() == color }
	method pedidoMasCaro() = pedidos.max { pedido => pedido.precio() }
	method tallesSinPedidos() = self.talles().difference(self.tallesConPedidos()) 
	method tallesConPedidos() = pedidos.map { pedido => pedido.modelo().talle() }.asSet()
	method sucursalQueMasFacturo() = sucursales.max { sucursal => self.totalFacturadoSucursal(sucursal) }
	method sucursalesQueVendieronTodosLosTalles() = sucursales.filter { sucursal => self.vendioTodosLosTalles(sucursal) }
	method vendioTodosLosTalles(sucursal) = self.pedidosDe(sucursal).map { pedido => pedido.modelo().talle() }.asSet().equals(self.talles())
	method pedidosDe(sucursal) = pedidos.filter { pedido => pedido.sucursal() == sucursal }
	method talles() = new Range(32, 48)
}

class Sucursal {
	const cantidadMinimaParaDescuento = 0
	method aplicaDescuentoA(pedido) = pedido.cantidad() >= cantidadMinimaParaDescuento
}

class Pedido {
	var property sucursal
	var property modelo
	var property cantidad = 0
	method precio() = if(sucursal.aplicaDescuentoA(self)) self.precioBase() - self.descuento() else self.precioBase()
	method precioBase() = modelo.costo() * cantidad
	method descuento() = self.precioBase() * (modelo.porcentajeDescuento() / 100)
}
