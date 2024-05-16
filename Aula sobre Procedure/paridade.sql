CREATE PROCEDURE `paridade` (IN numero INT, OUT resposta varchar(5))
BEGIN

IF MOD(numero,2) = 0 THEN
	SET resposta := "par";
ELSE
	SET resposta := "impar";
    
END IF;
END
