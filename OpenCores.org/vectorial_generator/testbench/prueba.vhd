LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;


LIBRARY work;
USE work.gen_vectorial_pkg.all;


--==============================================================================
ENTITY prueba IS 
--==============================================================================
    PORT(
        clock       : IN STD_LOGIC;
        enable      : IN STD_LOGIC;
        areset      : IN STD_LOGIC;
        trigger     : IN STD_LOGIC;     -- inicio de todas las generaciones (1 CICLO)
        valor_in	: IN valores_vector;
        ciclos		: IN valores_vector;
        vector_out  : OUT STD_LOGIC_VECTOR(1-1 DOWNTO 0);   -- <<<<<<<<<<<< width <<<<<<<<<<<<<<<<<<
        fin         : OUT STD_LOGIC;    -- fin de todas las generaciones
        error       : OUT STD_LOGIC
        --test		: OUT NATURAL
        );                   
    END ;

--==============================================================================
ARCHITECTURE prueba_arch OF prueba IS
--==============================================================================

    COMPONENT gen_vectorial
    GENERIC (
            WIDTH           : NATURAL;                                  -- ancho de bus
            DEFAULT_VALUE   : STD_LOGIC
            );
    PORT (  
            clock           : IN STD_LOGIC;
            enable          : IN STD_LOGIC;
            areset          : IN STD_LOGIC;
            trigger         : IN STD_LOGIC;                             -- disparo de la generacion del vector de test
            valores         : IN vector_integer;
            vector_out      : OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);   -- vector de test generado
            fin             : OUT STD_LOGIC;                            -- fin de la generacion
            error           : OUT STD_LOGIC                             -- error de configuracion o formato de valores incorrecto
        );                                                              
    END COMPONENT;

--******************************************************************************
    
--  VER FORMATO DE REPRESENTACION EN "gen_vectorial.vhd"
    SIGNAL valores_i : vector_integer;
    
    SIGNAL vector_out_aux: std_logic_vector (1-1 DOWNTO 0);
	

--******************************************************************************
--******************************************************************************
    
BEGIN

    valores_i <= (valor_in,valor_in,others=>0);
				  
    prueba: gen_vectorial
    GENERIC MAP (
            WIDTH           => 1,
            DEFAULT_VALUE   => 'Z'                              
            )
    PORT MAP (  
            clock           => clock,
            enable          => enable,
            areset          => areset,
            trigger         => trigger,             
            valores         => valores_i,
            vector_out      => vector_out_aux,
            fin             => fin,
            error           => error
        );          
                                                            
    vector_out <= vector_out_aux;
    
END prueba_arch;