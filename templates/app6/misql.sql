DROP PROCEDURE IF EXISTS pInsertUsuario;
CREATE PROCEDURE pInsertUsuario (
	IN v_name varchar(100),
	IN v_user varchar(70),
	IN v_email varchar(50),
	IN v_password varchar(100)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM usuario WHERE user = v_user) THEN
		INSERT INTO usuario(name,user,email,password,date) 
			VALUES(v_name,v_user,v_email,v_password,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,'success' AS error;
	ELSE
		SELECT 'Error: Usuario ya registrado.' AS error;
	END IF;
END //

{
	"name": "Rosaly Sanchez",
	"user": "rosaly",
	"email": "rosaly@gmail.com",
	"password": "1234"
}