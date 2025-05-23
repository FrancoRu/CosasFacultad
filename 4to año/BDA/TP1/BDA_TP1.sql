PGDMP  (                     }            BDA_TP1    17.4    17.4 w    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    BDA_TP1    DATABASE     �   CREATE DATABASE "BDA_TP1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "BDA_TP1";
                     postgres    false            �           1247    16469    ESTADO_LIBRO    TYPE     b   CREATE TYPE public."ESTADO_LIBRO" AS ENUM (
    'Disponible',
    'Prestado',
    'Reparacion'
);
 !   DROP TYPE public."ESTADO_LIBRO";
       public               postgres    false            �           1247    16535    ESTADO_MULTA    TYPE     M   CREATE TYPE public."ESTADO_MULTA" AS ENUM (
    'Pendiente',
    'Pagada'
);
 !   DROP TYPE public."ESTADO_MULTA";
       public               postgres    false            �           1247    16508    ESTADO_PRESTAMO    TYPE     `   CREATE TYPE public."ESTADO_PRESTAMO" AS ENUM (
    'Activo',
    'Devuelto',
    'Retrasado'
);
 $   DROP TYPE public."ESTADO_PRESTAMO";
       public               postgres    false            �           1247    16476    ESTADO_RESERVA    TYPE     _   CREATE TYPE public."ESTADO_RESERVA" AS ENUM (
    'Activa',
    'Cancelada',
    'Cumplida'
);
 #   DROP TYPE public."ESTADO_RESERVA";
       public               postgres    false            �           1247    16432    ESTADO_USUARIO    TYPE     \   CREATE TYPE public."ESTADO_USUARIO" AS ENUM (
    'Activo',
    'Suspendido',
    'Baja'
);
 #   DROP TYPE public."ESTADO_USUARIO";
       public               postgres    false            �           1247    16452    TIPO_USUARIO    TYPE     r   CREATE TYPE public."TIPO_USUARIO" AS ENUM (
    'Estudiante',
    'Docente',
    'Administrativo',
    'Autor'
);
 !   DROP TYPE public."TIPO_USUARIO";
       public               postgres    false                       1255    16777 7   fn_excede_limite_libros(public."TIPO_USUARIO", integer)    FUNCTION     ~  CREATE FUNCTION public.fn_excede_limite_libros(tipo_usuario public."TIPO_USUARIO", libros_prestados integer) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN
    RETURN ((tipo_usuario = 'Estudiante' AND libros_prestados >= 3) OR
       (tipo_usuario = 'Docente' AND libros_prestados >= 5) OR
       (tipo_usuario = 'Administrativo' AND libros_prestados >= 7));
END;$$;
 l   DROP FUNCTION public.fn_excede_limite_libros(tipo_usuario public."TIPO_USUARIO", libros_prestados integer);
       public               postgres    false    904            �           0    0 ^   FUNCTION fn_excede_limite_libros(tipo_usuario public."TIPO_USUARIO", libros_prestados integer)    COMMENT     B  COMMENT ON FUNCTION public.fn_excede_limite_libros(tipo_usuario public."TIPO_USUARIO", libros_prestados integer) IS 'Nombre: fn_excede_limite_libros
Descripción: Evalúa si un usuario ha alcanzado o superado el límite de libros permitidos según su tipo.
Parámetros:

tipo_usuario: tipo de usuario (Ej: ''Estudiante'', ''Docente'', ''Administrativo'')

libros_prestados: cantidad actual de libros prestados al usuario
Retorna:

* 1 (bit) si excede el límite permitido

* 0 (bit) si no excede el límite
Uso:
SELECT fn_excede_limite_libros(''Estudiante'', 3); -- retorna 1';
          public               postgres    false    268                       1255    16746    fn_generar_multa(integer)    FUNCTION     l  CREATE FUNCTION public.fn_generar_multa(id_prestamo integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE
	fecha_actual date;
	fecha_devolucion_estimada date;
	diferencia_dia integer;
	monto integer;
BEGIN
	fecha_actual:= CURRENT_DATE;
	
	SELECT "Fecha_Devolucion_Estimada"
	INTO fecha_devolucion_estimada
	FROM public."Prestamo"
	WHERE "Id" = id_prestamo;
	
	diferencia_dia := fecha_actual - fecha_devolucion_estimada;
	
	IF diferencia_dia > 0 THEN
		monto := diferencia_dia * 100; -- Monto por día de atraso
		INSERT INTO public."Multa" ("Id_Prestamo", "Monto")
		VALUES (id_prestamo, monto);
	END IF;
END;
$$;
 <   DROP FUNCTION public.fn_generar_multa(id_prestamo integer);
       public               postgres    false            �            1255    16582    fn_insert_direccion_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_direccion_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO public."Direccion_Historial" 
  VALUES (OLD.*);
  RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.fn_insert_direccion_historial();
       public               postgres    false            �           0    0 (   FUNCTION fn_insert_direccion_historial()    COMMENT     �  COMMENT ON FUNCTION public.fn_insert_direccion_historial() IS '-- Este bloque de código es parte de un trigger que se ejecuta cuando se realiza un cambio en una fila de la tabla "Direccion".
-- La instrucción INSERT INTO "Direccion_Historial" captura el estado anterior de la fila antes de ser modificada 
-- (utilizando OLD.*) y lo guarda en la tabla de historial "Direccion_Historial", 
-- permitiendo así llevar un registro histórico de los cambios en los datos de la tabla "Direccion".
-- Luego, se retorna la nueva fila (NEW), que es el registro actualizado que reemplaza al anterior en la tabla "Direccion".
-- Esto asegura que se mantenga la integridad de la información mientras se guarda un histórico de los cambios.
';
          public               postgres    false    242            �            1255    16641    fn_insert_libro_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_libro_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO public."Libro_Historial" 
  VALUES (OLD.*);
  RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.fn_insert_libro_historial();
       public               postgres    false            �           0    0 $   FUNCTION fn_insert_libro_historial()    COMMENT     A  COMMENT ON FUNCTION public.fn_insert_libro_historial() IS '-- Este bloque de código es parte de un trigger que se activa cuando se realiza una modificación en la tabla "Libro".
-- La instrucción INSERT INTO "Libro_Historial" captura el estado anterior de la fila antes de la actualización
-- (utilizando OLD.*) y lo guarda en la tabla "Libro_Historial". Esto crea un registro histórico de los cambios realizados
-- en los datos de la tabla "Libro". Al almacenar los datos anteriores en el historial, se permite el seguimiento y la
-- auditoría de cualquier modificación que ocurra en la tabla "Libro".
-- Finalmente, se retorna la nueva fila (NEW), que es el registro actualizado que reemplaza al anterior en la tabla "Libro".
-- Este retorno es necesario para completar la actualización de la fila en la tabla principal.
';
          public               postgres    false    245            
           1255    16758    fn_insert_multa()    FUNCTION     {  CREATE FUNCTION public.fn_insert_multa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
    monto_acumulado double precision;
    tipo_usuario "TIPO_USUARIO";
    id_usuario integer;
    nombre_usuario VARCHAR(512);
BEGIN
    -- Obtener ID de usuario y nombre completo
    SELECT 
        u."Id", 
        CONCAT(u."Nombre", ' ', u."Apellido")
    INTO id_usuario, nombre_usuario
    FROM public."Usuario" u
    INNER JOIN public."Prestamo" pr
    ON pr."Id_Usuario" = u."Id"
    WHERE pr."Id" = NEW."Id_Prestamo"
    LIMIT 1;

    -- Sumar los montos acumulados de las multas
    SELECT SUM(m."Monto"), u."Tipo"
    INTO monto_acumulado,
         tipo_usuario
    FROM public."Multa" m
    INNER JOIN public."Prestamo" pr
    ON pr."Id" = m."Id_Prestamo"
    INNER JOIN public."Usuario" u
    ON u."Id" = pr."Id_Usuario"
    WHERE pr."Id_Usuario" = id_usuario
	AND m."Estado" = 'Pendiente';

    -- Verificar si el monto acumulado supera el límite
    IF fn_supera_monto_limite(tipo_usuario, monto_acumulado) THEN
        -- Suspender al usuario
        UPDATE public."Usuario"
        SET "Estado" = 'Suspendido'
        WHERE "Id" = id_usuario;
        
        -- Lanzar mensaje
        RAISE NOTICE 'El monto acumulado supera el límite permitido para el usuario: %. El usuario % fue suspendido',
                         tipo_usuario, nombre_usuario;
    END IF;

    RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.fn_insert_multa();
       public               postgres    false            �           0    0    FUNCTION fn_insert_multa()    COMMENT       COMMENT ON FUNCTION public.fn_insert_multa() IS 'Esta función se ejecuta como parte de un trigger que se activa al insertar una nueva multa. Su propósito es verificar si el usuario asociado al préstamo ya ha acumulado un monto de multas que excede el límite permitido según su tipo de usuario. Si se supera ese límite, el usuario es automáticamente suspendido y se muestra un mensaje informativo. La lógica se basa en una función auxiliar fn_supera_monto_limite que evalúa si el monto acumulado excede el umbral definido.';
          public               postgres    false    266            �            1255    16659    fn_insert_multa_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_multa_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO public."Multa_Historial"
	VALUES (OLD.*);
	RETURN NEW;
END;$$;
 2   DROP FUNCTION public.fn_insert_multa_historial();
       public               postgres    false            �           0    0 $   FUNCTION fn_insert_multa_historial()    COMMENT     <  COMMENT ON FUNCTION public.fn_insert_multa_historial() IS '-- Este bloque de código es parte de un trigger que se activa cuando se realiza una modificación en la tabla "Multa".
-- La instrucción INSERT INTO "Multa_Historial" guarda el estado anterior de la fila (OLD.*) en la tabla "Multa_Historial".
-- Esto permite crear un registro histórico de los cambios realizados en la tabla "Multa". 
-- Al almacenar los datos previos, se puede realizar un seguimiento de todas las modificaciones en la tabla "Multa" para fines de auditoría o restauración de datos.
-- Después, se retorna la nueva fila (NEW), que es la versión actualizada del registro, permitiendo que la modificación se realice en la tabla principal "Multa".
-- Este retorno es necesario para completar la actualización del registro en la tabla "Multa".
';
          public               postgres    false    246            �            1255    16644    fn_insert_persona_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_persona_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO public."Persona_Historial"
  VALUES (OLD.*);
  RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.fn_insert_persona_historial();
       public               postgres    false            �           0    0 &   FUNCTION fn_insert_persona_historial()    COMMENT     �  COMMENT ON FUNCTION public.fn_insert_persona_historial() IS '-- Este bloque de código es parte de un trigger que se activa cuando se realiza una modificación en la tabla "Persona".
-- La instrucción INSERT INTO "Persona_Historial" guarda el estado anterior de la fila (OLD.*) en la tabla "Persona_Historial".
-- Esto permite crear un registro histórico de los cambios realizados en la tabla "Persona", lo cual es útil para auditoría o para mantener un historial de las modificaciones.
-- Al almacenar los datos previos, se puede rastrear el historial de cambios en cada registro de la tabla "Persona".
-- Después de guardar los datos en el historial, se retorna la nueva fila (NEW), que es la versión actualizada del registro, permitiendo que la modificación se realice en la tabla principal "Persona".
-- El retorno de la nueva fila es necesario para que la actualización del registro en la tabla "Persona" se lleve a cabo correctamente.
';
          public               postgres    false    243                       1255    16706    fn_insert_prestamo()    FUNCTION     �  CREATE FUNCTION public.fn_insert_prestamo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
	libros_prestados INTEGER;
	tipo_usuario "TIPO_USUARIO";
	libro_disponible "ESTADO_LIBRO";
	nombre_usuario CHARACTER VARYING(512);
BEGIN
	SELECT u."Libros_Prestados", u."Tipo", CONCAT(p."Nombre", ' ', p."Apellido") 
	INTO libros_prestados, tipo_usuario, nombre_usuario  
	FROM public."Usuario" u
	INNER JOIN public."Persona" p
		ON p."Id" = u."Id_Persona"
	WHERE u."Id" = NEW."Id_Usuario"
	AND u."Estado" = 'Activo';

	IF tipo_usuario IS NULL THEN
    	RAISE EXCEPTION 'El usuario no está activo';
	ELSIF fn_excede_limite_libros(tipo_usuario, libros_prestados) THEN
    	RAISE EXCEPTION 'Límite de libros prestados alcanzado para el usuario: %', nombre_usuario;
	END IF;


	SELECT "Estado"
	INTO libro_disponible
	FROM public."Libro"
	WHERE "Id" = NEW."Id_Libro";

	IF libro_disponible <> 'Disponible' THEN
		RAISE EXCEPTION 'Libro No disponible';
	END IF;

	NEW."Fecha_Devolucion_Estimada":= fn_tiempo_devolucion_segun_tipo_usuario(tipo_usuario);
	
	UPDATE public."Libro"
	SET "Estado" = 'Prestado'
	WHERE "Id" = NEW."Id_Libro";
	
  	RETURN NEW;
END;$$;
 +   DROP FUNCTION public.fn_insert_prestamo();
       public               postgres    false            �           0    0    FUNCTION fn_insert_prestamo()    COMMENT     �  COMMENT ON FUNCTION public.fn_insert_prestamo() IS 'Función que valida si un usuario ha alcanzado el límite de libros prestados antes de permitir un nuevo préstamo.

Parámetros:

No recibe parámetros directamente, utiliza :NEW."Id_Usuario" para obtener el identificador del usuario que está realizando el préstamo.

Lógica:

La función obtiene el número actual de libros prestados (Libros_Prestados) y el tipo de usuario (Tipo) de la tabla "Usuario" basándose en el Id_Usuario.

Luego, dependiendo del tipo de usuario (Estudiante, Docente, Administrativo), verifica si el número de libros prestados supera el límite permitido:

Estudiante: máximo 3 libros prestados.

Docente: máximo 5 libros prestados.

Administrativo: máximo 7 libros prestados.

Si el número de libros prestados alcanza el límite correspondiente, la función lanza una excepción, evitando que el préstamo sea registrado.

Si no se alcanza el límite, la función permite que el préstamo se registre sin ningún problema.

Excepciones:

Si el usuario ha alcanzado su límite de libros prestados, se lanza una excepción con el mensaje ''Límite de libros prestados alcanzado para el usuario: Tipo'', indicando el tipo de usuario.';
          public               postgres    false    267            �            1255    16664    fn_insert_prestamo_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_prestamo_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO public."Prestamo_Historial"
	VALUES (OLD.*);
	RETURN NEW;
END;$$;
 5   DROP FUNCTION public.fn_insert_prestamo_historial();
       public               postgres    false            �           0    0 '   FUNCTION fn_insert_prestamo_historial()    COMMENT     �  COMMENT ON FUNCTION public.fn_insert_prestamo_historial() IS '-- Este bloque de código es parte de un trigger que se activa cuando se realiza una modificación en la tabla "Prestamo".
-- La instrucción INSERT INTO "Prestamo_Historial" guarda el estado anterior de la fila (OLD.*) en la tabla "Prestamo_Historial".
-- Esto permite crear un registro histórico de los cambios realizados en la tabla "Prestamo", lo cual es útil para auditoría o para mantener un historial de las modificaciones.
-- Al almacenar los datos previos, se puede rastrear el historial de cambios en cada registro de la tabla "Prestamo".
-- Después de guardar los datos en el historial, se retorna la nueva fila (NEW), que es la versión actualizada del registro, permitiendo que la modificación se realice en la tabla principal "Prestamo".
-- El retorno de la nueva fila es necesario para que la actualización del registro en la tabla "Prestamo" se lleve a cabo correctamente.
';
          public               postgres    false    247                       1255    16841    fn_insert_reserva()    FUNCTION       CREATE FUNCTION public.fn_insert_reserva() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
	estado_libro "ESTADO_LIBRO";
	titulo VARCHAR(100);
	nombre_usuario VARCHAR(512);
	estado_usuario "ESTADO_USUARIO";
	tipo_usuario "TIPO_USUARIO";
	libros_prestados INTEGER;
BEGIN
	SELECT "Estado", "Titulo"
	INTO estado_libro, titulo
	FROM public."Libro"
	WHERE "Id" = NEW."Id_Libro";

	SELECT 
	CONCAT(p."Nombre", ' ', p."Apellido"),
	u."Estado",
	u."Libros_Prestados",
	u."Tipo"
	INTO nombre_usuario, estado_usuario, libros_prestados, tipo_usuario
	FROM public."Usuario" u
	INNER JOIN public."Persona" p
		ON p."Id" = u."Id_Persona"
	WHERE u."Id" = NEW."Id_Usuario";

	IF estado_usuario = 'Suspendido' THEN
		RAISE NOTICE 'Usuario: % suspendido. Regularice su situacion', nombre_usuario;
	ELSEIF estado_libro = 'Disponible' AND NOT fn_excede_limite_libros(tipo_usuario,libros_prestados) THEN

		-- Insertamos el prestamo
		INSERT INTO public."Prestamo" 
		("Id_Usuario", "Id_Libro") 
		VALUES 
		(NEW."Id_Usuario", NEW."Id_Libro");

		-- Actualizamos la reserva
		UPDATE public."Reserva"
		SET "Estado" = 'Cumplida'
		WHERE "Id" = NEW."Id";
		
		--Mensaje de prestamo concedido
		RAISE NOTICE 'Libro: % disponible. Asignando Prestamo al usuario: %', 
		titulo, nombre_usuario;
	END IF;
	
	RETURN NEW;
END;$$;
 *   DROP FUNCTION public.fn_insert_reserva();
       public               postgres    false            �           0    0    FUNCTION fn_insert_reserva()    COMMENT     (  COMMENT ON FUNCTION public.fn_insert_reserva() IS '-- Verifica si el usuario está suspendido o si el libro está disponible para prestar. 
-- Si el libro está disponible y el usuario no excede el límite de libros prestados, se concede el préstamo y se actualiza la reserva a ''Cumplida''.
';
          public               postgres    false    274            �            1255    16665    fn_insert_reserva_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_reserva_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO public."Reserva_Historial"
	VALUES (OLD.*);
	RETURN NEW;
END;$$;
 4   DROP FUNCTION public.fn_insert_reserva_historial();
       public               postgres    false            �           0    0 &   FUNCTION fn_insert_reserva_historial()    COMMENT     �  COMMENT ON FUNCTION public.fn_insert_reserva_historial() IS '-- Este bloque de código es parte de un trigger que se activa cuando se realiza una modificación en la tabla "Reserva".
-- La instrucción INSERT INTO "Reserva_Historial" guarda el estado anterior de la fila (OLD.*) en la tabla "Reserva_Historial".
-- Esto permite crear un registro histórico de los cambios realizados en la tabla "Reserva", lo cual es útil para auditoría o para mantener un historial de las modificaciones.
-- Al almacenar los datos previos, se puede rastrear el historial de cambios en cada registro de la tabla "Reserva".
-- Después de guardar los datos en el historial, se retorna la nueva fila (NEW), que es la versión actualizada del registro, permitiendo que la modificación se realice en la tabla principal "Reserva".
-- El retorno de la nueva fila es necesario para que la actualización del registro en la tabla "Reserva" se lleve a cabo correctamente.
';
          public               postgres    false    248            �            1255    16666    fn_insert_usuario_historial()    FUNCTION     �   CREATE FUNCTION public.fn_insert_usuario_historial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	INSERT INTO public."Usuario_Historial"
	VALUES (OLD.*);
	RETURN NEW;
END;$$;
 4   DROP FUNCTION public.fn_insert_usuario_historial();
       public               postgres    false            �           0    0 &   FUNCTION fn_insert_usuario_historial()    COMMENT     �  COMMENT ON FUNCTION public.fn_insert_usuario_historial() IS '-- Este bloque de código es parte de un trigger que se activa cuando se realiza una modificación en la tabla "Usuario".
-- La instrucción INSERT INTO "Usuario_Historial" guarda el estado anterior de la fila (OLD.*) en la tabla "Usuario_Historial".
-- Esto permite crear un registro histórico de los cambios realizados en la tabla "Usuario", lo cual es útil para auditoría o para mantener un historial de las modificaciones.
-- Al almacenar los datos previos, se puede rastrear el historial de cambios en cada registro de la tabla "Usuario".
-- Después de guardar los datos en el historial, se retorna la nueva fila (NEW), que es la versión actualizada del registro, permitiendo que la modificación se realice en la tabla principal "Usuario".
-- El retorno de la nueva fila es necesario para que la actualización del registro en la tabla "Usuario" se lleve a cabo correctamente.
';
          public               postgres    false    249                       1255    16752    fn_monto_por_dia()    FUNCTION     �   CREATE FUNCTION public.fn_monto_por_dia() RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN
	return 100.00;
END;$$;
 )   DROP FUNCTION public.fn_monto_por_dia();
       public               postgres    false            �           0    0    FUNCTION fn_monto_por_dia()    COMMENT     Z   COMMENT ON FUNCTION public.fn_monto_por_dia() IS 'Recupera el valor por dia de la multa';
          public               postgres    false    264                       1255    16751    fn_reasignar_libro(integer)    FUNCTION     �  CREATE FUNCTION public.fn_reasignar_libro(id_libro integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE
	id_reserva INTEGER;
	siguiente_usuario INTEGER;
	tiempo_prestamo date;
	tipo_usuario "TIPO_USUARIO";
	titulo VARCHAR(100);
BEGIN
	SELECT *
	INTO id_reserva, siguiente_usuario
	FROM (
		SELECT 
		r."Id", 
		u."Id"
		FROM public."Reserva" r
		INNER JOIN public."Usuario" u
		ON r."Id_Usuario" = u."Id"
		WHERE r."Id_Libro" = id_libro
			AND r."Estado" = 'Activa'
			AND u."Estado" = 'Activo'
			AND fn_excede_limite_libros(u."Tipo", u."Libros_Prestados")
		ORDER BY r."Id" ASC
		LIMIT 1
	) AS sub;


	IF siguiente_usuario IS NOT NULL THEN
		-- Insertar Nuevo Prestamo
		INSERT INTO public."Prestamo"(
			"Id_Usuario", "Id_Libro")
		VALUES (siguiente_usuario, id_libro);
		
		-- Actualizar Reserva
		UPDATE public."Reserva"
		SET "Estado" = 'Cumplida'
		WHERE "Id" = id_reserva;
		
		RAISE NOTICE 'Libro asignado a usuario con ID: %, por la reserva ID: %', siguiente_usuario, id_reserva;
	ELSE
		-- Actualizar Libro
		UPDATE public."Libro"
		SET "Estado" = 'Disponible'
		WHERE "Id" = id_libro;
		
		SELECT "Titulo" 
		INTO titulo
		FROM public."Libro" 
		WHERE "Id" = id_libro 
		LIMIT 1;
		
		RAISE NOTICE 'Libro % disponible.',titulo;
	END IF;
END;$$;
 ;   DROP FUNCTION public.fn_reasignar_libro(id_libro integer);
       public               postgres    false            �           0    0 -   FUNCTION fn_reasignar_libro(id_libro integer)    COMMENT     �  COMMENT ON FUNCTION public.fn_reasignar_libro(id_libro integer) IS 'Esta función gestiona la reserva y préstamo de un libro. Realiza las siguientes acciones:

1. Selecciona la primera reserva activa para un libro específico que esté asociada a un usuario activo y que no haya excedido el límite de libros prestados.
2. Si se encuentra un usuario para la reserva:
   - Inserta un nuevo préstamo asignando el libro al usuario.
   - Actualiza el estado de la reserva a ''Cumplida''.
3. Si no se encuentra un usuario para la reserva:
   - Actualiza el estado del libro a ''Disponible''.

Esta función asegura que las reservas y préstamos se gestionen adecuadamente, respetando las condiciones de usuario activo y límites de libros prestados.';
          public               postgres    false    272            �            1255    16646    fn_set_fecha_modificacion()    FUNCTION     �   CREATE FUNCTION public.fn_set_fecha_modificacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW."Fecha_Modificacion" := now();
  RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.fn_set_fecha_modificacion();
       public               postgres    false            �           0    0 $   FUNCTION fn_set_fecha_modificacion()    COMMENT     7  COMMENT ON FUNCTION public.fn_set_fecha_modificacion() IS '-- Este bloque de código es parte de un trigger que se activa antes de que se realice una actualización en la tabla.
-- La instrucción NEW."Fecha_Modificacion" := now() asigna la fecha y hora actuales al campo "Fecha_Modificacion" de la fila que se está actualizando.
-- Esto asegura que cada vez que se modifique un registro en la tabla, se registre la fecha y hora exacta de la modificación.
-- El valor de "NEW" representa la fila modificada, y la actualización de la columna "Fecha_Modificacion" se refleja en el registro que está siendo procesado.
-- Finalmente, el retorno de "NEW" es necesario para completar la actualización en la tabla, permitiendo que la modificación del registro se guarde correctamente con la nueva fecha de modificación.
';
          public               postgres    false    244                       1255    16791 ?   fn_supera_monto_limite(public."TIPO_USUARIO", double precision)    FUNCTION     F  CREATE FUNCTION public.fn_supera_monto_limite(tipo_usuario public."TIPO_USUARIO", monto_acumulado double precision) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN
    RETURN 
        (tipo_usuario = 'Estudiante' AND monto_acumulado > fn_monto_por_dia() * fn_tiempo_segun_tipo_usuario('Estudiante') * 3)
        OR (tipo_usuario = 'Docente' AND monto_acumulado > fn_monto_por_dia() * fn_tiempo_segun_tipo_usuario('Docente') * 3)
        OR (tipo_usuario = 'Administrativo' AND monto_acumulado > fn_monto_por_dia() * fn_tiempo_segun_tipo_usuario('Administrativo') * 3);

END;$$;
 s   DROP FUNCTION public.fn_supera_monto_limite(tipo_usuario public."TIPO_USUARIO", monto_acumulado double precision);
       public               postgres    false    904            �           0    0 e   FUNCTION fn_supera_monto_limite(tipo_usuario public."TIPO_USUARIO", monto_acumulado double precision)    COMMENT     C  COMMENT ON FUNCTION public.fn_supera_monto_limite(tipo_usuario public."TIPO_USUARIO", monto_acumulado double precision) IS '-- Función que verifica si el monto acumulado excede el límite permitido para un tipo de usuario específico.
-- La lógica compara el monto acumulado con el cálculo basado en el tipo de usuario:
--   - Para ''Estudiante'', se compara con 3 veces el monto por día multiplicado por el tiempo permitido para ''Estudiante''.
--   - Para ''Docente'', se compara con 3 veces el monto por día multiplicado por el tiempo permitido para ''Docente''.
--   - Para ''Administrativo'', se compara con 3 veces el monto por día multiplicado por el tiempo permitido para ''Administrativo''.
-- Si el monto acumulado excede el límite para cualquier tipo de usuario, la función devuelve TRUE; de lo contrario, FALSE.
';
          public               postgres    false    269                       1255    16748 >   fn_tiempo_devolucion_segun_tipo_usuario(public."TIPO_USUARIO")    FUNCTION     �  CREATE FUNCTION public.fn_tiempo_devolucion_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO") RETURNS date
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN
   	IF tipo_usuario = 'Estudiante' THEN
        RETURN CURRENT_DATE + INTERVAL '1 day' * fn_tiempo_segun_tipo_usuario('Estudiante');
    ELSIF tipo_usuario = 'Docente' THEN
        RETURN CURRENT_DATE + INTERVAL '1 day' * fn_tiempo_segun_tipo_usuario('Docente');
    ELSIF tipo_usuario = 'Administrativo' THEN
        RETURN CURRENT_DATE + INTERVAL '1 day' * fn_tiempo_segun_tipo_usuario('Administrativo');
    END IF;

    RAISE EXCEPTION 'Tipo de usuario: % invalido', tipo_usuario;
END;
$$;
 b   DROP FUNCTION public.fn_tiempo_devolucion_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO");
       public               postgres    false    904            �           0    0 T   FUNCTION fn_tiempo_devolucion_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO")    COMMENT       COMMENT ON FUNCTION public.fn_tiempo_devolucion_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO") IS 'Esta función recibe un tipo de usuario y devuelve una fecha de devolución estimada según el tipo de usuario:
- Para ''Estudiante'' devuelve la fecha actual más 30 días.
- Para ''Docente'' devuelve la fecha actual más 60 días.
- Para ''Administrativo'' devuelve la fecha actual más 10 días.
Si el tipo de usuario no es válido, lanza una excepción con un mensaje de error indicando el tipo de usuario inválido.';
          public               postgres    false    262            	           1255    16754 3   fn_tiempo_segun_tipo_usuario(public."TIPO_USUARIO")    FUNCTION     �  CREATE FUNCTION public.fn_tiempo_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO") RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN
    IF tipo_usuario = 'Estudiante' THEN
        RETURN 30;
    ELSIF tipo_usuario = 'Docente' THEN
        RETURN 60;
    ELSIF tipo_usuario = 'Administrativo' THEN
        RETURN 10;
    ELSE
        RAISE EXCEPTION 'Tipo incorrecto: %', tipo_usuario;
    END IF;
END;
$$;
 W   DROP FUNCTION public.fn_tiempo_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO");
       public               postgres    false    904            �           0    0 I   FUNCTION fn_tiempo_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO")    COMMENT     �  COMMENT ON FUNCTION public.fn_tiempo_segun_tipo_usuario(tipo_usuario public."TIPO_USUARIO") IS '-- Función que devuelve el tiempo de préstamo basado en el tipo de usuario.
-- Recibe como parámetro el tipo de usuario y devuelve:
--   30 días para un ''Estudiante''
--   60 días para un ''Docente''
--   10 días para un ''Administrativo''
-- Si el tipo de usuario no es uno de los tres mencionados, se lanza una excepción.';
          public               postgres    false    265                       1255    16788    fn_update_multa()    FUNCTION     �  CREATE FUNCTION public.fn_update_multa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
	tipo_usuario "TIPO_USUARIO";
	monto_acumulado double precision;
	id_usuario integer;
	estado_usuario "ESTADO_USUARIO";
	nombre_usuario VARCHAR(512);
BEGIN
	SELECT u."Tipo", 
	u."Id", 
	u."Estado",
	CONCAT(p."Nombre", ' ', p."Apellido"),
	SUM(m."Monto")
	INTO tipo_usuario, id_usuario, 
	estado_usuario ,nombre_usuario, monto_acumulado
	FROM public."Multa" m
	INNER JOIN public."Prestamo" pr
		ON pr."Id" = m."Id_Prestamo"
	INNER JOIN public."Usuario" u
		ON u."Id" = pr."Id_Usuario"
	INNER JOIN public."Persona" p
		ON p."Id" = u."Id_Persona"
	WHERE m."Id" = NEW."Id"
	GROUP BY u."Tipo", u."Id", u."Estado", p."Nombre", p."Apellido";

	monto_acumulado:= monto_acumulado-NEW."Monto";

	IF NOT fn_supera_monto_limite(tipo_usuario, monto_acumulado) 
		AND estado_usuario = 'Suspendido' THEN
		
		-- Activar al usuario
        UPDATE public."Usuario"
        SET "Estado" = 'Activo'
        WHERE "Id" = id_usuario;
        
        -- Lanzar mensaje
        RAISE NOTICE 'El usuario % fue Activado nuevamente', nombre_usuario;
    END IF;
	RETURN NEW;
END;$$;
 (   DROP FUNCTION public.fn_update_multa();
       public               postgres    false            �           0    0    FUNCTION fn_update_multa()    COMMENT     f  COMMENT ON FUNCTION public.fn_update_multa() IS '-- Este bloque de código verifica si el monto acumulado de multas de un usuario no supera el límite permitido y si el usuario está suspendido.
-- Si ambas condiciones se cumplen, el estado del usuario se actualiza a "Activo" y se lanza un mensaje notificando que el usuario ha sido activado nuevamente.
';
          public               postgres    false    273                       1255    16720    fn_update_prestamo()    FUNCTION        CREATE FUNCTION public.fn_update_prestamo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
    IF OLD."Estado" = 'Devuelto' THEN
        RAISE EXCEPTION 'Los prestamos con estado devuelto no se pueden actualizar';
    ELSIF OLD."Estado" <> NEW."Estado"
         AND NEW."Estado" <> 'Retrasado'
         AND NEW."Estado" = 'Devuelto' THEN
        
        -- Llamada a la función procesar multa
        CALL sp_generar_multa(NEW."Id");
        
        -- Actualización del estado del libro
        UPDATE public."Libro"
        SET "Estado" = 'Disponible'
        WHERE "Id" = NEW."Id_Libro";

		PERFORM fn_reasignar_libro(NEW."Id_Libro");
		
		-- Actualizar Fecha de devolucion real
		NEW."Fecha_Devolucion_Real":= now();
    END IF;

    RETURN NEW;
END;
$$;
 +   DROP FUNCTION public.fn_update_prestamo();
       public               postgres    false            �           0    0    FUNCTION fn_update_prestamo()    COMMENT     �  COMMENT ON FUNCTION public.fn_update_prestamo() IS 'Esta función procesa una multa por cada préstamo que se ha retrasado.
Calcula el monto de la multa basado en los días de retraso y lo inserta  en la tabla "Multa" asociando el préstamo con su respectiva penalización. 

El monto por día de atraso es de 100 unidades de la moneda.

 Parámetros:
* id_prestamo: El identificador del préstamo que  será procesado para la multa.
';
          public               postgres    false    263                       1255    16824    sp_generar_multa(integer) 	   PROCEDURE     c  CREATE PROCEDURE public.sp_generar_multa(IN id_prestamo integer)
    LANGUAGE plpgsql
    AS $$DECLARE
	fecha_actual date;
	fecha_devolucion_estimada date;
	diferencia_dia integer;
	monto integer;
BEGIN
	fecha_actual:= CURRENT_DATE;
	
	SELECT "Fecha_Devolucion_Estimada"
	INTO fecha_devolucion_estimada
	FROM public."Prestamo"
	WHERE "Id" = id_prestamo;
	
	diferencia_dia := fecha_actual - fecha_devolucion_estimada;
	
	IF diferencia_dia > 0 THEN
		monto := diferencia_dia * 100; -- Monto por día de atraso
		INSERT INTO public."Multa" ("Id_Prestamo", "Monto")
		VALUES (id_prestamo, monto);
	END IF;
END;
$$;
 @   DROP PROCEDURE public.sp_generar_multa(IN id_prestamo integer);
       public               postgres    false                       1255    16825    sp_renovar_prestamo(integer) 	   PROCEDURE     #  CREATE PROCEDURE public.sp_renovar_prestamo(IN id_prestamo integer)
    LANGUAGE plpgsql
    AS $$DECLARE
    id_libro integer;
    titulo VARCHAR(100);
    fecha_devolucion_estimada date;
    nueva_fecha_devolucion_estimada date;
BEGIN
    -- Obtener información del préstamo
    SELECT "Id_Libro", l."Titulo", p."Fecha_Devolucion_Estimada"
    INTO id_libro, titulo, fecha_devolucion_estimada
    FROM public."Prestamo" p
    INNER JOIN public."Libro" l
        ON l."Id" = p."Id_Libro"
    WHERE p."Id" = id_prestamo; 

    -- Verificar si hay reservas activas
    IF EXISTS (
        SELECT 1
        FROM public."Reserva"
        WHERE "Id_Libro" = id_libro 
        AND "Estado" = 'Activa'
    ) THEN
        RAISE EXCEPTION 'Libro "%", con reserva activa, no se puede extender el plazo del préstamo.', titulo; 
    END IF;

    -- Calcular la nueva fecha de devolución estimada
    nueva_fecha_devolucion_estimada := fecha_devolucion_estimada + INTERVAL '7 days';

    -- Actualizar la fecha de devolución estimada
    UPDATE public."Prestamo"
    SET "Fecha_Devolucion_Estimada" = nueva_fecha_devolucion_estimada
    WHERE "Id" = id_prestamo;

    -- Mostrar el mensaje de éxito
    RAISE NOTICE 'Préstamo extendido, nueva fecha de devolución estimada: %', nueva_fecha_devolucion_estimada;
END;
$$;
 C   DROP PROCEDURE public.sp_renovar_prestamo(IN id_prestamo integer);
       public               postgres    false            �            1259    16412 	   Direccion    TABLE     J  CREATE TABLE public."Direccion" (
    "Id" integer NOT NULL,
    "Calle" character varying(255) NOT NULL,
    "Numero" integer,
    "Ciudad" character varying(255),
    "CP" integer,
    "Id_Persona" integer,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modifiicacion" timestamp without time zone
);
    DROP TABLE public."Direccion";
       public         heap r       postgres    false            �            1259    16552    Direccion_Historial    TABLE     3  CREATE TABLE public."Direccion_Historial" (
    "Id" integer,
    "Calle" character varying(255),
    "Numero" integer,
    "Ciudad" character varying(255),
    "CP" integer,
    "Id_Persona" integer,
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone
);
 )   DROP TABLE public."Direccion_Historial";
       public         heap r       postgres    false            �            1259    16411    Direcciones_Id_seq    SEQUENCE     �   ALTER TABLE public."Direccion" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Direcciones_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    222            �            1259    16396    Libro    TABLE     �  CREATE TABLE public."Libro" (
    "Id" integer NOT NULL,
    "ISBN" character varying(17) NOT NULL,
    "Titulo" character varying(100) NOT NULL,
    "Editorial" character varying(100) NOT NULL,
    "Anio_publicacion" integer NOT NULL,
    "Estado" public."ESTADO_LIBRO" DEFAULT 'Disponible'::public."ESTADO_LIBRO" NOT NULL,
    "Autor" character varying NOT NULL,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modificacion" timestamp without time zone
);
    DROP TABLE public."Libro";
       public         heap r       postgres    false    928    928            �            1259    16557    Libro_Historial    TABLE     v  CREATE TABLE public."Libro_Historial" (
    "Id" integer,
    "ISBN" character varying(17),
    "Titulo" character varying(100),
    "Editorial" character varying(100),
    "Anio_Publicacion" integer,
    "Estado" public."ESTADO_LIBRO",
    "Autor" character varying,
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone
);
 %   DROP TABLE public."Libro_Historial";
       public         heap r       postgres    false    928            �            1259    16395    Libro_Id_seq    SEQUENCE     �   ALTER TABLE public."Libro" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Libro_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    218            �            1259    16528    Multa    TABLE     �  CREATE TABLE public."Multa" (
    "Id" integer NOT NULL,
    "Id_Prestamo" integer NOT NULL,
    "Monto" double precision DEFAULT 0.00,
    "Fecha_Generacion" date DEFAULT CURRENT_DATE NOT NULL,
    "Fecha_Pago" date,
    "Estado" public."ESTADO_MULTA" DEFAULT 'Pendiente'::public."ESTADO_MULTA" NOT NULL,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modificacion" timestamp without time zone
);
    DROP TABLE public."Multa";
       public         heap r       postgres    false    922    922            �            1259    16560    Multa_Historial    TABLE     5  CREATE TABLE public."Multa_Historial" (
    "Id" integer,
    "Id_Prestamo" integer,
    "Monto" double precision,
    "Fecha_Generacion" date,
    "Fecha_Pago" date,
    "Estado" public."ESTADO_MULTA",
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone
);
 %   DROP TABLE public."Multa_Historial";
       public         heap r       postgres    false    922            �            1259    16527    Multas_Id_seq    SEQUENCE     �   ALTER TABLE public."Multa" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Multas_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    230            �            1259    16402    Persona    TABLE     n  CREATE TABLE public."Persona" (
    "Id" integer NOT NULL,
    "Nombre" character varying(255) NOT NULL,
    "Apellido" character varying(255),
    "DNI" integer NOT NULL,
    "Fecha_Nacimiento" date NOT NULL,
    "Fecha_Registro" date NOT NULL,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modificacion" timestamp without time zone
);
    DROP TABLE public."Persona";
       public         heap r       postgres    false            �            1259    16563    Persona_Historial    TABLE     =  CREATE TABLE public."Persona_Historial" (
    "Id" integer,
    "Nombre" character varying(255),
    "Apellido" character varying(255),
    "DNI" integer,
    "Fecha_Nacimiento" date,
    "Fecha_Registro" date,
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone
);
 '   DROP TABLE public."Persona_Historial";
       public         heap r       postgres    false            �            1259    16502    Prestamo    TABLE     �  CREATE TABLE public."Prestamo" (
    "Id" integer NOT NULL,
    "Id_Usuario" integer NOT NULL,
    "Id_Libro" integer NOT NULL,
    "Fecha_Prestamo" date DEFAULT CURRENT_DATE NOT NULL,
    "Fecha_Devolucion_Estimada" date NOT NULL,
    "Estado" public."ESTADO_PRESTAMO" DEFAULT 'Activo'::public."ESTADO_PRESTAMO" NOT NULL,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modificacion" timestamp without time zone,
    "Fecha_Devolucion_Real" timestamp without time zone
);
    DROP TABLE public."Prestamo";
       public         heap r       postgres    false    919    919            �            1259    16569    Prestamo_Historial    TABLE     q  CREATE TABLE public."Prestamo_Historial" (
    "Id" integer,
    "Id_Usuario" integer,
    "Id_Libro" integer,
    "Fecha_Prestamo" date,
    "Fecha_Devolucion" date,
    "Estado" public."ESTADO_PRESTAMO",
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone,
    "Fecha_Devolucion_Real" timestamp without time zone
);
 (   DROP TABLE public."Prestamo_Historial";
       public         heap r       postgres    false    919            �            1259    16501    Prestamo_Id_seq    SEQUENCE     �   ALTER TABLE public."Prestamo" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Prestamo_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    228            �            1259    16484    Reserva    TABLE     �  CREATE TABLE public."Reserva" (
    "Id" integer NOT NULL,
    "Id_Usuario" integer NOT NULL,
    "Id_Libro" integer NOT NULL,
    "Fecha_Reserva" date DEFAULT CURRENT_DATE,
    "Fecha_Vencimiento" date DEFAULT (CURRENT_DATE + '60 days'::interval),
    "Estado" public."ESTADO_RESERVA" DEFAULT 'Activa'::public."ESTADO_RESERVA" NOT NULL,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modificacion" timestamp without time zone
);
    DROP TABLE public."Reserva";
       public         heap r       postgres    false    910    910            �            1259    16572    Reserva_Historial    TABLE     6  CREATE TABLE public."Reserva_Historial" (
    "Id" integer,
    "Id_Usuario" integer,
    "Id_Libro" integer,
    "Fecha_Reserva" date,
    "Fecha_Vencimiento" date,
    "Estado" public."ESTADO_RESERVA",
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone
);
 '   DROP TABLE public."Reserva_Historial";
       public         heap r       postgres    false    910            �            1259    16483    Reserva_Id_seq    SEQUENCE     �   ALTER TABLE public."Reserva" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Reserva_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    226            �            1259    16440    Usuario    TABLE     �  CREATE TABLE public."Usuario" (
    "Id" integer NOT NULL,
    "Estado" public."ESTADO_USUARIO" DEFAULT 'Activo'::public."ESTADO_USUARIO" NOT NULL,
    "Id_Persona" integer NOT NULL,
    "Tipo" public."TIPO_USUARIO" NOT NULL,
    "Libros_Prestados" integer DEFAULT 0,
    "Fecha_Creacion" timestamp without time zone DEFAULT now(),
    "Fecha_Modificacion" timestamp without time zone
);
    DROP TABLE public."Usuario";
       public         heap r       postgres    false    907    904    907            �            1259    16578    Usuario_Historial    TABLE     '  CREATE TABLE public."Usuario_Historial" (
    "Id" integer,
    "Estado" public."ESTADO_USUARIO",
    "Id_Persona" integer,
    "Tipo" public."TIPO_USUARIO",
    "Libros_Prestado" integer,
    "Fecha_Creacion" timestamp without time zone,
    "Fecha_Modificacion" timestamp without time zone
);
 '   DROP TABLE public."Usuario_Historial";
       public         heap r       postgres    false    907    904            �            1259    16401    persona_id_seq    SEQUENCE     �   ALTER TABLE public."Persona" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.persona_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    220            �            1259    16439    usuario_Id_seq    SEQUENCE     �   ALTER TABLE public."Usuario" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."usuario_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    224            �            1259    16797    vw_historial_prestamos    VIEW     z  CREATE VIEW public.vw_historial_prestamos AS
 SELECT concat(p."Nombre", ' ', p."Apellido") AS "Nombre y Apellido",
    l."Titulo",
        CASE
            WHEN ((pr."Estado" = 'Devuelto'::public."ESTADO_PRESTAMO") OR ((CURRENT_DATE - pr."Fecha_Devolucion_Estimada") < 0)) THEN 0
            ELSE (CURRENT_DATE - pr."Fecha_Devolucion_Estimada")
        END AS "Dias de Retraso",
    pr."Estado" AS "Estado del Prestamo"
   FROM (((public."Usuario" u
     JOIN public."Persona" p ON ((p."Id" = u."Id_Persona")))
     JOIN public."Prestamo" pr ON ((pr."Id_Usuario" = u."Id")))
     JOIN public."Libro" l ON ((l."Id" = pr."Id_Libro")));
 )   DROP VIEW public.vw_historial_prestamos;
       public       v       postgres    false    224    228    228    919    228    228    220    220    220    218    224    218    919            �           0    0    VIEW vw_historial_prestamos    COMMENT     �  COMMENT ON VIEW public.vw_historial_prestamos IS '-- Esta consulta devuelve una lista de préstamos de libros con la siguiente información:
-- - El nombre y apellido del usuario que realizó el préstamo.
-- - El título del libro prestado.
-- - La cantidad de días de retraso en la devolución del libro, calculada como la diferencia entre
--   la fecha actual y la fecha de devolución estimada. Si el libro ya fue devuelto o aún no venció el plazo, se muestra 0.
-- - El estado actual del préstamo (por ejemplo, Activo, Retrasado o Devuelto).
--
-- La consulta une las tablas Usuario, Persona, Prestamo y Libro mediante sus claves foráneas
-- para obtener los datos combinados de cada préstamo realizado en el sistema.
';
          public               postgres    false    240            �            1259    16818    vw_libros_populares    VIEW     �  CREATE VIEW public.vw_libros_populares AS
 SELECT l."Titulo",
    count(pr."Id") AS "Cantidad de Prestamos realizados",
    ((120)::double precision - sum(date_part('day'::text, ((pr."Fecha_Devolucion_Estimada")::timestamp without time zone - pr."Fecha_Creacion")))) AS "Días Disponible",
    ((((120)::double precision - sum(date_part('day'::text, ((pr."Fecha_Devolucion_Estimada")::timestamp without time zone - pr."Fecha_Creacion")))) * (100.0)::double precision) / (120)::double precision) AS "Tasa de Disponibilidad (%)"
   FROM (public."Libro" l
     LEFT JOIN public."Prestamo" pr ON (((pr."Id_Libro" = l."Id") AND (pr."Fecha_Creacion" >= (now() - '120 days'::interval)))))
  GROUP BY l."Titulo"
  ORDER BY (count(pr."Id")) DESC
 LIMIT 10;
 &   DROP VIEW public.vw_libros_populares;
       public       v       postgres    false    218    228    228    228    228    218            �            1259    16760    vw_liibros_mas_prestados    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW public.vw_liibros_mas_prestados AS
 SELECT "Titulo",
    "Autor",
    "ISBN",
    count(*) AS veces_prestado
   FROM ( SELECT "Libro"."Titulo",
            "Libro"."Autor",
            "Libro"."ISBN",
            "Libro"."Estado"
           FROM public."Libro"
        UNION ALL
         SELECT "Libro_Historial"."Titulo",
            "Libro_Historial"."Autor",
            "Libro_Historial"."ISBN",
            "Libro_Historial"."Estado"
           FROM public."Libro_Historial") libros
  WHERE ("Estado" = 'Prestado'::public."ESTADO_LIBRO")
  GROUP BY "Titulo", "Autor", "ISBN"
  ORDER BY (count(*)) DESC
  WITH NO DATA;
 8   DROP MATERIALIZED VIEW public.vw_liibros_mas_prestados;
       public         heap m       postgres    false    232    232    218    218    218    218    928    232    232            �            1259    16783    vw_usuarios_libros    VIEW     �  CREATE VIEW public.vw_usuarios_libros AS
 SELECT concat(p."Nombre", ' ', p."Apellido") AS "Nombre y Apellido",
    count(DISTINCT
        CASE
            WHEN (pr."Estado" = ANY (ARRAY['Activo'::public."ESTADO_PRESTAMO", 'Retrasado'::public."ESTADO_PRESTAMO"])) THEN pr."Id"
            ELSE NULL::integer
        END) AS "Libros Prestados",
    count(DISTINCT
        CASE
            WHEN (m."Estado" = 'Pendiente'::public."ESTADO_MULTA") THEN m."Id"
            ELSE NULL::integer
        END) AS "Multas Impagas"
   FROM (((public."Usuario" u
     JOIN public."Persona" p ON ((p."Id" = u."Id_Persona")))
     LEFT JOIN public."Prestamo" pr ON ((pr."Id_Usuario" = u."Id")))
     LEFT JOIN public."Multa" m ON ((m."Id_Prestamo" = pr."Id")))
  GROUP BY p."Nombre", p."Apellido"
  ORDER BY (count(DISTINCT
        CASE
            WHEN (pr."Estado" = ANY (ARRAY['Activo'::public."ESTADO_PRESTAMO", 'Retrasado'::public."ESTADO_PRESTAMO"])) THEN pr."Id"
            ELSE NULL::integer
        END)) DESC, (count(DISTINCT
        CASE
            WHEN (m."Estado" = 'Pendiente'::public."ESTADO_MULTA") THEN m."Id"
            ELSE NULL::integer
        END)) DESC;
 %   DROP VIEW public.vw_usuarios_libros;
       public       v       postgres    false    922    220    220    220    224    224    228    228    228    919    230    230    230            �           0    0    VIEW vw_usuarios_libros    COMMENT     �  COMMENT ON VIEW public.vw_usuarios_libros IS '-- Esta consulta obtiene la cantidad de libros prestados y multas impagas por cada usuario.
-- Para cada usuario, se realiza lo siguiente:
-- 
-- 1. **Nombre y Apellido**: Se concatena el nombre y apellido del usuario.
-- 
-- 2. **Libros Prestados**:
--    - Se cuenta la cantidad de libros prestados que están en estado ''Activo'' o ''Retrasado''.
--    - Esto se logra utilizando la función `COUNT` junto con un `CASE` que filtra solo los registros con esos estados.
-- 
-- 3. **Multas Impagas**:
--    - Se cuenta la cantidad de multas impagas, es decir, aquellas cuyo estado es ''Pendiente''.
--    - Esto también se logra utilizando `COUNT` junto con un `CASE` que filtra solo las multas con ese estado.
-- 
-- 4. **JOINs**:
--    - Se realiza un `JOIN` entre las tablas `Usuario` y `Persona` para obtener el nombre y apellido del usuario.
--    - Se realiza un `LEFT JOIN` con la tabla `Prestamo` para obtener los préstamos asociados al usuario.
--    - Se realiza otro `LEFT JOIN` con la tabla `Multa` para obtener las multas asociadas a los préstamos.
-- 
-- 5. **Condiciones**:
--    - El estado del préstamo debe ser ''Activo'' o ''Retrasado'' para contar los libros prestados.
--    - El estado de la multa debe ser ''Pendiente'' para contar las multas impagas.
-- 
-- 6. **Agrupamiento**:
--    - Los resultados se agrupan por nombre y apellido de los usuarios, de modo que se muestre la cantidad de libros prestados y multas impagas por cada usuario.
-- 
-- 7. **Ordenación**:
--    - Los resultados se ordenan primero por la cantidad de libros prestados (`"Libros Prestados"`) en orden descendente.
--    - Luego, se ordenan por la cantidad de multas impagas (`"Multas Impagas"`) también en orden descendente.
';
          public               postgres    false    239                       2606    16418    Direccion Direcciones_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Direccion"
    ADD CONSTRAINT "Direcciones_pkey" PRIMARY KEY ("Id");
 H   ALTER TABLE ONLY public."Direccion" DROP CONSTRAINT "Direcciones_pkey";
       public                 postgres    false    222                       2606    16400    Libro Libro_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Libro"
    ADD CONSTRAINT "Libro_pkey" PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY public."Libro" DROP CONSTRAINT "Libro_pkey";
       public                 postgres    false    218                       2606    16533    Multa Multas_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Multa"
    ADD CONSTRAINT "Multas_pkey" PRIMARY KEY ("Id");
 ?   ALTER TABLE ONLY public."Multa" DROP CONSTRAINT "Multas_pkey";
       public                 postgres    false    230                       2606    16506    Prestamo Prestamo_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Prestamo"
    ADD CONSTRAINT "Prestamo_pkey" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."Prestamo" DROP CONSTRAINT "Prestamo_pkey";
       public                 postgres    false    228                       2606    16488    Reserva Reserva_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Reserva"
    ADD CONSTRAINT "Reserva_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Reserva" DROP CONSTRAINT "Reserva_pkey";
       public                 postgres    false    226                       2606    16408    Persona persona_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT persona_pkey PRIMARY KEY ("Id");
 @   ALTER TABLE ONLY public."Persona" DROP CONSTRAINT persona_pkey;
       public                 postgres    false    220                       2606    16410    Persona persona_unico_DNI 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "persona_unico_DNI" UNIQUE ("DNI");
 G   ALTER TABLE ONLY public."Persona" DROP CONSTRAINT "persona_unico_DNI";
       public                 postgres    false    220                       2606    16444    Usuario usuario_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT usuario_pkey PRIMARY KEY ("Id");
 @   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT usuario_pkey;
       public                 postgres    false    224                       1259    16424    fki_DIRECCION_PERSONA    INDEX     W   CREATE INDEX "fki_DIRECCION_PERSONA" ON public."Direccion" USING btree ("Id_Persona");
 +   DROP INDEX public."fki_DIRECCION_PERSONA";
       public                 postgres    false    222                       1259    16526    fki_O    INDEX     D   CREATE INDEX "fki_O" ON public."Prestamo" USING btree ("Id_Libro");
    DROP INDEX public."fki_O";
       public                 postgres    false    228                       1259    16520    fki_PRESTAMO_USUARIO    INDEX     U   CREATE INDEX "fki_PRESTAMO_USUARIO" ON public."Prestamo" USING btree ("Id_Usuario");
 *   DROP INDEX public."fki_PRESTAMO_USUARIO";
       public                 postgres    false    228                       1259    16500    fki_RESERVA_LIBRO    INDEX     O   CREATE INDEX "fki_RESERVA_LIBRO" ON public."Reserva" USING btree ("Id_Libro");
 '   DROP INDEX public."fki_RESERVA_LIBRO";
       public                 postgres    false    226                       1259    16494    fki_U    INDEX     E   CREATE INDEX "fki_U" ON public."Reserva" USING btree ("Id_Usuario");
    DROP INDEX public."fki_U";
       public                 postgres    false    226                       1259    16450    fki_USUARIO_PERSONA    INDEX     S   CREATE INDEX "fki_USUARIO_PERSONA" ON public."Usuario" USING btree ("Id_Persona");
 )   DROP INDEX public."fki_USUARIO_PERSONA";
       public                 postgres    false    224            5           2620    16759    Multa tg_insert_multa    TRIGGER     w   CREATE TRIGGER tg_insert_multa BEFORE INSERT ON public."Multa" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_multa();
 0   DROP TRIGGER tg_insert_multa ON public."Multa";
       public               postgres    false    230    266            1           2620    16707    Prestamo tg_insert_prestamo    TRIGGER     �   CREATE TRIGGER tg_insert_prestamo BEFORE INSERT ON public."Prestamo" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_prestamo();
 6   DROP TRIGGER tg_insert_prestamo ON public."Prestamo";
       public               postgres    false    228    267            .           2620    16842    Reserva tg_insert_reserva    TRIGGER     |   CREATE TRIGGER tg_insert_reserva AFTER INSERT ON public."Reserva" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_reserva();
 4   DROP TRIGGER tg_insert_reserva ON public."Reserva";
       public               postgres    false    274    226            *           2620    16658    Direccion tg_update_direccion    TRIGGER     �   CREATE TRIGGER tg_update_direccion BEFORE UPDATE ON public."Direccion" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 8   DROP TRIGGER tg_update_direccion ON public."Direccion";
       public               postgres    false    222    244            &           2620    16661    Libro tg_update_libro    TRIGGER     �   CREATE TRIGGER tg_update_libro BEFORE UPDATE ON public."Libro" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 0   DROP TRIGGER tg_update_libro ON public."Libro";
       public               postgres    false    244    218            6           2620    16662    Multa tg_update_multa    TRIGGER     �   CREATE TRIGGER tg_update_multa BEFORE UPDATE ON public."Multa" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 0   DROP TRIGGER tg_update_multa ON public."Multa";
       public               postgres    false    244    230            7           2620    16789 .   Multa tg_update_multa_reveer_condicion_usuario    TRIGGER     �   CREATE TRIGGER tg_update_multa_reveer_condicion_usuario AFTER UPDATE ON public."Multa" FOR EACH ROW EXECUTE FUNCTION public.fn_update_multa();
 I   DROP TRIGGER tg_update_multa_reveer_condicion_usuario ON public."Multa";
       public               postgres    false    230    273            +           2620    16583 '   Direccion tg_update_or_delete_direccion    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_direccion AFTER DELETE OR UPDATE ON public."Direccion" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_direccion_historial();
 B   DROP TRIGGER tg_update_or_delete_direccion ON public."Direccion";
       public               postgres    false    222    242            '           2620    16642    Libro tg_update_or_delete_libro    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_libro AFTER DELETE OR UPDATE ON public."Libro" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_libro_historial();
 :   DROP TRIGGER tg_update_or_delete_libro ON public."Libro";
       public               postgres    false    245    218            8           2620    16660    Multa tg_update_or_delete_multa    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_multa AFTER DELETE OR UPDATE ON public."Multa" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_multa_historial();
 :   DROP TRIGGER tg_update_or_delete_multa ON public."Multa";
       public               postgres    false    246    230            (           2620    16645 #   Persona tg_update_or_delete_persona    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_persona AFTER DELETE OR UPDATE ON public."Persona" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_persona_historial();
 >   DROP TRIGGER tg_update_or_delete_persona ON public."Persona";
       public               postgres    false    220    243            2           2620    16667 %   Prestamo tg_update_or_delete_prestamo    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_prestamo AFTER DELETE OR UPDATE ON public."Prestamo" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_prestamo_historial();
 @   DROP TRIGGER tg_update_or_delete_prestamo ON public."Prestamo";
       public               postgres    false    228    247            /           2620    16669 #   Reserva tg_update_or_delete_reserva    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_reserva AFTER DELETE OR UPDATE ON public."Reserva" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_reserva_historial();
 >   DROP TRIGGER tg_update_or_delete_reserva ON public."Reserva";
       public               postgres    false    226    248            ,           2620    16671 #   Usuario tg_update_or_delete_usuario    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_usuario AFTER DELETE OR UPDATE ON public."Usuario" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_usuario_historial();
 >   DROP TRIGGER tg_update_or_delete_usuario ON public."Usuario";
       public               postgres    false    224    249            9           2620    16702 -   Usuario_Historial tg_update_or_delete_usuario    TRIGGER     �   CREATE TRIGGER tg_update_or_delete_usuario AFTER DELETE OR UPDATE ON public."Usuario_Historial" FOR EACH ROW EXECUTE FUNCTION public.fn_insert_usuario_historial();
 H   DROP TRIGGER tg_update_or_delete_usuario ON public."Usuario_Historial";
       public               postgres    false    237    249            )           2620    16647    Persona tg_update_persona    TRIGGER     �   CREATE TRIGGER tg_update_persona BEFORE UPDATE ON public."Persona" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 4   DROP TRIGGER tg_update_persona ON public."Persona";
       public               postgres    false    244    220            3           2620    16663    Prestamo tg_update_prestamo    TRIGGER     �   CREATE TRIGGER tg_update_prestamo BEFORE UPDATE ON public."Prestamo" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 6   DROP TRIGGER tg_update_prestamo ON public."Prestamo";
       public               postgres    false    228    244            4           2620    16721 '   Prestamo tg_update_prestamo_condiciones    TRIGGER     �   CREATE TRIGGER tg_update_prestamo_condiciones BEFORE UPDATE ON public."Prestamo" FOR EACH ROW EXECUTE FUNCTION public.fn_update_prestamo();
 B   DROP TRIGGER tg_update_prestamo_condiciones ON public."Prestamo";
       public               postgres    false    228    263            0           2620    16668    Reserva tg_update_reserva    TRIGGER     �   CREATE TRIGGER tg_update_reserva BEFORE UPDATE ON public."Reserva" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 4   DROP TRIGGER tg_update_reserva ON public."Reserva";
       public               postgres    false    226    244            -           2620    16670    Usuario tg_update_usuario    TRIGGER     �   CREATE TRIGGER tg_update_usuario BEFORE UPDATE ON public."Usuario" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 4   DROP TRIGGER tg_update_usuario ON public."Usuario";
       public               postgres    false    224    244            :           2620    16701 #   Usuario_Historial tg_update_usuario    TRIGGER     �   CREATE TRIGGER tg_update_usuario BEFORE UPDATE ON public."Usuario_Historial" FOR EACH ROW EXECUTE FUNCTION public.fn_set_fecha_modificacion();
 >   DROP TRIGGER tg_update_usuario ON public."Usuario_Historial";
       public               postgres    false    237    244                        2606    16419    Direccion DIRECCION_PERSONA    FK CONSTRAINT     �   ALTER TABLE ONLY public."Direccion"
    ADD CONSTRAINT "DIRECCION_PERSONA" FOREIGN KEY ("Id_Persona") REFERENCES public."Persona"("Id") NOT VALID;
 I   ALTER TABLE ONLY public."Direccion" DROP CONSTRAINT "DIRECCION_PERSONA";
       public               postgres    false    222    4877    220            $           2606    16521    Prestamo PRESTAMO_LIBRO    FK CONSTRAINT     �   ALTER TABLE ONLY public."Prestamo"
    ADD CONSTRAINT "PRESTAMO_LIBRO" FOREIGN KEY ("Id_Libro") REFERENCES public."Libro"("Id") NOT VALID;
 E   ALTER TABLE ONLY public."Prestamo" DROP CONSTRAINT "PRESTAMO_LIBRO";
       public               postgres    false    228    4875    218            %           2606    16515    Prestamo PRESTAMO_USUARIO    FK CONSTRAINT     �   ALTER TABLE ONLY public."Prestamo"
    ADD CONSTRAINT "PRESTAMO_USUARIO" FOREIGN KEY ("Id_Usuario") REFERENCES public."Usuario"("Id") NOT VALID;
 G   ALTER TABLE ONLY public."Prestamo" DROP CONSTRAINT "PRESTAMO_USUARIO";
       public               postgres    false    228    4885    224            "           2606    16495    Reserva RESERVA_LIBRO    FK CONSTRAINT     �   ALTER TABLE ONLY public."Reserva"
    ADD CONSTRAINT "RESERVA_LIBRO" FOREIGN KEY ("Id_Libro") REFERENCES public."Libro"("Id") NOT VALID;
 C   ALTER TABLE ONLY public."Reserva" DROP CONSTRAINT "RESERVA_LIBRO";
       public               postgres    false    4875    226    218            #           2606    16489    Reserva RESERVA_USUARIO    FK CONSTRAINT     �   ALTER TABLE ONLY public."Reserva"
    ADD CONSTRAINT "RESERVA_USUARIO" FOREIGN KEY ("Id_Usuario") REFERENCES public."Usuario"("Id") NOT VALID;
 E   ALTER TABLE ONLY public."Reserva" DROP CONSTRAINT "RESERVA_USUARIO";
       public               postgres    false    224    4885    226            !           2606    16445    Usuario USUARIO_PERSONA    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "USUARIO_PERSONA" FOREIGN KEY ("Id_Persona") REFERENCES public."Persona"("Id") NOT VALID;
 E   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "USUARIO_PERSONA";
       public               postgres    false    224    4877    220           