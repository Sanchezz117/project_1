CREATE OR REPLACE FUNCTION "AZON".add_new_client(text, text, text, text, text, text, integer, text, text, text, text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
 declare 
p_surname text := $1;
p_name text := $2;
p_patronymic text := $3;
p_phone_number text := $4;
p_email text := $5;
p_bill_number text := $6;
p_last_delivery_address int := $7;
p_city text := $8;
p_street text := $9;
p_house_number text := $10;
p_apartment_number text := $11;
begin
	if p_surname is null or p_surname like ''
	then raise exception 'Это поле не может быть пустым.' USING HINT = 'Поле "Фамилия" не может быть пустым.'; 
	elseif 
		p_name is null or p_name like ''
	then raise exception 'Это поле не может быть пустым.' USING HINT = 'Поле "Имя" не может быть пустым.'; 
	elseif  
		p_phone_number is null or p_phone_number like ''
	then raise exception 'Это поле не может быть пустым.' USING HINT = 'Пожалуйста, введите номер телефона.'; 
	elseif  
		p_phone_number = (select phone_number from client where p_phone_number = phone_number)
	then raise exception 'Введенные данные уже используются.' USING HINT = 'Пожалуйста, введите другой номер телефона.'; 
	elseif 
		p_email is null or p_email like ''
	then raise exception 'Это поле не может быть пустым.' USING HINT = 'Поле "e-mail" не может быть пустым.'; 
	elseif 
		p_email = (select email from client where p_email = email)
	then raise exception 'Введенные данные уже используются.' USING HINT = 'Пожалуйста, введите другой адрес электронной почты.'; 
	elseif 
		p_bill_number is null or p_bill_number like ''
	then raise exception 'Это поле не может быть пустым.' USING HINT = 'Пожалуйста, введите Ваш платежный номер.'; 
	elseif 
		p_bill_number = (select bill_number from client where p_bill_number = bill_number)
	then raise exception 'Введенные данные уже используются.' USING HINT = 'Пожалуйста, введите другой платежный номер.';
	elseif
		char_length(p_phone_number) <> 10
	then raise exception 'Неверное количестко знаков.' USING HINT = 'Номер телефона должен содержать 10 символов.'; 
	elseif
		char_length(p_bill_number) <> 16
	then raise exception 'Неверное количестко знаков.' USING HINT = 'Платежный номер должен содержать 16 символов.'; 
	elseif 
	p_phone_number ~* ' '	
	then raise exception 'Недопустимый знак.' USING HINT = 'Номер телефона не может содержать пробелы.';
	elseif 
	p_bill_number ~* ' '	
	then raise exception 'Недопустимый знак.' USING HINT = 'Платежный номер не может содержать пробелы.';
	elseif 
	p_email ~* ' '	
	then raise exception 'Недопустимый знак.' USING HINT = 'Адрес электронной почты не может содержать пробелы.';
	end if;
	insert into client (surname, "name", patronymic, phone_number, email, bill_number, last_delivery_address, city, street, house_number, apartment_number)
	values (p_surname, p_name, p_patronymic, p_phone_number, p_email, p_bill_number, p_last_delivery_address, p_city, p_street, p_house_number, p_apartment_number);
end;
$function$
;
