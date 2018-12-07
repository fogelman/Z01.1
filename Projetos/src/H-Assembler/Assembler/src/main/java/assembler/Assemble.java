/**
 * Curso: Elementos de Sistemas
 * Arquivo: Assemble.java
 * Created by Luciano <lpsoares@insper.edu.br> 
 * Date: 04/02/2017
 *
 * 2018 @ Rafael Corsi
 */

package assembler;

import java.io.*;
import java.util.*;

/**
 * Faz a geração do código gerenciando os demais módulos
 */
public class Assemble {
    private String inputFile;              // arquivo de entrada nasm
    File hackFile = null;                  // arquivo de saída hack
    private PrintWriter outHACK = null;    // grava saida do código de máquina em Hack
    boolean debug;                         // flag que especifica se mensagens de debug são impressas
    private SymbolTable table;             // tabela de símbolos (variáveis e marcadores)

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public Assemble(String inFile, String outFileHack, boolean debug) throws IOException {
        this.debug = debug;
        inputFile  = inFile;
        hackFile   = new File(outFileHack);                      // Cria arquivo de saída .hack
        outHACK    = new PrintWriter(new FileWriter(hackFile));  // Cria saída do print para
                                                                 // o arquivo hackfile
        table      = new SymbolTable();                          // Cria e inicializa a tabela de simbolos

    }

    /**
     * primeiro passo para a construção da tabela de símbolos de marcadores (labels)
     * varre o código em busca de Símbolos novos Labels e Endereços de memórias
     * e atualiza a tabela de símbolos com os endereços.
     *
     * Dependencia : Parser, SymbolTable
     */
    public void fillSymbolTable() throws FileNotFoundException, IOException {
	linhaTemp = 0;
	Parser parsLabel = new Parser(inputFile);
	while (parsLabel.advance()){
		if (parsLabel.commandType(parsLabel.command()) == L_COMMAND){
			String label = parsLabel.label(parsLabel.command());
			if (!table.contains(label)){
				table.addEntry(label, linha);
            }
        }
		else{
			linha += 1;
	    }
    }
    ramTemp = 16;
    Parser parsSymbol = new Parser(inputFile);
    while (parsSymbol.advance()){
        if (parsSymbol.commandType(parsSymbol.command()) == A_COMMAND){
            String symbol = parsSymbol.symbol(parsSymbol.command());
            if (!(symbol.charAt(0)>47 && symbol.charAt(0)<58)){ //if not number
                if (!table.contains(symbol)){
                    table.addEntry(symbol, ramTemp);
                    ramTemp += 1;
                }
            }
        }
    }
}

    /**
     * Segundo passo para a geração do código de máquina
     * Varre o código em busca de instruções do tipo A, C
     * gerando a linguagem de máquina a partir do parse das instruções.
     *
     * Dependencias : Parser, Code
     */
	

    public void generateMachineCode() throws FileNotFoundException, IOException{
        Parser parsGen = new Parser(inputFile);
        Code codes = new Code();
        String final_code = "";
        while(parsGen.advance()){
        	
        	final_code = "";
	
        	if (parsGen.commandType(parsGen.command()) == CommandType.A_COMMAND){
        		
            	String symbol = parsGen.symbol(parsGen.command());
            	
        		if (!(symbol.charAt(0)>47 && symbol.charAt(0)<58)){
 
        			
        			String value =String.valueOf(table.getAddress(symbol));	
        			
        			final_code = "000" + codes.toBinary(value);
        			
        		} else {
        			
        			final_code = "000" + codes.toBinary(symbol);	
        		}
        		outHACK.println(final_code);
        		
        	} else if(parsGen.commandType(parsGen.command()) == CommandType.C_COMMAND) {
        		
               	String[] mnemnonic = parsGen.instruction(parsGen.command());
        		final_code = "10"+ codes.comp(mnemnonic)+codes.dest(mnemnonic)+codes.jump(mnemnonic);
        		outHACK.println(final_code);

        	}
        	        	 
        }
    }

    /**
     * Fecha arquivo de escrita
     */
    public void close() throws IOException {
        if(outHACK!=null) {
            outHACK.close();
        }
    }

    /**
     * Remove o arquivo de .hack se algum erro for encontrado
     */
    public void delete() {
        try{
            if(hackFile!=null) {
                hackFile.delete();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

}