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

   --Colas
   --subtype tipoInfoCola is Integer;
   --package p_cola is new cola(tipoInfoCola);
   --use p_cola;

   ---------------------------------------------- N4 ---------------------------------------

   procedure agregarCantidadInfo(nombreVianda: in tipoClaveVianda; viandas: in out p_viandas.tipoLista) is -- Cambiar en pseudoCodigo
      cantidadAAgregar: Integer;
      info: tipoInfoVianda;
      nuevaInfo: tipoInfoVianda;
      cantidad: Integer;
      precio: Float;
   begin
      cantidadAAgregar := numeroEnt("Ingrese la cantidad a agregar");
      recuClave(viandas, nombreVianda, info);
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

      recuClave(viandas, nombreVianda, info);

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
         recuClave(platos, clave, info);
         Put(clave);Put("    ");Put(Integer'image(info.cantidad));Put("        ");Put(Float'Image(info.precioIndividual));New_Line;
         recuSig(platos, clave, clave);
      end loop;
   end mostrarPlatos;

   function obtenerEnvio(montoTotal: in Float) return Float is
   begin
      return montoTotal * 0.1;
   end obtenerEnvio;







   ---------------------------------------------- N3 -------------F-------------------
   function obtenerNombreVianda return Unbounded_String is
   begin
      return To_Unbounded_String(textoNoVacio("Ingrese el nombre de la vianda"));
   end obtenerNombreVianda;

   function existeVianda(viandas: in p_viandas.tipoLista; nombreVianda: in tipoClaveVianda) return Boolean is
   info: tipoInfoVianda;
   begin
      recuClave(viandas, nombreVianda, info);     -- ADT LO
      return True;
      exception when p_viandas.claveNoExiste => return False;
   end existeVianda;

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

   procedure cargarPrecio(viandas: in out p_viandas.tipoLista; nombreVianda: in tipoClaveVianda; precio: in Float) is
      info: tipoInfoVianda;
   begin
      recuClave(viandas, nombreVianda, info);       -- ADT LO

      if (info.precioIndividual /= -1.0) then
         Put_Line("El precio de esta vianda ya esta cargado");
      else
         begin
            info.precioIndividual := precio;
            modificar(viandas, nombreVianda, info);      -- ADT LO
         exception when p_viandas.listaLlena => Put_Line("Ocurrio un error inesperado, intente mas tarde");
         end;
      end if;
   end cargarPrecio;

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
            --modificar(viandas, nombreVianda, nuevaInfo);      -- U
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
            --modificar(viandas, nombreVianda, nuevaInfo);
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

   function obtenerDireccion(dniCliente: in tipoClaveCliente; clientes: in p_clientes.tipoArbol) return String is
      info: tipoInfoCliente;
   begin
      buscar(clientes, dniCliente, info);     -- ADT ABB
      return To_String(info.direccion);
   end obtenerDireccion;

   procedure mostrarPedidoDia(pedidos: in p_pedidos.tipoArbol; numeroDePedido: in tipoClavePedido; fecha: in tFecha; clientes: in p_clientes.tipoArbol) is
      info: tipoInfoPedido;
      fechaPedido: tFecha;
      direccion: String:="";
   begin
      buscar(pedidos, numeroDePedido, info);                           -- ADT ABB
      fechaPedido := info.fechaPedido;

      if esMismaFecha(fecha, fechaPedido) then                        -- N4
         direccion := obtenerDireccion(info.dniCliente, clientes);    -- N4
         --Put_Line(Integer'image(numeroDePedido) & "    " & fechatexto(info.fechaPedido) & "    " & To_String(Float'image(info.montoTotal)) & "            " & To_String(direccion)));
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
      buscar(pedidos, numeroDePedido, info);
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
            cargarPrecio(viandas, nombreVianda, precio);  -- N3 ----------
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
         vaciar(viandas);
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




   -- Consultar sobre la cola en este caso. la cola solo vive dentro del procedimiento??
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
         --p_cola.crear(colaPedidos);        -- ADT COLA
         p_pedidos.inOrder(pedidos, colaPedidos);    -- U

         while p_pedidos.ColaRecorridos.esVacia(colaPedidos) /= True loop       -- U
            p_pedidos.ColaRecorridos.frente(colaPedidos, numeroDePedido);       -- U
            mostrarPedidoDia(pedidos, numeroDePedido, fecha, clientes);
            p_pedidos.ColaRecorridos.desencolar(colaPedidos);
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
         --p_cola.crear(colaPedidos);                                          -- ADT COLA
         p_pedidos.inOrder(pedidos, colaPedidos);                                      -- ADT ABB

         while p_pedidos.ColaRecorridos.esVacia(colaPedidos) /= True loop     -- U
            p_pedidos.ColaRecorridos.frente(colaPedidos, numeroDePedido);     -- ADT COLA
            mostrarPedidoCliente(pedidos, numeroDePedido, dniCliente, direccion);      -- N3
            p_pedidos.ColaRecorridos.desencolar(colaPedidos);                                                   -- ADT COLA
         end loop;
      end if;
   exception when p_pedidos.errorEnCola => continua("Ocurrio un error, intente mas tarde");
   end listarPedidosDeCliente;


   ---------------------------------------------- N1 --------------------------------
   procedure crearEstructuras(clientes: out p_clientes.tipoArbol; viandas: out p_viandas.tipoLista; pedidos: out p_pedidos.tipoArbol) is
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
   begin
      null;
   end abmCliente;

   procedure abmPedido(pedidos: in out p_pedidos.tipoArbol; identificador: in out tipoClaveCliente; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
   begin
      null;
   end abmPedido;

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
   --platos: p_platos.tipoLista;
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
