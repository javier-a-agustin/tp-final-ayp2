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


   ---------------------------------------------- N3 --------------------------------
   function obtenerNombreVianda return Unbounded_String is
   begin
      return To_Unbounded_String("Javier");
   end obtenerNombreVianda;

   function existeVianda(viandas: in p_viandas.tipoLista; nombreVianda: in tipoClaveVianda) return Boolean is
   begin
      return True;
   end existeVianda;

   function obtenerCantidad return Integer is
   begin
      return 0;
   end obtenerCantidad;

   procedure cargarViandaN(viandas: in out p_viandas.tipoLista; nombreVianda: in tipoClaveVianda; cantidad: in Integer) is
   begin
      null;
   end cargarViandaN;

   function obtenerPrecio return float is
   begin
      return 1.1;
   end obtenerPrecio;

   procedure cargarPrecio(viandas: in out p_viandas.tipoLista; nombreVianda: in tipoClaveVianda; precio: in Float) is
   begin
      null;
   end cargarPrecio;

   function menuModificarViandas return Integer is
   begin
      return 0;
   end menuModificarViandas;

   procedure agregarCantidadVianda(viandas: in out p_viandas.tipoLista) is
   begin
      null;
   end agregarCantidadVianda;

   procedure quitarCantidadViandas(viandas: in out p_viandas.tipoLista) is
   begin
      null;
   end quitarCantidadViandas;

   procedure mostrarCabeceraListadosDia is
   begin
      null;
   end mostrarCabeceraListadosDia;

   procedure solicitarFecha(fecha: out tFecha) is
   begin
      null;
   end solicitarFecha;

   procedure mostrarPedidoDia(pedidos: in p_pedidos.tipoArbol; numeroDePedido: in tipoClavePedido; fecha: in tFecha; clientes: in p_clientes.tipoArbol) is
   begin
      null;
   end mostrarPedidoDia;

   procedure mostrarCabeceraListadoPedidosCliente is
   begin
      null;
   end mostrarCabeceraListadoPedidosCliente;

   function obtenerDireccion(dniCliente: in tipoClaveCliente; clientes: in p_clientes.tipoArbol) return Unbounded_String is
   begin
      return To_Unbounded_String("Javier");
   end obtenerDireccion;

   procedure mostrarPedidoCliente(pedidos: in p_pedidos.tipoArbol; numeroDePedido: in tipoClavePedido; dniCliente: in tipoClaveCliente; direccion: in Unbounded_String) is
   begin
      null;
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
      direccion: Unbounded_String;
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
   platos: p_platos.tipoLista;
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
