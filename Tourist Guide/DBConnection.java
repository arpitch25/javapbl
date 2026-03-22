package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - manages JDBC connection to MySQL database.
 * Uses singleton-style static method for reuse across DAOs.
 */
public class DBConnection {

    private static final String URL      = "jdbc:mysql://localhost:3306/tourist_guide?useSSL=false&serverTimezone=UTC";
    private static final String USER     = "root";
    private static final String PASSWORD = "arpit@2505";

    // Load the MySQL driver once when class is loaded
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found!", e);
        }
    }

    /**
     * Returns a new JDBC connection. Caller is responsible for closing it.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
