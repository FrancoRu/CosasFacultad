create or replace function validarCUIL(
	in cuil varchar(255)
) 
returns varchar(255)
AS $$
	DECLARE res varchar(255):= '';
	BEGIN
		IF LENGTH(cuil) <> 11 AND LENGTH(cuil) <> 13 
			THEN res := 'CUIL Invalido. 
						El cuil debe tener el siguiente formato valido: xx-xxxxxxxx-x o xxxxxxxxxxx'
		END IF

		IF LENGTH(cuil) = 11
			THEN
			DEFAULT 
				
		END IF

		IF LENGTH(res) = 0 AND res = ''
			THEN res:= 'CUIL invalido: "'+ cuil + '".'
			DEFAULT res:= 'CUIL valido.'
		END IF

		return res;
		
	END;
$$ LANGUAGE plpgsql;