package com.rent1.utils;

import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.core.LowerCaseFilter;
import org.apache.lucene.analysis.standard.StandardTokenizer;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.util.Version;

import com.google.common.collect.Sets;

/**
 * Some tools for working with strings. Named so as not to conflict with apache
 * commons StringUtils.
 */
public class StringUtils2 {
	private static final Logger log = Logger.getLogger(StringUtils2.class);

	/**
	 * Uses lucene tokenizer to create a set of lowercase token words
	 * 
	 * @throws Exception
	 */
	public static Set<String> tokenize(String input) throws Exception {
		try {

			TokenStream tok = new StandardTokenizer(Version.LUCENE_47,
					new StringReader(input));
			tok = new LowerCaseFilter(Version.LUCENE_47, tok);

			Set<String> result = Sets.newHashSet();

			CharTermAttribute termAttr = (CharTermAttribute) tok
					.addAttribute(CharTermAttribute.class);

			tok.reset();
			while (tok.incrementToken()) {
				String term = termAttr.toString();
				result.add(term);
			}
			tok.close();

			return result;
		} catch (IOException ex) {
			log.error(ex.getMessage());
			throw new Exception(ex);
		}
	}

	/**
	 * Returns a trimmed string or null if trimming produces an empty string.
	 * Also produces null if input is null.
	 */
	public static String trimToNull(String value) {
		if (value == null)
			return null;

		value = value.trim();

		if (value.isEmpty())
			return null;
		else
			return value;
	}

	/**
	 * Throws exception if value is null or empty or whitespace.
	 * 
	 * @return the trimmed, safe version of the string
	 */
	public static String requireNotBlank(String value) {
		if (value == null)
			throw new IllegalArgumentException("Value cannot be null");

		value = value.trim();

		if (value.length() == 0)
			throw new IllegalArgumentException("Value cannot be blank");

		return value;
	}

	/**
	 * Splits names into fragments. Does not modify case. For example, the
	 * strings ["foo", "bar"] would become: "f", "fo", "foo", "b", "ba", "bar"
	 */
	public static Set<String> breakdownFragments(Collection<String> names) {
		Set<String> into = new HashSet<String>(100);

		for (String token : names)
			for (int i = 1; i <= token.length(); i++)
				into.add(token.substring(0, i));

		return into;
	}

	/**
	 * Takes a normal string and turns it into something suitable for a title in
	 * a URL. This is all about SEO. Basically, spaces go to dash and anything
	 * that isn't URL-friendly gets stripped out.
	 */
	public static String makeTitle(String title) {
		if (title == null)
			return "";

		StringBuilder bld = new StringBuilder();

		for (int i = 0; i < title.length(); i++) {
			char ch = title.charAt(i);

			if (Character.isWhitespace(ch))
				bld.append('-');
			else if (Character.isLetterOrDigit(ch))
				bld.append(ch);

			// otherwise skip
		}

		// Strip out any extra -'s that might get generated
		String dedup = bld.toString().replaceAll("-+", "-");
		if (dedup.charAt(dedup.length() - 1) == '-') {
			return dedup.substring(0, dedup.length() - 1);
		}
		return dedup;
	}

	/**
	 * Without the stupid exception
	 */
	public static byte[] getBytes(String str, String encoding) {
		try {
			return str.getBytes(encoding);
		} catch (UnsupportedEncodingException ex) {
			throw new RuntimeException(ex);
		}
	}

	/**
	 * Without the stupid exception
	 */
	public static byte[] getBytesUTF8(String str) {
		return getBytes(str, "UTF-8");
	}

	/**
	 * Without the stupid exception
	 */
	public static String newString(byte[] bytes, String encoding) {
		try {
			return new String(bytes, encoding);
		} catch (UnsupportedEncodingException ex) {
			throw new RuntimeException(ex);
		}
	}

	/**
	 * Without the stupid exception
	 */
	public static String newStringUTF8(byte[] bytes) {
		return newString(bytes, "UTF-8");
	}

	/**
	 * Adds "\ufffd" to the string, creating a trailing boundary for a leading
	 * search. Ie, if you want everything that starts with "foo", you filter
	 * value >= "foo" and value <= "foo\ufffd"
	 */
	public static String makeFilterTail(String input) {
		return input + "\ufffd";
	}

	public static String priceToString(Double price) {
		DecimalFormat formatter = new DecimalFormat("###,###,###.00");
		return formatter.format(price);
	}
}
