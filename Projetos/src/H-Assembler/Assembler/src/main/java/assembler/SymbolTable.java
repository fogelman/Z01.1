/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTable.java
 */

package assembler;

import java.util.HashMap;
import java.util.Map;
/**
 * Mantém uma tabela com a correspondência entre os rótulos simbólicos e endereços numéricos de memória.
 */
public class SymbolTable {

    /**
     * Cria a tabela de Simbolos utilizada na RAM
     */
	
	Map<String,Integer> Table = new HashMap<String,Integer>();
	
    public SymbolTable() {
    	Table.put("R0", 0);
    	Table.put("R1", 1);
    	Table.put("R2", 2);
    	Table.put("R3", 3);
    	Table.put("R4", 4);
    	Table.put("R5", 5);
    	Table.put("R6", 6);
    	Table.put("R7", 7);
    	Table.put("R8", 8);
    	Table.put("R9", 9);
    	Table.put("R10", 10);
    	Table.put("R11", 11);
    	Table.put("R12", 12);
    	Table.put("R13", 13);
    	Table.put("R14", 14);
    	Table.put("R15", 15);
    	Table.put("SP", 0);
    	Table.put("LCL", 1);
    	Table.put("ARG", 2);
    	Table.put("THIS", 3);
    	Table.put("THAT", 4);
    	Table.put("SCREEN", 16384);
    	Table.put("LED", 21184);
    	Table.put("SW", 21185);
    	
    }

    /**
     * Insere uma entrada de um símbolo com seu endereço numérico na tabela de símbolos.
     * @param  symbol símbolo a ser armazenado na tabela de símbolos.
     * @param  address símbolo a ser armazenado na tabela de símbolos.
     */
    public void addEntry(String symbol, int address) {
      /**
       * Adiciona novas variaveis
       **/
    	Table.put(symbol, address);
    }

    /**
     * Confere se o símbolo informado já foi inserido na tabela de símbolos.
     * @param  symbol símbolo a ser procurado na tabela de símbolos.
     * @return Verdadeiro se símbolo está na tabela de símbolos, Falso se não está na tabela de símbolos.
     */
    public Boolean contains(String symbol) {
        /**
         * verifica se ja tem uma var
         **/
    	
    	return Table.containsKey(symbol);
    }

    /**
     * Retorna o valor númerico associado a um símbolo já inserido na tabela de símbolos.
     * @param  symbol símbolo a ser procurado na tabela de símbolos.
     * @return valor numérico associado ao símbolo procurado.
     */
    public Integer getAddress(String symbol) {
        /**
         * Puxando variaveis
         **/
    	return Table.get(symbol);
    }

}
