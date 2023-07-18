package com.test;

public class CodingTest {

	public static void main(String[] args) {

		String[] players = {"a", "b", "c", "4", "5"};
		String[] callings = {"4", "5"};
		
		for(int i=0;i<players.length;i++) {
            
            for(int j=0;j<callings.length;j++) {
                
                if(players[i].equals(callings[j])) {
                    String temp = players[i-1];
                    players[i-1] = players[i];
                    players[i] = temp;
                }
            }
        }
		
		System.out.println(players);
	}

}
