package com.rent1.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.logging.impl.Log4JLogger;

public class SQLUtils {
	private static Log4JLogger log = new Log4JLogger(SQLUtils.class.getName());

	public static void closeQuietly(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			log.error("An error occurred closing connection.", e);
		}
	}

	public static void closeQuietly(Statement statement) {
		try {
			if (statement != null) {
				statement.close();
			}
		} catch (SQLException e) {
			log.error("An error occurred closing statement.", e);
		}
	}

	public static void closeQuietly(ResultSet resultSet) {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
		} catch (SQLException e) {
			log.error("An error occurred closing result set.", e);
		}
	}
}
