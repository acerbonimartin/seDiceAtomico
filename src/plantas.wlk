object springfield{
	var centrales=#{centralAtomica,centralDeCarbon,centralEolica}
	var contaminan =#{}
	var noContaminan =#{}
	var necesidadEnergetica=20
	var riquezaSuelo=0.9
	var velocidadViento=10
	
	method necesidadEnergetica(cantidad){
			necesidadEnergetica=cantidad
	}
	method velocidadViento(){
		return velocidadViento
	}
	
	method riquezaSuelo(){
		return riquezaSuelo
	}
	method contaminan(){
		contaminan= centrales.filter{central=>central.contamina()}
		return contaminan
	}
	method noContaminan(){
		noContaminan = centrales.filter{central=>!(central.contamina())}
		return noContaminan
	}
	
	method estaEnElHorno(){
		self.contaminan()
		self.noContaminan()
		return (self.energiaDeContaminacion()>=necesidadEnergetica*0.5 || contaminan==centrales)
	}
	method energiaDeContaminacion(){
		return (contaminan.map{central=> central.produce()}).sum()
	}
	
	method energiaMayor(){
		return (self.energiaDeCentrales()).max()
	}
	method centralQueMasProduce(){
		return  (centrales.filter{central=>central.produce()==self.energiaMayor()}).find{true}
	}
	method energiaDeCentrales(){
		return centrales.map{central=>central.produce()}
	}
	method cubreNecesidades(){
		return (self.energiaDeCentrales()).sum() >=necesidadEnergetica
	}
}

object centralAtomica{
	var varillas=10
	
	method produce(){
		return varillas*0.1
	}
	method varillas(cantidad){
		varillas=cantidad
	}
	method contamina(){
		return varillas>20
	}
}

object centralDeCarbon{
	var capacidad=20
	
	method contamina(){
		return true
	}
	method produce(){
		return 0.5+capacidad*springfield.riquezaSuelo()
		
	}
}

object centralEolica{
	var turbinas= #{turbina1}
	
	method contamina(){
		return false
	}
	method produce(){
		return (turbinas.map {turbina => turbina.produce()}).sum()
	}
}


object turbina1{
	var produce=0.2
	
	method produce(){
		return produce*springfield.velocidadViento()
	}
}



object albuquerque {
	var centrales=#{centralHidroelectrica}
	var contaminan =#{}
	var noContaminan =#{}
	var necesidadEnergetica=20
	var riquezaSuelo=0.9
	var velocidadViento=10
	var caudalDeRio=150
	
	method necesidadEnergetica(cantidad){
		necesidadEnergetica=cantidad
	}
	method caudalDeRio(){
		return caudalDeRio
	}
	
	method velocidadViento(){
		return velocidadViento
	}
	
	method riquezaSuelo(){
		return riquezaSuelo
	}
	method contaminan(){
		contaminan= centrales.filter{central=>central.contamina()}
	}
	method noContaminan(){
		noContaminan = centrales.filter{central=>!(central.contamina())}
	}
	
	method estaEnElHorno(){
		self.contaminan()
		self.noContaminan()
		return (self.energiaDeContaminacion()>=necesidadEnergetica*0.5 || contaminan==centrales)
	}
	method energiaDeContaminacion(){
		return (contaminan.map{central=> central.produce()}).sum()
	}
	
	method energiaMayor(){
		return (self.energiaDeCentrales()).max()
	}
	method centralQueMasProduce(){
		return  (centrales.filter{central=>central.produce()==self.energiaMayor()}).find{true}
	}
	method energiaDeCentrales(){
		return centrales.map{central=>central.produce()}
	}
	method cubreNecesidades(){
		return self.energiaDeCentrales()>=necesidadEnergetica
	}

}

object centralHidroelectrica{
	var ciudad=albuquerque
	
	method produce(){
		return ciudad.caudalDeRio()*2	
	}
}

object region {
	var ciudades= #{}
	var coleccion= #{1,2,3,4}
	var coleccion3= #{a,b,c}
	
	method forEach1(){
		ciudades.forEach{ciudad=>ciudad.centralQueMasProduce()}
		return ciudades
	}
	method forEach2(){
		coleccion.forEach{nro=>nro+1}
		return coleccion
	}
	method forEach3() {
		coleccion3 =coleccion3.forEach{letra=> letra.numero()}
		return coleccion3
	}
	
	method centralesGrosas(){
		var centrales = #{}
		centrales =ciudades.map{ciudad=>ciudad.centralQueMasProduce()}
		return centrales	
	}
}
object a{
	method numero(){
		return 1
	}
}

object b {
	method numero(){
		return 2
	}
}
object c {
	method numero(){
		return 3
	}
}