package dao;

import db.DBConnection;
import model.Place;

import java.sql.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * PlaceDAO - Data Access Object for Place operations via JDBC.
 */
public class PlaceDAO {

    /** Get all places for a given city. */
    public List<Place> getPlacesByCity(int cityId) throws SQLException {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT id, city_id, name, description, entry_fee, timings " +
                     "FROM places WHERE city_id = ? ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cityId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    places.add(mapRow(rs));
                }
            }
        }
        return places;
    }

    /** Get places for a city sorted by entry fee (ascending) using Java Stream API. */
    public List<Place> getPlacesSortedByFee(int cityId) throws SQLException {
        return getPlacesByCity(cityId)
                .stream()
                .sorted(Comparator.comparingDouble(Place::getEntryFee))
                .collect(Collectors.toList());
    }

    /** Get only free-entry places for a city. */
    public List<Place> getFreePlaces(int cityId) throws SQLException {
        return getPlacesByCity(cityId)
                .stream()
                .filter(p -> p.getEntryFee() == 0)
                .collect(Collectors.toList());
    }

    /** Insert a new place. */
    public void addPlace(Place place) throws SQLException {
        String sql = "INSERT INTO places (city_id, name, description, entry_fee, timings) VALUES (?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, place.getCityId());
            ps.setString(2, place.getName());
            ps.setString(3, place.getDescription());
            ps.setDouble(4, place.getEntryFee());
            ps.setString(5, place.getTimings());
            ps.executeUpdate();
        }
    }

    private Place mapRow(ResultSet rs) throws SQLException {
        return new Place(
            rs.getInt("id"),
            rs.getInt("city_id"),
            rs.getString("name"),
            rs.getString("description"),
            rs.getDouble("entry_fee"),
            rs.getString("timings")
        );
    }
}
