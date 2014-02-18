package com.rent1.utils;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Config {
	private ClassPathXmlApplicationContext context = null;
	private static Config uniqueInstance = null;

	protected ClassPathXmlApplicationContext getSpringBeanFactory() {
		if (context != null) {
			return context;
		}
		context = new ClassPathXmlApplicationContext("conf/spring-config.xml");
		return context;
	}

	public Config() {
	}

	public static Config getInstance() {
		if (uniqueInstance == null) {
			uniqueInstance = new Config();
		}

		return uniqueInstance;
	}
}
