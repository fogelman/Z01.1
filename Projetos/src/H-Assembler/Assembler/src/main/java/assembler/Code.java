/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package assembler;


import java.util.ArrayList;
/**
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {

    /**
     * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 4 bits) com código em linguagem de máquina para a instrução.
     */
	
    public static String dest(String[] mnemnonic) {
    	
        /**
         * Verificar o tamanho da linha de codigo do mnemnonic e o que esta sendo especificado
         * Contruir o vetor destino apartir disso
         */
        /**
         * Com uma palavra
         */
    	for (int i = mnemnonic.length; i == 1;){
    		return "0000";
    	}
        /**
         * Com duas palavra
         */
    	for (int i = mnemnonic.length; i == 2;){
    		if(mnemnonic[1].equals("%A")) 
    			return "1000";
    		else if(mnemnonic[1].equals("%S")) 
    			return "0100";
    		else if(mnemnonic[1].equals("%D")) 
    			return "0010";
    		else if(mnemnonic[1].equals("(%A)")) 
    			return "0001";
    	}
        /**
         * Com tres ou mais palavra
         */
    	for (int i = mnemnonic.length; i >= 3;){
    		if (mnemnonic.length==3) {
    			if(mnemnonic[2].equals("%A")) 
	    			return "1000";
	    		else if(mnemnonic[2].equals("%S")) 
	    			return "0100";
	    		else if(mnemnonic[2].equals("%D")) 
	    			return "0010";
	    		else if(mnemnonic[2].equals("(%A)")) 
	    			return "0001";
    		}
    		else if(mnemnonic[0]=="movw") {
    			if(mnemnonic[2].equals("%A")) {
    				if(mnemnonic[3].equals("%A")) 
    	    			return "1000";
    	    		else if(mnemnonic[3].equals("%S")) 
    	    			return "1100";
    	    		else if(mnemnonic[3].equals("%D")) 
    	    			return "1010";
    	    		else if(mnemnonic[3].equals("(%A)")) 
    	    			return "1001";
    			}
    			else if(mnemnonic[2].equals("%S")) {
    				if(mnemnonic[3].equals("%A")) 
    	    			return "1100";
    	    		else if(mnemnonic[3].equals("%S")) 
    	    			return "0100";
    	    		else if(mnemnonic[3].equals("%D")) 
    	    			return "0110";
    	    		else if(mnemnonic[3].equals("(%A)")) 
    	    			return "0101";
    			}
    			else if(mnemnonic[2].equals("%D")) {
    				if(mnemnonic[3].equals("%A")) 
    	    			return "1010";
    	    		else if(mnemnonic[3].equals("%S")) 
    	    			return "0110";
    	    		else if(mnemnonic[3].equals("%D")) 
    	    			return "0010";
    	    		else if(mnemnonic[3].equals("(%A)")) 
    	    			return "0011";
    			}
    			else {
    				if(mnemnonic[3].equals("%A")) 
    	    			return "1001";
    	    		else if(mnemnonic[3].equals("%S")) 
    	    			return "0101";
    	    		else if(mnemnonic[3].equals("%D")) 
    	    			return "0011";
    	    		else if(mnemnonic[3].equals("(%A)")) 
    	    			return "0001";
    			}
    			
    		}
    		else {
    			if(mnemnonic[3].equals("%A")) 
	    			return "1000";
	    		else if(mnemnonic[3].equals("%S")) 
	    			return "0100";
	    		else if(mnemnonic[3].equals("%D")) 
	    			return "0010";
	    		else if(mnemnonic[3].equals("(%A)")) 
	    			return "0001";
    		}
	    		
    	}





    	return null;
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public static String comp(String[] mnemnonic) {
    	String binAB = "000";
        // A e B
    	 
        if (mnemnonic.length > 2){
          if ((mnemnonic[1].equals("%S") && mnemnonic[2].equals("%A"))|| 
        		  (mnemnonic[1].equals("%A") && mnemnonic[2].equals("%S")))  
        	  binAB = "001";
        	  //binAB[1] = "0";
        	  //binAB[2] = "1";
          
        	  
          if ((mnemnonic[1].equals("%S") && mnemnonic[2].equals("(%A)"))||
        		  (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%S"))) 
        	  binAB = "011";
        	  //binAB[1] = "1";
        	  //binAB[2] = "1";                            
          
        		                                                                    
          if ((mnemnonic[1].equals("%S") && mnemnonic[2].equals("%D"))|| 
        		  (mnemnonic[1].equals("%D") && mnemnonic[2].equals("%S"))) 
        	  binAB = "100";
        	  //binAB[1] = "0";
        	  //binAB[2] = "0";
          
          if ((mnemnonic[1].equals("%D") && mnemnonic[2].equals("(%A)"))||
        		  (mnemnonic[1].equals("(%A)") && mnemnonic[2].equals("%D"))) 
        	  binAB = "010";
        	  //binAB[1] = "1";
        	  //binAB[2] = "0"; 
          if (mnemnonic[2].equals("$0") || mnemnonic[2].equals("$1")) {
        	  if (mnemnonic[1].equals("(%A)")) binAB = "010";
        	  if (mnemnonic[1].equals("%S")) binAB = "001";  
          }

        }
        else if (mnemnonic.length == 2){
          if (mnemnonic[1].equals("(%A)")) binAB = "010";
          if (mnemnonic[1].equals("%S")) binAB = "001";
        }

        // Or
        if (mnemnonic[0].equals("orw")){
          String out = String.valueOf(binAB);
          return out+"010101";
        }

        // Add
        if (mnemnonic[0].equals("addw")){
          String out = String.valueOf(binAB);
          return out+"000010";
        }

        // And
        if (mnemnonic[0].equals("andw")){
          String out = String.valueOf(binAB);
          return out+"000000";
        }

        // Not
        if (mnemnonic[0].equals("notw")){
          String out = String.valueOf(binAB);
          if (mnemnonic[1].contains("%A")) return out+"110001";
          else return out+"001101";
        }

        // Movw
        if (mnemnonic[0].equals("movw")){
          String out = String.valueOf(binAB);
          if (mnemnonic[1].equals("%S")) {
        	  out = "001";
          }
          if (mnemnonic[1].equals("(%A)")) {
        	  out = "010";
          }
          if (mnemnonic[1].equals("%A")) {
        	  out = "000";
          }
          if (mnemnonic[1].equals("%D")) {
        	  out = "000";
          }
          if (mnemnonic[1].contains("%A") || mnemnonic[1].contains("(%A)")) return out+"110000";
          else return out + "001100";
        }

        // Inc
        if (mnemnonic[0].equals("incw")){
          String out = String.valueOf(binAB);
          if (mnemnonic[1].contains("%A"))return out+"110111";
          else return out+"011111";
        }

        // Dec
        if (mnemnonic[0].equals("decw")){
          String out = String.valueOf(binAB);
          if (mnemnonic[1].contains("%A")) return out+"110010";
          if (mnemnonic[1].contains("(%A)")) return out+"110010";
          else return out+"001110";
        }

        // Neg
        if (mnemnonic[0].equals("negw")){
          String out = String.valueOf(binAB);
          if (mnemnonic[1].contains("%A")) return out+"110011";
          else return out+"001111";
        }

        // Sub
        if (mnemnonic[0].equals("subw")){
          String out = String.valueOf(binAB);
          if (mnemnonic[1].equals("%D") || mnemnonic[1].equals("%S")) {
              if (( mnemnonic[2].equals("$1"))){
            	  return out+"001110";
              }
              if ((mnemnonic[1].equals("%D") && mnemnonic[2].equals("%S"))) {
            	  return out+"000111";
              }
        	  return out+"010011";
          }
          if (mnemnonic[1].equals("%A") || mnemnonic[1].equals("(%A)")) {
              if (( mnemnonic[2].equals("$1"))){
            	  return out+"110010";
              }
        	  return out+"000111";
          }
          if ((mnemnonic[1].equals("%S") && mnemnonic[2].equals("%D"))){
        	  return out+"010011";
          }

    
          
        }

        // rSub
        if (mnemnonic[0].equals("rsubw")){
          String out = String.valueOf(binAB);
          return out+"000111";
        }
        String out = String.valueOf(binAB);
        if(mnemnonic[0].equals("jmp")) return out+"001100";
		else if(mnemnonic[0].equals("je")) return out+"001100";
		else if(mnemnonic[0].equals("jne")) return out+"001100";
		else if(mnemnonic[0].equals("jg")) return out+"001100";
		else if(mnemnonic[0].equals("jge")) return out+"001100";
		else if(mnemnonic[0].equals("jl")) return out+"001100";
		else if(mnemnonic[0].equals("jle")) return out+"001100";
        
        return "000000000";
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
       /** 
        * Verifica se  JUMP
        */
   	if(mnemnonic.length > 2)return "000";
    /** 
     * Qual JUMP
     */
	for (int i = mnemnonic.length; i == 1;){
		if(mnemnonic[0].equals("jmp")) return "111";
		else if(mnemnonic[0].equals("je")) return "010";
		else if(mnemnonic[0].equals("jne")) return "101";
		else if(mnemnonic[0].equals("jg")) return "001";
		else if(mnemnonic[0].equals("jge")) return "011";
		else if(mnemnonic[0].equals("jl")) return "100";
		else if(mnemnonic[0].equals("jle")) return "110";
		else if(mnemnonic[0].equals("nop")) return "000";
	}
	return "000";
    }

    /**
     * Retorna o código binário de um valor decimal armazenado numa String.
     * @param  symbol valor numérico decimal armazenado em uma String.
     * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
     */
    public static String toBinary(String symbol) {
        int Num = Integer.parseInt(symbol);
        String Binary = new String();
        ArrayList<String> L = new ArrayList<String>();
        int i = 0;
        while(Num >= 0 && i==0) {
        	if(Num <=1) {
            	L.add(Integer.toString(Num % 2));
    			i++;
        	}

        	else {
            	L.add(Integer.toString(Num % 2));
            	Num /= 2;
    			}
        }

        Binary = String.join("", L);
        StringBuilder jj = new StringBuilder(Binary).reverse();
        String F = new String(jj).toString();
        while(F.length() < 16){
            F = "0" + F;
    }	
        System.out.println(F);
    	return F;
    }

}
