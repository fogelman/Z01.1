/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */

package assembler;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

/**
 * Encapsula o código de leitura. Carrega as instruções na linguagem
 * assembly, analisa, e oferece acesso as partes da instrução (campos e
 * símbolos). Além disso, remove todos os espaços em branco e comentários.
 */
public class Parser {
	private Scanner scanner;
	private String[] operators = { "movw", "jmp", "addw", "subw", "rsubw", "incw", "decw", "notw", "negw", "andw","orw", "je", "jne", "jg", "jge", "jl", "jle", "nop" };
	private String[] leaw = { "leaw" };
	private String currentLine;

	/** Enumerator para os tipos de comandos do Assembler. */
	public enum CommandType {
		A_COMMAND, // comandos LEA, que armazenam no registrador A
		C_COMMAND, // comandos de calculos
		L_COMMAND // comandos de Label (símbolos)
	}

	/**
	 * Abre o arquivo de entrada NASM e se prepara para analisá-lo.
	 * 
	 * @param file arquivo NASM que será feito o parser.
	 * @throws FileNotFoundException
	 */
	public Parser(String file) throws FileNotFoundException {
		FileInputStream fis = new FileInputStream(file);
        scanner = new Scanner(fis);


	}

	/**
	 * Carrega uma instrução e avança seu apontador interno para o próxima linha
	 * do arquivo de entrada. Caso não haja mais linhas no arquivo de entrada o
	 * método retorna "Falso", senão retorna "Verdadeiro".
	 * 
	 * @return Verdadeiro se ainda há instruções, Falso se as instruções
	 *         terminaram.
	 * @throws IOException 
	 */
	public Boolean advance() throws IOException {
		while(scanner.hasNextLine()) {
			currentLine = scanner.nextLine();
			String[] instruction = currentLine.split(";");
			currentLine = instruction[0];
			currentLine = currentLine.trim();
			System.out.println(currentLine);
			if(currentLine.length()>0 && currentLine.charAt(0) !=';') {
				return true;
			}
			
			
		}

		scanner.close();
		return false;
	}

	/**
	 * Retorna o comando "intrução" atual (sem o avanço)
	 * 
	 * @return a instrução atual para ser analilisada
	 */
	public String command() {
		
		return currentLine;
	}

	/**
	 * Retorna o tipo da instrução passada no argumento: A_COMMAND para leaw, por
	 * exemplo leaw $1,%A L_COMMAND para labels, por exemplo Xyz: , onde Xyz é um
	 * símbolo. C_COMMAND para todos os outros comandos
	 * 
	 * @param command instrução a ser analisada.
	 * @return o tipo da instrução.
	 */
	public CommandType commandType(String command) {
		String[] parts = instruction(command);
		boolean operator = Arrays.stream(operators).anyMatch(parts[0]::equals);
		boolean isLeaw = Arrays.stream(leaw).anyMatch(parts[0]::equals);

		if (parts[0].indexOf(':') >= 0) {
			return CommandType.L_COMMAND;

		} else if (operator) {
			return CommandType.C_COMMAND;
		} else if (isLeaw) {
			return CommandType.A_COMMAND;
		}
		return null;
	}

	/**
	 * Retorna o símbolo ou valor numérico da instrução passada no argumento.
	 * Deve ser chamado somente quando commandType() é A_COMMAND.
	 * 
	 * @param command instrução a ser analisada.
	 * @return somente o símbolo ou o valor número da instrução.
	 */
	public String symbol(String command) {
		CommandType commandType = commandType(command);
		String[] parts = instruction(command);
		String symbolTest;
		if (commandType == CommandType.A_COMMAND) {

			return symbolTest = parts[1].replace("$", "");
		}
		return null;
	}

	/**
	 * Retorna o símbolo da instrução passada no argumento. Deve ser chamado
	 * somente quando commandType() é L_COMMAND.
	 * 
	 * @param command instrução a ser analisada.
	 * @return o símbolo da instrução (sem os dois pontos).
	 */
	public String label(String command) {
		CommandType commandType = commandType(command);
		if (commandType == CommandType.L_COMMAND) {
			command = command.replace(":", "");
			return command;
		}
		return null;
	}

	/**
	 * Separa os mnemônicos da instrução fornecida em tokens em um vetor de
	 * Strings. Deve ser chamado somente quando CommandType () é C_COMMAND.
	 * 
	 * @param command instrução a ser analisada.
	 * @return um vetor de string contento os tokens da instrução (as partes do
	 *         comando).
	 */
	public String[] instruction(String command) {
		String[] instruction = command.split(" |,");

		return instruction;
	}
	

}
