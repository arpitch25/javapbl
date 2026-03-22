package dao;

import db.DBConnection;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDAO - Data Access Object for Product (fair price) operations via JDBC.
 */
public class ProductDAO {

    /** Get all products for a given city. */
    public List<Product> getProductsByCity(int cityId) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, city_id, product_name, fair_price, unit, notes " +
                     "FROM products WHERE city_id = ? ORDER BY product_name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cityId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        }
        return products;
    }

    /** Get products under a given max price. */
    public List<Product> getAffordableProducts(int cityId, double maxPrice) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, city_id, product_name, fair_price, unit, notes " +
                     "FROM products WHERE city_id = ? AND fair_price <= ? ORDER BY fair_price";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cityId);
            ps.setDouble(2, maxPrice);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(mapRow(rs));
                }
            }
        }
        return products;
    }

    /** Insert a new product. */
    public void addProduct(Product product) throws SQLException {
        String sql = "INSERT INTO products (city_id, product_name, fair_price, unit, notes) VALUES (?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, product.getCityId());
            ps.setString(2, product.getProductName());
            ps.setDouble(3, product.getFairPrice());
            ps.setString(4, product.getUnit());
            ps.setString(5, product.getNotes());
            ps.executeUpdate();
        }
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        return new Product(
            rs.getInt("id"),
            rs.getInt("city_id"),
            rs.getString("product_name"),
            rs.getDouble("fair_price"),
            rs.getString("unit"),
            rs.getString("notes")
        );
    }
}
