package com.cwb.finalproject.common;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.Base64.Decoder;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AES256Util {
	private String iv;
	private Key keySpec;
	public static final String KEY = "aes256-test-key!!";
	
	public AES256Util(String key) throws UnsupportedEncodingException {
		this.iv = key.substring(0,16);
		
		byte[] keyBytes = new byte[16];
		byte[] b = key.getBytes("UTF-8");
		int length = b.length;
		
		if(length > keyBytes.length) {
			length = keyBytes.length;
		}
		
		System.arraycopy(b, 0, keyBytes, 0, length);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		
		this.keySpec = keySpec;
	}
	
	public String aesEncode(String str) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
		
		byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
		Encoder encoder = Base64.getEncoder();
		
		String enStr = new String(encoder.encode(encrypted));
		return enStr;
	}
	
	public String aesDecode(String str) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException {
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, keySpec,new IvParameterSpec(iv.getBytes()));
		
		Decoder decoder = Base64.getDecoder();
		byte[] byteStr = decoder.decode(str.getBytes());
		
		return new String(c.doFinal(byteStr),"UTF-8");
	}
}
