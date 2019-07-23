package com.cwb.finalproject.common;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class WebUtility {
	public static final int BLOCK_SIZE=10;	//페이징 개수
	public static int RECORD_COUNT_PER_PAGE=5;	//페이지당 데이터 개수
	public static final int RES_BLOCK_SIZE=5; //자원 페이징 개수
	
	public String createRandomString() {
		StringBuffer tmp = new StringBuffer();
		Random random = new Random();
		
		for(int i = 0; i < 20; i++) {
			int randIndex = random.nextInt(3); // 0 ~ 2;
			if(randIndex == 0) {
				tmp.append((char)(random.nextInt(26)+97)); // 97 ~ 122 => a to z
			}else if(randIndex == 1) {
				tmp.append((char)(random.nextInt(26)+65)); // 65 ~ 90 => A to Z
			}else if(randIndex == 2) {
				tmp.append((char)(random.nextInt(10)+48)); // 48 ~ 57 => 0 to 9
			}
		}
		
		return tmp.toString();
	}
}
