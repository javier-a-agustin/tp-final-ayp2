with Ada.Text_IO,
     Ada.Strings.Unbounded,
     Ada.Text_IO.Unbounded_IO,
     Ada.Integer_Text_IO,
     Ada.Float_Text_IO,utiles,fechas,lista,pila,cola,arbol;
use Ada.Text_IO,
     Ada.Strings.Unbounded,
     Ada.Text_IO.Unbounded_IO,
     Ada.Integer_Text_IO,
    Ada.Float_Text_IO,utiles,fechas;

--Viandas, Pedidos, Clientes, Platos



procedure Tpfinal is


   --Viandas
   subtype tipoClaveVianda is Unbounded_String; -- Nombre
   type tipoInfoVianda is record
      cantidad: integer;
      precioIndividual: float;
   end record;

   package p_viandas is new lista(tipoClaveVianda, tipoInfoVianda, "<", "=");
   use p_viandas;

   --Clientes
   subtype tipoClaveCliente is integer; -- DNI
   type tipoInfoCliente is record
      nombre: Unbounded_String;
      apellido: Unbounded_String;
      direccion: Unbounded_String;
      telefono: Unbounded_String;
   end record;

   package p_clientes is new arbol(tipoClaveCliente, tipoInfoCliente, ">", "<", "=");
   use p_clientes;

   --Platos
   subtype tipoClavePlato is Unbounded_String; -- Nombre
   type tipoInfoPlato is record
      cantidad: integer;
      precioIndividual: float;
   end record;

   package p_platos is new lista(tipoClavePlato, tipoInfoPlato, "<", "=");
   use p_platos;

   --Pedidos
   subtype tipoClavePedido is integer; -- Numero de pedido
   type tipoInfoPedido is record
      dniCliente: tipoClaveCliente;
      fechaPedido: tFecha;
      platos: p_platos.tipoLista;
      montoTotal: float;
   end record;

   package p_pedidos is new arbol(tipoClavePedido, tipoInfoPedido, ">", "<", "=");
   use p_pedidos;
   
   ---------------------------------------------- N4 ---------------------------------------

   function existeVianda(viandas: in p_viandas.tipoLista; nombreVianda: in tipoClaveVianda) return Boolean is
      info: tipoInfoVianda;
   begin
      p_viandas.recuClave(viandas, nombreVianda, info);     -- ADT LO
      return True;
      exception when p_viandas.claveNoExiste => return False;
   end existeVianda;
   
   function existePlato(platos: in p_platos.tipoLista; nombre: in tipoClavePlato) return boolean is
      info: tipoInfoPlato;
   begin
      begin
         p_platos.recuClave(platos, nombre, info); --ADT LO
         return True;
      exception
         when p_platos.claveNoExiste => return False;
      end;
   end existePlato;
   
   procedure cargarPlato (platos: in out p_platos.tipoLista; viandas: in p_viandas.tipoLista; total: in out Float) is
      vianda: tipoInfoVianda;
      plato: tipoClavePlato;
      info: tipoInfoPlato;
      cantidad: Integer;
      existe: boolean;
   begin
      plato := To_Unbounded_String(textoNoVacio("Ingrese el nombre del plato que desea agregar al pedido: "));  --U

      if existeVianda(viandas, plato) then                                                 --N3
         p_viandas.recuClave(viandas, plato, vianda);                                      --ADT LO

         existe := existePlato(platos, plato);                                             --N5
         if existe then
            recuClave(platos, plato, info);                                                --ADT LO
            Put("Este plato ya se encuentra en el pedido. Unidades: ");Put(Integer'image(info.cantidad));New_Line;
         else
            p_platos.insertar(platos, plato, info);                                             --ADT LO
         end if;

         Put("El precio por unidad es de: ");Put(Float'image(vianda.precioIndividual));New_Line;

         loop
            Put("Cantidad maxima de unidades: ");Put(Integer'image(vianda.cantidad));New_Line;
            cantidad := numeroEnt("Ingrese la cantidad de unidades que desea agregar: ");  --U
            if cantidad > vianda.cantidad then
               Put_Line("No hay suficientes viandas disponibles");
               cantidad := 0;
            end if;
            exit when cantidad > 0;
         end loop;

         info.precioIndividual := vianda.precioIndividual;
         info.cantidad := info.cantidad + cantidad;

         total := total + Float(cantidad) * vianda.precioIndividual;
      end if;
   end cargarPlato;

   ---------------------------------------------- N4 ---------------------------------------
   
   procedure cargarPlatos (platos: in out p_platos.tipoLista; viandas: in p_viandas.tipoLista; total: in out Float) is
   begin
      loop
         cargarPlato(platos, viandas, total);
         exit when not confirma("Desea a�adir otro plato?");                                   --U
      end loop;
   end cargarPlatos;

   procedure agregarCantidadInfo(nombreVianda: in tipoClaveVianda; viandas: in out p_viandas.tipoLista) is -- Cambiar en pseudoCodigo
      cantidadAAgregar: Integer;
      info: tipoInfoVianda;
      nuevaInfo: tipoInfoVianda;
      cantidad: Integer;
      precio: Float;
   begin
      cantidadAAgregar := numeroEnt("Ingrese la cantidad a agregar");
      p_viandas.recuClave(viandas, nombreVianda, info);
      cantidad := info.cantidad;
      precio := info.precioIndividual;

      nuevaInfo.precioIndividual := precio;
      nuevaInfo.cantidad := cantidadAAgregar + info.cantidad;   -- modificar(viandas, nombreVianda, info);

      modificar(viandas, nombreVianda, nuevaInfo);
   end agregarCantidadInfo;

   procedure quitarCantidadInfo(nombreVianda: in tipoClaveVianda; viandas: in out p_viandas.tipoLista) is     -- Cambiar en pseudocodigo
      cantidadAQuitar: Integer;
      nuevaCantidad: Integer;
      info: tipoInfoVianda;
      nuevaInfo: tipoInfoVianda;
      cantidad: Integer;
      precio: Float;
   begin
      cantidadAQuitar := numeroEnt("Ingrese la cantidad a quitar");

      p_viandas.recuClave(viandas, nombreVianda, info);

      cantidad := info.cantidad;
      precio := info.precioIndividual;

      nuevaCantidad := cantidad - cantidadAQuitar;

      if nuevaCantidad >= 0 then
         nuevaInfo.precioIndividual := precio;
         nuevaInfo.cantidad := nuevaCantidad;
         modificar(viandas, nombreVianda, nuevaInfo);
      else
         Put_Line("No se puede quitar esa cantidad de viandas");
      end if;
   end quitarCantidadInfo;

   function esMismaFecha(fechaDeseada: in tFecha; fechaPedido: in tFecha) return boolean is
   begin
      return ((fechaDeseada.dia = fechaPedido.dia) and (fechaDeseada.mes = fechaPedido.mes) and (fechaDeseada.anio = fechaPedido.anio));
   end esMismaFecha;

   function esMismoDNI(dniCliente: in integer; dniClienteActual: in integer) return boolean is
   begin
      return dniCliente = dniClienteActual;
   end esMismoDNI;

   procedure mostrarPlatos(platos: in p_platos.tipoLista) is
      clave: tipoClavePlato;
      info: tipoInfoPlato;
      long: Integer;
   begin
      long := longitud(platos);      -- ADT LO
      recuPrim(platos, clave);

      for num in 1..long loop
         p_platos.recuClave(platos, clave, info);
         Put(clave);Put("    ");Put(Integer'image(info.cantidad));Put("        ");Put(Float'Image(info.precioIndividual));New_Line;
         p_platos.recuSig(platos, clave, clave);
      end loop;
   end mostrarPlatos;

   function obtenerEnvio(montoTotal: in Float) return Float is
   begin
      return montoTotal * 0.1;
   end obtenerEnvio;

   ---------------------------------------------- N3 ---------------------------------
   function obtenerDNI return tipoClaveCliente is
      dni : tipoClaveCliente;
   begin
      loop
         dni := numeroEnt("Ingrese el DNI del cliente");    -- UTILES
         exit when dni > 0;
      end loop;
      return dni;
   end obtenerDNI;
   
   function existeCliente(clientes: in p_clientes.tipoArbol; dni: in tipoClaveCliente) return boolean is
      info : tipoInfoCliente;
   begin
      begin
         p_clientes.buscar(clientes, dni, info);    -- ADT ABB
         return True;
      exception
         when p_clientes.claveNoExiste => return False;--Put_line("No existe el cliente");

      end;
   end existeCliente;
   
   procedure solicitarFecha(fecha: out tFecha) is
      --fecha: tFecha;
   begin
      loop
         fecha.dia := enteroEnRango("Ingrese el dia", 0, 31);     -- Fechas
         fecha.mes := enteroEnRango("Ingrese el mes", 0, 12);     -- Fechas
         fecha.anio := enteroEnRango("Ingrese el año", 2000, 2020);  -- Fechas

         exit when esFechaCorrecta(fecha) = True;
      end loop;
   end solicitarFecha;
   
   procedure obtenerInfoPedido(info: in out tipoInfoPedido; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
      existe: boolean := False;
   begin
      loop
         info.dniCliente := obtenerDNI;                    --N3-

         if not existeCliente(clientes, info.dniCliente) then         --N3-
            Put_Line("No se ha encontrado un cliente registrado con este DNI");
         else
            existe := True;
         end if;
         exit when existe;
      end loop;

      Put_Line("Fecha del pedido");
      solicitarFecha(info.fechaPedido);                    --N3-
      cargarPlatos(info.platos, viandas, info.montoTotal); --N4-
   end obtenerInfoPedido;

   procedure crearPedido (info: out tipoInfoPedido) is      
   begin
      info.dniCliente := 0;
      p_platos.crear(info.platos); --ADT LO
      info.montoTotal := 0.0;
      info.fechaPedido.dia := 1;
      info.fechaPedido.mes := 1;
      info.fechaPedido.anio := 1;
   end crearPedido;

   function obtenerIdentificador return tipoClavePedido is
      identificador: tipoClavePedido;
   begin
      loop
         identificador := numeroEnt("Ingrese el numero de pedido: "); --U
         exit when identificador > 0;
      end loop;

      return identificador;
   end obtenerIdentificador;

   function existePedido(pedidos: in p_pedidos.tipoArbol; identificador: in tipoClavePedido) return boolean is
      info: tipoInfoPedido;
   begin
      begin
         p_pedidos.buscar(pedidos, identificador, info); --ADT ABB
         return True;
      exception
         when p_pedidos.claveNoExiste => return False;
      end;
   end existePedido;

   procedure guardarPedido(pedidos: in out p_pedidos.tipoArbol; identificador: in tipoClavePedido; info: in tipoInfoPedido) is
   begin
      begin
         insertar(pedidos, identificador, info); --ADT ABB
      exception
         when p_pedidos.arbolLleno => Put_Line("Ocurrio un error inesperado, reintente mas tarde");
      end;
   end guardarPedido;

   procedure eliminarPedido(pedidos: in out p_pedidos.tipoArbol; identificador: in tipoClavePedido) is
      info: tipoInfoPedido;
   begin
      begin
         p_pedidos.buscar(pedidos, identificador, info);  --ADT ABB
         p_platos.vaciar(info.platos);                    --ADT LO
         p_pedidos.suprimir(pedidos, identificador);      --ADT ABB
      exception
         when others => Put_Line("Ocurrio un error, intente mas tarde");
      end;
   end eliminarPedido;

   procedure obtenerInfoCliente(info: out tipoInfoCliente) is
   begin
      info.nombre := To_Unbounded_String(textoNoVacio("Ingrese el nombre del cliente"));
      info.apellido := To_Unbounded_String(textoNoVacio("Ingrese el apelllido del cliente"));
      info.telefono := To_Unbounded_String(textoNoVacio("Ingrese el telefono del cliente"));
      info.direccion := To_Unbounded_String(textoNoVacio("Ingrese la direccion del cliente"));
   end obtenerInfoCliente;

   procedure guardarCliente(cliente: in out p_clientes.tipoArbol; dni: in tipoClaveCliente; info: in tipoInfoCliente) is
   begin
      begin
         insertar(cliente, dni, info);     -- ADT ABB
      exception
         when p_clientes.arbolLleno => Put_Line("Ocurrio un error inesperado, reintente mas tarde");
      end;
   end guardarCliente;

   procedure modificacionCliente(cliente: in out p_clientes.tipoArbol; dni: in tipoClaveCliente; info: in tipoInfoCliente) is
   begin
      begin
         modificar(cliente, dni, info);     -- ADT ABB
      exception
         when p_clientes.claveNoExiste => Put_Line("Ocurrio un error inesperado, intente mas tarde");
      end;
   end modificacionCliente;

   procedure eliminarCliente(clientes: in out p_clientes.tipoArbol; dni: in tipoClaveCliente) is
   begin
      begin
         suprimir(clientes, dni);       -- ADT ABB
      exception
         when p_clientes.claveNoExiste => Put_Line("Ocurrio un error inesperado, intente mas tarde");
      end;
   end eliminarCliente;

   function clienteTienePedidos(pedidos: in p_pedidos.tipoArbol; dni: in tipoClaveCliente) return Boolean is
      q : p_pedidos.ColaRecorridos.tipoCola;
      k : tipoClavePedido;
      encontrado : Boolean;
      i : tipoInfoPedido;
   begin
      p_pedidos.ColaRecorridos.crear(q);          -- ADT Cola
      postOrder(pedidos, q);       -- ADT Cola
      loop


         p_pedidos.ColaRecorridos.frente(q, k);           -- ADT Cola
         p_pedidos.buscar(pedidos, k, i);
         If i.dniCliente = dni then
            encontrado := True;
         end if;
         p_pedidos.ColaRecorridos.desencolar(q);            -- ADT Cola

         exit when p_pedidos.ColaRecorridos.esVacia(q) = True or encontrado = True;


      end loop;
      exception when p_pedidos.ColaRecorridos.colaVacia => null;
      If encontrado = True then
         return True;
      else
         return False;
      end If;
   end clienteTienePedidos;

   function obtenerNombreVianda return Unbounded_String is
   begin
      return To_Unbounded_String(textoNoVacio("Ingrese el nombre de la vianda"));
   end obtenerNombreVianda;

   function obtenerCantidad return Integer is
      num: Integer;
   begin
      loop
         num := numeroEnt("Ingrese la cantidad de viandas");
         exit when num > 0;
      end loop;
      return num;
   end obtenerCantidad;

   procedure cargarViandaN(viandas: in out p_viandas.tipoLista; nombreVianda: in tipoClaveVianda; cantidad: in Integer) is
      PRECIODEF : constant Float := -1.0;
      info: tipoInfoVianda;
   begin
      info.cantidad := cantidad;
      info.precioIndividual := PRECIODEF;

      insertar(viandas, nombreVianda, info);      -- ADT LO

   exception
      when p_viandas.claveExiste => Put_Line("Esa vianda ya esta cargada");
      when p_viandas.listaLlena => Put_Line("Ocurrio un error inesperado, intente mas tarde");
   end cargarViandaN;

   function obtenerPrecio return float is
      num: Float;
   begin
      loop
         num := numeroReal("Ingrese el precio");
         exit when num > 0.0;
      end loop;
      return num;
   end obtenerPrecio;

   procedure cargarPrecioN(viandas: in out p_viandas.tipoLista; nombreVianda: in tipoClaveVianda; precio: in Float) is
      info: tipoInfoVianda;
   begin
      p_viandas.recuClave(viandas, nombreVianda, info);       -- ADT LO

      if (info.precioIndividual /= -1.0) then
         Put_Line("El precio de esta vianda ya esta cargado");
      else
         begin
            info.precioIndividual := precio;
            modificar(viandas, nombreVianda, info);      -- ADT LO
         exception when p_viandas.listaLlena => Put_Line("Ocurrio un error inesperado, intente mas tarde");
         end;
      end if;
   end cargarPrecioN;

   function menuModificarViandas return Integer is
   begin
      Put_Line("Menu modificacion de viandas");
      Put_Line("1: Añadir cantidad Viandas");
      Put_Line("2: Eliminar cantidad de viandas");
      Put_Line("0: Volver");

      return enteroEnRango("Ingrese una opcion: ", 0, 2);
   end menuModificarViandas;

   procedure agregarCantidadVianda(viandas: in out p_viandas.tipoLista) is
      nombreVianda: tipoClaveVianda;
   begin
      loop
         nombreVianda := obtenerNombreVianda;      -- N3 listo

         if existeVianda(viandas, nombreVianda) then       -- N3 listo
            agregarCantidadInfo(nombreVianda, viandas);      -- N4
         else
            Put_Line("Esa vianda no esta cargada");
         end if;
         exit when confirma("Desea modificar otra (cantidad) vianda?") = False; --U
      end loop;
   end agregarCantidadVianda;

   procedure quitarCantidadViandas(viandas: in out p_viandas.tipoLista) is
      nombreVianda: tipoClaveVianda;
   begin
      loop
         nombreVianda := obtenerNombreVianda;       -- N3 listo

         if existeVianda(viandas, nombreVianda) then    -- N3 listo
            quitarCantidadInfo(nombreVianda, viandas);    -- N4
         else
            Put_Line("Esa vianda no esta cargada");
         end if;
         exit when confirma("¿Desea modificar otra (cantidad) vianda?") = False;
      end loop;
   end quitarCantidadViandas;

   procedure mostrarCabeceraListadosDia is
   begin
      Put_Line("ID        DIA        PRECIO                Direccion");
   end mostrarCabeceraListadosDia;

   function obtenerDireccion(dniCliente: in tipoClaveCliente; clientes: in p_clientes.tipoArbol) return String is
      info: tipoInfoCliente;
   begin
      p_clientes.buscar(clientes, dniCliente, info);     -- ADT ABB
      return To_String(info.direccion);
   end obtenerDireccion;

   procedure mostrarPedidoDia(pedidos: in p_pedidos.tipoArbol; numeroDePedido: in tipoClavePedido; fecha: in tFecha; clientes: in p_clientes.tipoArbol) is
      info: tipoInfoPedido;
      fechaPedido: tFecha;
      direccion: String:="";
   begin
      p_pedidos.buscar(pedidos, numeroDePedido, info);                           -- ADT ABB
      fechaPedido := info.fechaPedido;

      if esMismaFecha(fecha, fechaPedido) then                        -- N4
         direccion := obtenerDireccion(info.dniCliente, clientes);    -- N4
         Put(Integer'Image(numeroDePedido)); Put("    "); Put(fechaTexto(info.fechaPedido)); Put("    "); Put(Float'Image(info.montoTotal)); Put("            "); Put(direccion); New_Line;
      end if;
   end mostrarPedidoDia;

   procedure mostrarCabeceraListadoPedidosCliente is
   begin
      Put_Line("DNI            DIRECCION        PLATO            CANTIDAD        PRECIO");
   end mostrarCabeceraListadoPedidosCliente;

   procedure mostrarPedidoCliente(pedidos: in p_pedidos.tipoArbol; numeroDePedido: in tipoClavePedido; dniCliente: in tipoClaveCliente; direccion: in String) is
      dniClienteActual: Integer;
      platos: p_platos.tipoLista;
      info: tipoInfoPedido;
      envio: Float;
   begin
      p_pedidos.buscar(pedidos, numeroDePedido, info);
      dniClienteActual := info.dniCliente;

      if esMismoDNI(dniCliente, dniClienteActual) then              -- N4
         platos := info.platos;
         Put(Integer'Image(dniCliente)); Put(direccion); New_Line;
         mostrarPlatos(platos);                                     -- N4
         envio := obtenerEnvio(info.montoTotal);                    -- N4
         Put("TOTAL:  "); Put(Float'Image(info.montoTotal)); Put("  ENVIO:   "); Put(Float'Image(envio)); New_Line;
      end if;
   end mostrarPedidoCliente;

   ---------------------------------------------- N2 --------------------------------

   procedure bajaPedido(pedidos: in out p_pedidos.tipoArbol) is
      identificador: tipoClavePedido;
   begin
      loop
         identificador := obtenerIdentificador;                    --N3-
         if not existePedido(pedidos, identificador) then            --N3-
            Put("No se ha encontrado un pedido con el identificador dado");
         else
            eliminarPedido(pedidos, identificador);                  --N3-
         end if;
         exit when not confirma("Desea dar de baja otro pedido?");   --U
      end loop;
   end bajaPedido;

   procedure modificarPedido(pedidos: in out p_pedidos.tipoArbol; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
      identificador: tipoClavePedido;
      info: tipoInfoPedido;
   begin
      loop
         identificador := obtenerIdentificador;                 --N3-
         if not existePedido(pedidos, identificador) then         --N3-
            Put_Line("No se ha encontrado un pedido con el identificador dado");
         else
            p_pedidos.buscar(pedidos, identificador, info);
            obtenerInfoPedido(info, clientes, viandas);           --N3-
         end if;
         exit when not confirma("Desea modificar otro pedido?"); --U
      end loop;
   end modificarPedido;
   
   procedure altaPedido(pedidos: in out p_pedidos.tipoArbol; identificador: in out tipoClavePedido; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
      info: tipoInfoPedido;
   begin
      crearPedido(info);                                     --N3

      obtenerInfoPedido(info, clientes, viandas);            --N3-
      guardarPedido(pedidos, identificador, info);           --N3-
      identificador := identificador + 1;
   end altaPedido;

   procedure altaPedidos(pedidos: in out p_pedidos.tipoArbol; identificador: in out tipoClavePedido; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
   begin
      loop
         altaPedido(pedidos, identificador, clientes, viandas);
         exit when not confirma("�Desea ingresar otro pedido?"); --U
      end loop;
   end altaPedidos;

   function menuABMPedidos return Integer is
   begin
      Put_Line("Menu Modulo Pedidos");
      Put_Line("1: Cargar Pedido");
      Put_Line("2: Modificar Pedido");
      Put_Line("3: Eliminar Pedido");
      Put_Line("0: Volver");

      return enteroEnRango("Ingrese una opción:", 0, 3); --U
   end menuABMPedidos;

   function menuABMClientes return integer is
   begin
      Put_line ("Menu modulo Clientes");
      Put_line ("1: Alta Cliente");
      Put_line ("2: Modificar Cliente");
      Put_line ("3: Baja Cliente");
      Put_line ("0: Volver");

      return enteroEnRango("Ingrese una opcion", 0, 3);     -- UTILES
   end menuABMClientes;

   procedure altaCliente(clientes: in out p_clientes.tipoArbol) is
      dni : tipoClaveCliente;
      info : tipoInfoCliente;
   begin
      loop
	dni := obtenerDNI; 							-- N3
	If existeCliente(clientes, dni) then			-- N3
            Put_line ("El DNI del cliente se encuentra cargado");
	else
            obtenerInfoCliente(info); 					-- N3
            guardarCliente(clientes, dni, info);			-- N3
	end if;
	exit when not confirma("Desea ingresar otro cliente?");  		-- UTILES
      end loop;
   end altaCliente;

   procedure modificarCliente(clientes: in out p_clientes.tipoArbol) is
      dni : tipoClaveCliente;
      info: tipoInfoCliente;
   begin
      loop
         dni := obtenerDNI;	 				-- N3
         If existeCliente(clientes, dni) = False then            -- N3
            Put_line("El cleinte no existe");
         else
            obtenerInfoCliente(info); 					-- N3
            modificacionCliente(clientes, dni, info);	 			 -- N3
         end if;
         exit when confirma("Desea modificar otro cliente?") = False;       -- UTILES
      end loop;
   end modificarCliente;

   procedure bajaCliente(clientes: in out p_clientes.tipoArbol; pedidos: in p_pedidos.tipoArbol) is
      dni: tipoClaveCliente;
      info: tipoInfoCliente;
   begin
      loop
         dni := obtenerDNI; 	                                -- N3
         If existeCliente(clientes, dni) = False then	      -- N3
            Put_line("El cliente no existe");
         else
            If clienteTienePedidos(pedidos, dni) = True then        -- N3
               Put_line("El cliente tiene pedidos cargados, no puede darlo de baja");
            else
               eliminarCliente(clientes, dni);				-- N3
            end if;
         end if;
         exit when confirma("Desea dar de baja otro cliente") = False;  			-- UTILES
      end loop;
   end bajaCliente;

   function menuViandas return Integer is
   begin
      Put_Line("Menu Modulo Viandas");
      Put_Line("1: Cargar Viandas");
      Put_Line("2: Cargar Precios");
      Put_Line("3: Modificar Vianda");
      Put_Line("4: Eliminar Viandas");
      Put_Line("0: Volver");

      return enteroEnRango("Ingrese una opcion:", 0, 4);       -- U
   end menuViandas;

   procedure cargarViandas(viandas: in out p_viandas.tipoLista) is
      nombreVianda: tipoClaveVianda;
      cantidad: Integer;
   begin
      loop
         nombreVianda := obtenerNombreVianda;           -- N3

         if existeVianda(viandas, nombreVianda) then    -- N3
            Put_Line("Esa vianda ya esta cargada");
         else
            cantidad := obtenerCantidad;                -- N3
            cargarViandaN(viandas, nombreVianda, cantidad);      -- N3
         end if;
         exit when confirma("¿Desea ingresar otra vianda?") = False;       -- U
      end loop;
   end cargarViandas;

   procedure cargarPrecio(viandas: in out p_viandas.tipoLista) is
      nombreVianda: tipoClaveVianda;
      precio: float;
   begin
      loop
         nombreVianda := obtenerNombreVianda;             -- N3

         if existeVianda(viandas, nombreVianda) then
            precio := obtenerPrecio;                       -- N3
            cargarPrecioN(viandas, nombreVianda, precio);  -- N3 ----------
         else
            Put_Line("Esa vianda no existe");
         end if;
         exit when confirma("¿Desea ingresar otra vianda?") = False;       -- U
      end loop;
   end cargarPrecio;

   procedure menuModificarVianda(viandas: in out p_viandas.tipoLista) is
      resp: integer;
   begin
      loop
         resp := menuModificarViandas;                    -- N3
         case resp is
            when 1 => agregarCantidadVianda(viandas);     -- N3
            when 2 => quitarCantidadViandas(viandas);     -- N3
            when others => null;
         end case;
         exit when resp = 0;
      end loop;
   end menuModificarVianda;

   procedure eliminarViandas(viandas: in out p_viandas.tipoLista) is
   begin
      if confirma("¿Desea eliminar TODAS las viandas?") then
         p_viandas.vaciar(viandas);
      end if;
   end eliminarViandas;

   function menuListados return Integer is
   begin
      Put_Line("Menu Modulo Listados");
      Put_Line("1: Listar pedidos en un dia");
      Put_Line("2: Listar pedidos de un cliente");
      Put_Line("0: Volver");

      return enteroEnRango("Ingrese una opcion:", 0, 2);
   end menuListados;

   procedure listarPedidosDeDia(pedidos: in p_pedidos.tipoArbol; clientes: in p_clientes.tipoArbol) is
      colaPedidos: p_pedidos.ColaRecorridos.tipoCola; -------------------------
      fecha: tFecha;
      numeroDePedido: tipoClavePedido;
   begin
      mostrarCabeceraListadosDia;          --N3
      if esVacio(pedidos) then
         Put_Line("No hay pedidos para mostrar");
      else
         solicitarFecha(fecha);            -- N3
         p_pedidos.inOrder(pedidos, colaPedidos);    -- ADT ABB

         while p_pedidos.ColaRecorridos.esVacia(colaPedidos) /= True loop       -- ADT COLA
            p_pedidos.ColaRecorridos.frente(colaPedidos, numeroDePedido);       -- ADT COLA
            mostrarPedidoDia(pedidos, numeroDePedido, fecha, clientes);         -- N3
            p_pedidos.ColaRecorridos.desencolar(colaPedidos);                   -- ADT COLA
         end loop;
      end if;
      exception when p_pedidos.errorEnCola => continua("Ocurrio un error, intente mas tarde");
   end;

   procedure listarPedidosDeCliente(pedidos: in p_pedidos.tipoArbol; clientes: in p_clientes.tipoArbol) is
      dniCliente: Integer;
      colaPedidos: p_pedidos.ColaRecorridos.tipoCola;
      numeroDePedido: Integer;
      direccion: String:="";
   begin
      mostrarCabeceraListadoPedidosCliente;             -- N3
      if esVacio(pedidos) then
         Put_Line("No hay pedidos para mostrar");
      else
         dniCliente := numeroEnt("Ingrese el dni del cliente deseado");    -- U
         direccion := obtenerDireccion(dniCliente, clientes);                 -- N3
         p_pedidos.inOrder(pedidos, colaPedidos);                                      -- ADT ABB

         while p_pedidos.ColaRecorridos.esVacia(colaPedidos) /= True loop     -- ADT COLA
            p_pedidos.ColaRecorridos.frente(colaPedidos, numeroDePedido);     -- ADT COLA
            mostrarPedidoCliente(pedidos, numeroDePedido, dniCliente, direccion);      -- N3
            p_pedidos.ColaRecorridos.desencolar(colaPedidos);                        -- ADT COLA                                        -- ADT COLA
         end loop;
      end if;
   exception when p_pedidos.errorEnCola => continua("Ocurrio un error, intente mas tarde");
   end listarPedidosDeCliente;


   ---------------------------------------------- N1 --------------------------------
   
   procedure abmPedido(pedidos: in out p_pedidos.tipoArbol; identificador: in out tipoClavePedido; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
      resp: Integer;
   begin
      loop
         resp := menuABMPedidos;                                            --N2-
         case resp is
            when 1 => altaPedidos(pedidos, identificador, clientes, viandas);  --N2-
            when 2 => modificarPedido(pedidos, clientes, viandas);            --N2-
            when 3 => bajaPedido(pedidos);                          --N2-
            when others => null;
         end case;
         exit when resp = 0;
      end loop;
   end abmPedido;
   
   procedure crearEstructuras(clientes: out p_clientes.tipoArbol; viandas: in out p_viandas.tipoLista; pedidos: out p_pedidos.tipoArbol) is
   begin
      p_clientes.crear(clientes);
      p_viandas.crear(viandas);
      p_pedidos.crear(pedidos);
   end crearEstructuras;

   function menuPrincipal return integer is
   begin
      Put_Line("Menu Principal");
      Put_Line("1: Modulo Viandas");
      Put_Line("2: Modulo Clientes");
      Put_Line("3: Modulo Pedidos");
      Put_Line("4: Listados");
      Put_Line("0: Salir");

      return enteroEnRango("Ingrese una opcion", 0, 4); -- Utiles
   end menuPrincipal;

   procedure administrarViandas(viandas: in out p_viandas.tipoLista) is
      resp: Integer;
   begin
      loop
         resp := menuViandas;                        -- N2
         case resp is
            when 1 => cargarViandas(viandas);          -- N2
            when 2 => cargarPrecio(viandas);           -- N2
            when 3 => menuModificarVianda(viandas);    -- N2
            when 4 => eliminarViandas(viandas);        -- N2
            when others => null;
         end case;
         exit when resp = 0;
      end loop;
   end administrarViandas;

   procedure abmCliente(clientes: in out p_clientes.tipoArbol; pedidos: in p_pedidos.tipoArbol) is
      resp : integer;
   begin
      loop
         resp := menuABMClientes;                    -- N2
         case resp is
            when 1 => altaCliente(clientes);             -- N2
            when 2 => modificarCliente(clientes);        -- N2
            when 3 => bajaCliente(clientes, pedidos);             -- N2
            when others => null;
         end case;
         exit when resp = 0;
      end loop;
   end abmCliente;

   procedure listados(pedidos: in p_pedidos.tipoArbol; clientes: in p_clientes.tipoArbol) is
      resp: Integer;
   begin
      loop
         resp := menuListados;                                      -- N2
         case resp is
            when 1 => listarPedidosDeDia(pedidos, clientes);          -- N2
            when 2 => listarPedidosDeCliente(pedidos, clientes);      -- N2
            when others => null;
         end case;

         exit when resp = 0;
      end loop;
   end listados;

   viandas: p_viandas.tipoLista;
   clientes: p_clientes.tipoArbol;
   pedidos: p_pedidos.tipoArbol;
   identificador: tipoClavePedido;
   resp: Integer;
begin

   identificador := 0;
   crearEstructuras(clientes, viandas, pedidos);        -- N1

   loop
      resp := menuPrincipal;                            -- N1

      case resp is
         when 1 => administrarViandas(viandas);         -- N1
         when 2 => abmCliente(clientes, pedidos);       -- N1
         when 3 => abmPedido(pedidos, identificador, clientes, viandas);        -- N1
         when 4 => listados(pedidos, clientes);         -- N1
         when others => null;
      end case;

     exit when resp = 0;
   end loop;


end Tpfinal;
