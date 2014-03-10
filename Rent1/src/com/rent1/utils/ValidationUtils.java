package com.rent1.utils;

import java.util.Random;

public class ValidationUtils {

	public static boolean isEmailValid(String email) {
		if (isStringBlank(email)) {
			return false;
		}
		int atpos = email.indexOf("@");
		int dotpos = email.lastIndexOf(".");
		if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length()) {
			return false;
		}
		return true;
	}

	public static boolean isStringBlank(String password) {
		if (password == null || password.equals("")) {
			return true;
		}
		return false;
	}

	public static boolean isStringMatching(String password, String confirmPass) {
		if (password.equals(confirmPass)) {
			return true;
		}
		return false;
	}

	public static int randInt(int min, int max) {

	    // Usually this can be a field rather than a method variable
	    Random rand = new Random();

	    // nextInt is normally exclusive of the top value,
	    // so add 1 to make it inclusive
	    int randomNum = rand.nextInt((max - min) + 1) + min;

	    return randomNum;
	}
}
