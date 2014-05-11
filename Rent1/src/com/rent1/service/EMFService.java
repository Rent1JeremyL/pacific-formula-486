package com.rent1.service;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Entity Manager Factory Service 
 * JPA NOT IN USE
 * 
 * @author Jeremy Leeder
 * @deprecated
 */
public class EMFService {
	private static final EntityManagerFactory emfInstance = Persistence
			.createEntityManagerFactory("transactions-optional");

	private EMFService() {
	}

	public static EntityManagerFactory getInstance() {
		return emfInstance;
	}
}
