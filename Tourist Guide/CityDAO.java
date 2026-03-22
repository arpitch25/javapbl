package dao;

import db.DBConnection;
import model.City;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CityDAO - Data Access Object for City operations via JDBC.
 */
public class CityDAO {

    /** Retrieve all cities ordered by name. */
    public List<City> getAllCities() throws SQLException {
        List<City> cities = new ArrayList<>();
        String sql = "SELECT id, name, theme, history, highlight, badge_class FROM cities ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                cities.add(mapRow(rs));
            }
        }
        return cities;
    }

    /** Retrieve a single city by its ID. Returns null if not found. */
    public City getCityById(int id) throws SQLException {
        String sql = "SELECT id, name, theme, history, highlight, badge_class FROM cities WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    /** Search cities by name (case-insensitive partial match). */
    public List<City> searchCities(String keyword) throws SQLException {
        List<City> cities = new ArrayList<>();
        String sql = "SELECT id, name, theme, history, highlight, badge_class FROM cities " +
                     "WHERE LOWER(name) LIKE ? OR LOWER(theme) LIKE ? ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String pattern = "%" + keyword.toLowerCase() + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cities.add(mapRow(rs));
                }
            }
        }
        return cities;
    }

    /** Insert a new city. Returns generated ID. */
    public int addCity(City city) throws SQLException {
        String sql = "INSERT INTO cities (name, theme, history, highlight, badge_class) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, city.getName());
            ps.setString(2, city.getTheme());
            ps.setString(3, city.getHistory());
            ps.setString(4, city.getHighlight());
            ps.setString(5, city.getBadgeClass());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    private City mapRow(ResultSet rs) throws SQLException {
        return new City(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("theme"),
            rs.getString("history"),
            rs.getString("highlight"),
            rs.getString("badge_class")
        );
    }
}
