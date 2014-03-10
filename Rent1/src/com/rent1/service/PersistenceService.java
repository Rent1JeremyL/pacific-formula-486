package com.rent1.service;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManagerFactory;

/**
 * Entity Manager Factory Service
 * JDO
 * NOT IN USE
 * 
 * @author Jeremy Leeder
 *
 */
public class PersistenceService {
	//For JAVAX Persistence META-INF/persistence.xml
	//private static final EntityManagerFactory emfInstance = Persistence
	//		.createEntityManagerFactory("transactions-optional");

	// For JDO Persistence META-INF/jdoconfig.xml
	private static final PersistenceManagerFactory pmfInstance =
	        JDOHelper.getPersistenceManagerFactory("transactions-optional");

	private PersistenceService() {
	}

	/*
	 * Get a static EMF
	 * @return a static Entity Manager Factory
	 
	public static EntityManagerFactory getInstance() {
		return emfInstance;
	}
	*/
	
	public static PersistenceManagerFactory getInstance(){
		return pmfInstance;
	}
}
